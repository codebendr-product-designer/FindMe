//
//  Group.swift
//  FindMe
//
//  Created by codebendr on 23/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import Foundation

struct EmployeeGroup: Comparable {
    var section: String
    var employee: [Employee]
    
    static func <(lhs: EmployeeGroup, rhs: EmployeeGroup) -> Bool {
        return lhs.section < rhs.section
    }
    
    static func ==(lhs: EmployeeGroup, rhs: EmployeeGroup) -> Bool {
        return lhs.section == rhs.section
    }
}
