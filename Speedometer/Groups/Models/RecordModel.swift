//
//  RecordModel.swift
//  Speedometer
//
//  Created by Maks Tsarevich on 14.06.21.
//  Copyright © 2021 denby. All rights reserved.
//

import Foundation
import RealmSwift

class RecordModel: Object{
    
    @objc dynamic var timeFor60 = ""
    @objc dynamic var timeFor100 = ""
    @objc dynamic var timeFor150 = ""
    
    @objc dynamic var id = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
