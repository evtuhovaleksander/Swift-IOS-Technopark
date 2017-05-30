//
//  ValidatorHelper.swift
//  RAT
//
//  Created by Kirill on 3/24/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit

class ValidatorHelper: NSObject {
    
    class func isPasswordCorrect(_ value:String) -> Bool {
        
        let passwordRegExp = "[A-Za-z0-9]{8,24}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegExp)
        return passwordTest.evaluate(with: value)
        
    }
    
    class func isEmailCorrect(_ value:String) -> Bool {
        
        let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
        return emailTest.evaluate(with: value)
        
    }
    
    class func isPhoneCorrect(_ value:String) -> Bool {
        
        let phoneRegExp = "[0-9]{11}"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegExp)
        return phoneTest.evaluate(with: value)
        
    }
    
    class func isPasswordEquel(password: String, repeatPassword: String) -> Bool{
        return password == repeatPassword
    }
    
}
