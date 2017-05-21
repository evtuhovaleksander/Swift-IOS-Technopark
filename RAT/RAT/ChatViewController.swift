//
//  ChatViewController.swift
//  RAT
//
//  Created by Алексаndr on 21.05.17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var offer = Offer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func viewServiceInfoButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ToServiceInfo", sender: nil)
    }
    @IBAction func veiwConfirmButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ToConfirm", sender: nil)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToServiceInfo"{
            let serviceController = segue.destination as! ServiceViewController
            serviceController.service = offer.service!
        }
        else{
            let confirmController = segue.destination as! ConfirmViewController
            confirmController.offer = offer
        }
    }
    
        
        
    

}
