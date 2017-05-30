//
//  RegistrationViewController.swift
//  RAT
//
//  Created by Kirill on 3/17/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit
import RealmSwift

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    let person = Person()
    
    @IBAction func signUp(_ sender: Any) {
       
        /*
        person.email = emailTextField.text!
        person.password = passwordTextField.text!
        person.firstname = firstnameTextField.text!
        person.lastname = lastnameTextField.text!
        person.phone = phoneTextField.text!
        */

        person.email = "user@mail.ru"
        person.password = "qwerty"
        person.firstname = "user"
        person.lastname = "userovich"
        person.phone = "88005553535"
        
        APIHelper.signUpRequest(person: person)
    }
    
    func signUpCallback(_ notification: NSNotification){
        APIHelper.logInRequest(person: person)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        emailTextField.backgroundColor = UIColor(white: 1, alpha: 0)
        emailTextField.borderStyle = UITextBorderStyle(rawValue: 0)!
       
        passwordTextField.backgroundColor = UIColor(white: 1, alpha: 0)
        passwordTextField.borderStyle = UITextBorderStyle(rawValue: 0)!
 
        repeatPasswordTextField.backgroundColor = UIColor(white: 1, alpha: 0)
        repeatPasswordTextField.borderStyle = UITextBorderStyle(rawValue: 0)!
        
        phoneTextField.backgroundColor = UIColor(white: 1, alpha: 0)
        phoneTextField.borderStyle = UITextBorderStyle(rawValue: 0)!
        
        lastnameTextField.backgroundColor = UIColor(white: 1, alpha: 0)
        lastnameTextField.borderStyle = UITextBorderStyle(rawValue: 0)!
        
        firstnameTextField.backgroundColor = UIColor(white: 1, alpha: 0)
        firstnameTextField.borderStyle = UITextBorderStyle(rawValue: 0)!
        
        NotificationCenter.default.addObserver(self, selector: #selector(signUpCallback), name: .signUpCallback, object: nil)
        
    }
}
