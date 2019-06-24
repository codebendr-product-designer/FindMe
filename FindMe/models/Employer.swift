//
//  Employer.swift
//  FindMe
//
//  Created by codebendr on 18/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import Foundation

struct Employer: Codable {
    let employees: [Employee]
    
    enum CodingKeys: String, CodingKey {
        case employees
    }
    
}
