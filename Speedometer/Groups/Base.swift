//
//  Base.swift
//  Speedometer
//
//  Created by Maks Tsarevich on 19.03.21.
//  Copyright © 2021 denby. All rights reserved.
//

import Foundation

var defaults = UserDefaults.standard

class Base{
    
    static func registerDefaults(){
        defaults.register(defaults: [
                            kIsSegment1: 0,
                            kIsSegment2: 1,
                            kIsSegment3: 2
        ])
    }
    
    static let kIsSegment1 = "Segment1"
    static var isSegment1Selected: Bool{
        get {return defaults.value(forKey: kIsSegment1) as! Bool}
        set {defaults.set(newValue, forKey: kIsSegment1)}
    }

    static let kIsSegment2 = "Segment2"
    static var isSegment2Selected: Bool{
        get {return defaults.value(forKey: kIsSegment2) as! Bool}
        set {defaults.set(newValue, forKey: kIsSegment2)}
    }

    static let kIsSegment3 = "Segment3"
    static var isSegment3Selected: Bool{
        get {return defaults.value(forKey: kIsSegment3) as! Bool}
        set {defaults.set(newValue, forKey: kIsSegment3)}
    }
}
