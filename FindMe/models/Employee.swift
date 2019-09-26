//
//  Employee.swift
//  FindMe
//
//  Created by codebendr on 18/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import Foundation
import CoreData
/*
 {
 “fname”: Peeter,
 “lname”: Termomeeter,
 “contact_details”: {
 “email”: “peeter@telisa.ee”,
 “phone”: “55 555 555” (optional),
 },
 “position”: IOS|ANDROID|WEB|PM|TESTER|SALES|OTHER,
 “projects”: [“MyCoolApp”, “OneTimeThing”] (optional)
 }
 */

struct Employee: Codable, Comparable {
    var firstName: String
    var lastName: String
    var contactDetails: Contact
    var position: String
    var projects:[String]?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "fname"
        case lastName = "lname"
        case contactDetails = "contact_details"
        case position
        case projects
    }

    static func <(lhs: Employee, rhs: Employee) -> Bool {
        return lhs.lastName < rhs.lastName
    }
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.lastName == rhs.lastName && lhs.firstName == rhs.firstName
    }
    
}

