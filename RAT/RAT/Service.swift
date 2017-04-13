//
//  Service.swift
//  RAT
//
//  Created by Kirill on 3/29/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import Foundation
import RealmSwift

class Service: Object {
    dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
