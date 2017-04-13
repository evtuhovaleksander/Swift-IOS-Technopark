//
//  Notification+Name.swift
//  RAT
//
//  Created by Kirill on 4/4/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let signUpCallback = Notification.Name("signUpCallback")
    static let logInCallback = Notification.Name("logInCallback")
    static let getVehiclesCallback = Notification.Name("getVehiclesCallback")
    static let getListOfCrashesCallback = Notification.Name("getListOfCrashesCallback")
}
