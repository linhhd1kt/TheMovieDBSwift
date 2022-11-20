//
//  Elevation.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/11/2022.
//

protocol ElevationType {
    var level0: Int { get }
    var level1: Int { get }
    var level2: Int { get }
    var level3: Int { get }
    var level4: Int { get }
    var level5: Int { get }
}

struct DefaultElevation: ElevationType {
    let level0 = 0
    let level1 = 1
    let level2 = 2
    let level3 = 3
    let level4 = 4
    let level5 = 5 
}
