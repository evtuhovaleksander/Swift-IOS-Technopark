//
//  ListOfCrashesViewController.swift
//  RAT
//
//  Created by Kirill on 3/18/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListOfCrashesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum TypeCrash{
        case actual, history
    }

    @IBOutlet weak var chooseListOfCrashesSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var listOfCrashesTable: UITableView!
    var vehicle = Vehicle()
    var actualCrashes: [Crash] = []
    var historyCrashes: [Crash] = []
    var nowTypeCrash : TypeCrash = .actual
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfCrashesTable.dataSource = self
        listOfCrashesTable.delegate = self
        listOfCrashesTable.tableFooterView = UIView() // delete excess separators
        NotificationCenter.default.addObserver(self, selector: #selector(getListOfCrashesCallback(_:)), name: .getListOfCrashesCallback, object: nil)
        actualCrashes = vehicle.getActualcrashes()
        historyCrashes = vehicle.getHistorycrashes()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch nowTypeCrash {
        case .actual:
            return actualCrashes.count
        case .history:
            return historyCrashes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = listOfCrashesTable.dequeueReusableCell(withIdentifier: "CrashCell") as! CrashCell
        let index = indexPath.row
        
        switch nowTypeCrash {
        case .actual:
            cell.code.text = actualCrashes[index].code
            cell.shortDecription.text = actualCrashes[index].shortDescription
        case .history:
            cell.code.text = historyCrashes[index].code
            cell.shortDecription.text = historyCrashes[index].shortDescription
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        var crash = Crash()
        switch nowTypeCrash {
        case .actual:
            crash = actualCrashes[index]
        case .history:
            crash = historyCrashes[index]
        }
        APIHelper.getListOfOffersRequest(crash: crash)
        self.performSegue(withIdentifier: "fromListOfCrashesToCrashSegue", sender: crash)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! CrashViewController
        destinationController.crash = sender as! Crash
    }
    
    
    func getListOfCrashesCallback(_ notification: NSNotification){
        
        let data = notification.userInfo as! [String : JSON]
        let crashes = data["data"]!.arrayValue
        for crash in crashes {
            DataBaseHelper.setCrash(vehicle: vehicle, json: crash)
        }
        historyCrashes = vehicle.getHistorycrashes()
        actualCrashes = vehicle.getActualcrashes()
        self.listOfCrashesTable.reloadData()
        
    }
    

 
}
