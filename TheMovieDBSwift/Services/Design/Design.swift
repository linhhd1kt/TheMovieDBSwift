//
//  Design.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

import UIKit
import ObjectiveC

protocol Designable {
    var style: StyleType { get }
    func toggleTheme()
}

struct DefautDesign: Designable {
    let style: StyleType = LightStyle()
    private var preferences: PreferencesStorable {
        guard let preference = ServiceFacade.getService(PreferencesStorable.self) else {
            fatalError("User preferences should be initilized!")
        }
        return preference
    }
    
    init() {
        if let rawSaveInterfaceStyle = UserDefaults.standard.value(forKey: "user-interface-style") as? Int,
           let saveInterfaceStyle: UIUserInterfaceStyle = .init(rawValue: rawSaveInterfaceStyle) {
            self.setTheme(saveInterfaceStyle)
        }
    }
    
    func toggleTheme() {
        var interfaceStyle: UIUserInterfaceStyle
        if let rawSaveInterfaceStyle = UserDefaults.standard.value(forKey: "user-interface-style") as? Int,
           let saveInterfaceStyle: UIUserInterfaceStyle = .init(rawValue: rawSaveInterfaceStyle) {
            switch saveInterfaceStyle {
            case .unspecified:
                interfaceStyle = .light
            case .light:
                interfaceStyle = .dark
            case .dark:
                interfaceStyle = .light
            @unknown default:
                interfaceStyle = .light
            }
        } else {
            interfaceStyle = .light
        }
        UserDefaults.standard.set(interfaceStyle.rawValue, forKey: "user-interface-style")
        setTheme(interfaceStyle)
    }
    
    func setTheme(_ style: UIUserInterfaceStyle) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.overrideUserInterfaceStyle = style
    }
}

private var designContext: UInt8 = 1

protocol HasDeSign: AnyObject {
    var design: Designable { get set }
}

extension HasDeSign {
    // swiftlint:disable type_contents_order
    func synchronizedDesign<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }

    var design: Designable {
        get {
            return synchronizedDesign {
                if let designObject = objc_getAssociatedObject(self, &designContext) as? Designable {
                    return designObject
                }
                let designObject = DefautDesign()
                objc_setAssociatedObject(self, &designContext, designObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return designObject
            }
        }

        set {
            synchronizedDesign {
                objc_setAssociatedObject(self, &designContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
