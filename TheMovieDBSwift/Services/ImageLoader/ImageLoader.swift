//
//  ImageLoader.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 31/10/2022.
//

import UIKit
import Kingfisher
import RxSwift
import ObjectiveC

protocol ImageLoadable {
    func loadTMDBImage(with id: String?, to imageView: UIImageView)
}

class ImageLoader: ImageLoadable {
    func loadTMDBImage(with id: String?, to imageView: UIImageView) {
        guard let id = id else {
            return
        }
        let imageBaseUrl = URL(string: AppConfiguration().imagesBaseURL)        
        let url = imageBaseUrl?.appendingPathComponent("t/p/w185").appendingPathComponent(id)
        imageView.kf.setImage(with: url)
    }
}

private var imageLoaderContext: UInt8 = 2

protocol HasImageLoader: AnyObject {
    var imageLoader: ImageLoadable { get set }
}

extension HasImageLoader {
    // swiftlint:disable type_contents_order
    func synchronizedImageLoader<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }

    public var imageLoader: ImageLoadable {
        get {
            return synchronizedImageLoader {
                if let imageLoaderObject = objc_getAssociatedObject(self, &imageLoaderContext) as? ImageLoadable {
                    return imageLoaderObject
                }
                let imageLoaderObject = ImageLoader()
                objc_setAssociatedObject(self, &imageLoaderContext, imageLoaderObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return imageLoaderObject
            }
        }

        set {
            synchronizedImageLoader {
                objc_setAssociatedObject(self, &imageLoaderContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
