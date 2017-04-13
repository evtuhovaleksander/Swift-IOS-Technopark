//
//  ViewController.swift
//  RAT
//
//  Created by Kirill on 3/16/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageLabelView: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var registrationLabel: UILabel!
    
    @IBOutlet weak var registrationButton: UIButton!
    
    @IBOutlet weak var vkLogInButton: UIButton!
    
    @IBOutlet weak var facebookLogInButton: UIButton!
    
    @IBAction func logIn(_ sender: Any) {
        // TODO: проверить вводимые поля
        /*
        person.email = emailTextField.text!
        person.password = passwordTextField.text!
         */
        let person = Person()
        person.email = "leoniknik@mail.ru"
        person.password = "1234"
        
        APIHelper.logInRequest(person: person)
        
    }
    
    @IBAction func vkLogIn(_ sender: Any) {
        
    }
    @IBAction func facebookLogIn(_ sender: Any) {
        
    }
    
    func logInCallback(_ notification: NSNotification){
        let person = Person()
        let data = notification.userInfo
        let id = data?["user_id"] as! Int
        let email = data?["email"] as! String
        let firstname = data?["firstname"] as! String
        let lastname = data?["lastname"] as! String
        let phone = data?["phone"] as! String
        DataBaseHelper.clearActualPerson()
        DataBaseHelper.setPerson(person: person, id: id, email: email, firstname: firstname, lastname: lastname, phone: phone, actual: true)
        performSegue(withIdentifier: "fromAuthorizationToListOfVehiclesSegue", sender: person)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(logInCallback(_:)), name: .logInCallback, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromAuthorizationToListOfVehiclesSegue"{
            APIHelper.getListOfVehiclesRequest()
        }
    }

}

