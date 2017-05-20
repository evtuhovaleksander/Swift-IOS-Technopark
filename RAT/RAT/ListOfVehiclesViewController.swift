//
//  ListOfVehiclesViewController.swift
//  RAT
//
//  Created by Kirill on 3/30/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListOfVehiclesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listOfVehiclesTable: UITableView!
    var person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfVehiclesTable.dataSource = self
        listOfVehiclesTable.delegate = self
        // listOfCrashesTable.separatorStyle = .none // delete all separators
        listOfVehiclesTable.tableFooterView = UIView() // delete excess separators
        NotificationCenter.default.addObserver(self, selector: #selector(getListsOfVehiclesAndCrashesCallback(_:)), name: .getListsOfVehiclesAndCrashesCallback, object: nil)
        person = DataBaseHelper.getPerson()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfVehiclesTable.dequeueReusableCell(withIdentifier: "VehicleCell") as! VehicleCell
        let index = indexPath.row
        cell.number.text = person.vehicles[index].number
        cell.brand.text = person.vehicles[index].brand
        cell.model.text = person.vehicles[index].model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let vehicle = person.vehicles[index]
        APIHelper.getListOfActualCrashesRequest(vehicle: vehicle)
        self.performSegue(withIdentifier: "fromListOfVehicleToListOfCrashesSegue", sender: vehicle)
    }
 
//    func getVehiclesCallback(_ notification: NSNotification){
//        let person = DataBaseHelper.getPerson()
//        let data = notification.userInfo as! [String : JSON]
//        let vehicles = data["data"]!.arrayValue
//        for vehicle in vehicles {
//            DataBaseHelper.setVehicle(person: person, json: vehicle)
//        }
//        self.listOfVehiclesTable.reloadData()
//    }
    
    func getListsOfVehiclesAndCrashesCallback(_ notification: NSNotification){
        print("callback aaaa")
        let person = DataBaseHelper.getPerson()
        let data = notification.userInfo as! [String : JSON]
        let jsonVehicles = data["data"]!.arrayValue
        var vehicleIDs = [Int]()
        for jsonVehicle in jsonVehicles {
            let id = jsonVehicle["id"].intValue
            vehicleIDs.append(id)
        }
        DataBaseHelper.deleteVehicles(vehicleIds: vehicleIDs)
        for jsonVehicle in jsonVehicles {
            let vehicle = DataBaseHelper.setVehicle(person: person, json: jsonVehicle)
            
            let jsonCrashes = jsonVehicle["crashes"].arrayValue
            for jsonCrash in jsonCrashes {
                _ = DataBaseHelper.setCrash(vehicle:vehicle, json:jsonCrash)
            }
        }
        listOfVehiclesTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let barViewController = segue.destination as! VehicleTabBarController
        barViewController.vehicle = sender as? Vehicle
        let nav = barViewController.viewControllers![0] as! UINavigationController
        let destinationViewController = nav.viewControllers[0] as! ListOfCrashesViewController
        destinationViewController.vehicle = sender as! Vehicle
        destinationViewController.nowTypeCrash = .actual

    }
}
