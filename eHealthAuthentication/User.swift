//
//  User.swift
//  eHealthAuthentication
//
//  Created by Ioana Bojinca on 01.06.2022.
//

import Foundation

class User {
    var userID: String?
    var phoneNumber: String?
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    func setUserID(id: String) {
        self.userID = id
    }
}
