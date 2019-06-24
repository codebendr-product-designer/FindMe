//
//  EmployeesData+CoreDataProperties.swift
//  FindMe
//
//  Created by codebendr on 20/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeesData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeesData> {
        return NSFetchRequest<EmployeesData>(entityName: "EmployeesData")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var position: String?
    @NSManaged public var projects: [String]?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?

}
