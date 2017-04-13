//
//  Offer.swift
//  RAT
//
//  Created by Kirill on 3/29/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import Foundation
import RealmSwift

class Offer: Object {
    
    dynamic var id: Int = 0
    dynamic var price: Int = 0
    dynamic var message: String = ""
    //dynamic var crash: Crash?
    //dynamic var owner: Service?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
