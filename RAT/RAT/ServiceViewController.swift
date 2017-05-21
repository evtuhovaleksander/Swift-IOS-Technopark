//
//  ServiceViewController.swift
//  RAT
//
//  Created by Kirill on 4/13/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit
import SwiftyJSON

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceDescription: UITextView!
    @IBOutlet weak var listOfReviewsTable: UITableView!
    
    var service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.reviews.count
        //return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listOfReviewsTable.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        let index = indexPath.row
        
        cell.reviewText.text = service.reviews[index].text
        cell.reviewDate.text = service.reviews[index].date
        return cell
    }
    
    
    func getServiceCallback(_ notification: NSNotification){
        let data = notification.userInfo as! [String : JSON]
        let service = data["data"]!
        DataBaseHelper.setService(json: service)
    }
    
    func getListOfReviewsCallback(_ notification: NSNotification){
        let data = notification.userInfo as! [String : JSON]
        let reviews = data["data"]!.arrayValue
        for review in reviews {
            DataBaseHelper.setReview(service: service, json: review)
        }
        self.listOfReviewsTable.reloadData()
        
    }
}
