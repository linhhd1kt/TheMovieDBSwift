//
//  Duration.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

import Foundation

//https://m3.material.io/styles/motion/easing-and-duration/tokens-specs

protocol DurationType {
    var short1: Int { get }
    var short2: Int { get }
    var short3: Int { get }
    var short4: Int { get }
    var medium1: Int { get }
    var medium2: Int { get }
    var medium3: Int { get }
    var medium4: Int { get }
    var long1: Int { get }
    var long2: Int { get }
    var long3: Int { get }
    var long4: Int { get }
    var extraLong1: Int { get }
    var extraLong2: Int { get }
    var extraLong3: Int { get }
    var extraLong4: Int { get }
}

struct DefaultDuration: DurationType {
    let short1 = 50
    let short2 = 100
    let short3 = 150
    let short4 = 200
    let medium1 = 250
    let medium2 = 300
    let medium3 = 350
    let medium4 = 400
    let long1 = 450
    let long2 = 500
    let long3 = 550
    let long4 = 600
    let extraLong1 = 700
    let extraLong2 = 800
    let extraLong3 = 900
    let extraLong4 = 1000
}
