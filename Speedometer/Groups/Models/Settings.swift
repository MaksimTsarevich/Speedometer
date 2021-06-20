//
//  Settings.swift
//  Speedometer
//
//  Created by Maks Tsarevich on 23.03.21.
//  Copyright © 2021 denby. All rights reserved.
//

import Foundation
import RealmSwift

class Settings: Object{
    @objc dynamic var unit = 0
    @objc dynamic var id = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
