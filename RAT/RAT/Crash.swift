//
//  Crash.swift
//  RAT
//
//  Created by Kirill on 3/29/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Crash {
    
    let SERVER_IP="http://192.168.43.120:8000"
    
    let GET_LIST_OF_OFFERS: String
    var id: Int?
    var code: String = ""
    var fullDescription: String = ""
    var shortDescription: String = ""
    var date: String = ""
    
    var arrayOffers = Array<Offer>()
    
    init(){
        GET_LIST_OF_OFFERS = "\(SERVER_IP))"+"/api/get_list_of_offers"
    }
    
    func getListOfOffersRequest() -> Void {
        
        let parameters: Parameters = [
            "crash_id": self.id!
        ]
        
        Alamofire.request(GET_LIST_OF_OFFERS, method: .post, parameters: parameters ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
