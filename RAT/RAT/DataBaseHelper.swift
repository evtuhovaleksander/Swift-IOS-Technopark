//
//  DataBaseHelper.swift
//  RAT
//
//  Created by Kirill on 4/4/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class DataBaseHelper {
    
    static let realm = try! Realm()
    
    class func deleteVehicles(vehicleIds : [Int]){
        let vehicles = DataBaseHelper.getPerson().vehicles
        for vehicle in vehicles{
            let id = vehicle.id
            if !(vehicleIds.contains(id))
            {
                try! realm.write {
                    realm.delete(vehicle)
                }
            }
        }
    }
        
    
    class func setVehicle(person: Person, json: JSON)-> Vehicle{
            let vehicle = Vehicle()
            vehicle.number = json["number"].stringValue
            vehicle.brand = json["brand"].stringValue
            vehicle.VIN = json["VIN"].stringValue
            vehicle.year = json["year"].stringValue
            vehicle.model = json["model"].stringValue
            vehicle.id = json["id"].intValue
            vehicle.owner = person
            save(object: vehicle)
            return vehicle
    }
        
    class func setVehicle(person: Person, vehicle: Vehicle){
            let vehicle = vehicle
            vehicle.owner = person
            save(object: vehicle)
    }
    
    class func setVehicle( vehicle: Vehicle){
            let vehicle = vehicle
            save(object: vehicle)
    }
    
    class func getPerson() -> Person {
        let predicate = NSPredicate(format: "actual == true")
        return realm.objects(Person.self).filter(predicate).first!
    }
    
    
    class func clearActualPerson(){
        let persons = realm.objects(Person.self)
        for person in persons {
            try! realm.write {
                person.actual = false
            }
        }
    }
    
    class func setPerson(person: Person, id: Int, email: String, firstname: String, lastname: String, phone: String, actual: Bool){
            person.id = id
            person.email = email
            person.firstname = firstname
            person.lastname = lastname
            person.phone = phone
            person.actual = actual
            save(object: person)
    }
    
    class func setCrash(vehicle: Vehicle, json: JSON){
        let crash = Crash()
        crash.date = json["date"].stringValue
        crash.shortDescription = json["description__short_description"].stringValue
        crash.fullDescription = json["description__full_description"].stringValue
        crash.code = json["description__code"].stringValue
        crash.id = json["id"].intValue
        crash.actual = json["actual"].boolValue
        crash.vehicle = vehicle
        save(object: crash)
    }
    
    class func setOffer(crash: Crash, json: JSON){
        let offer = Offer()
        let service = Service()
        offer.message = json["message"].stringValue
        offer.price = json["price"].intValue
        offer.id = json["id"].intValue
        offer.crash = crash
        offer.service = service
        offer.service!.id = json["service_id"].intValue
        offer.service!.name = json["service__name"].stringValue
        save(object: service)
        save(object: offer)
    }
    
    class func setService(json: JSON){
        let service = Service()
        service.address = json["address"].stringValue
        service.id = json["id"].intValue
        service.name = json["name"].stringValue
        service.phone = json["phone"].stringValue
        save(object: service)
    }
    
    class func setReview(service: Service, json: JSON){
        let review = Review()
        review.date = json["date"].stringValue
        review.id = json["id"].intValue
        review.text = json["text"].stringValue
        review.service = service
        save(object: review)
    }
    
    class func save(object: Object){
        try! realm.write {
            realm.add(object, update: true)
        }
    }
}
