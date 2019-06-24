//
//  ContactCollectionViewCell.swift
//  FindMe
//
//  Created by codebendr on 20/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhoneNumber: UILabel!
    
    override func prepareForReuse() {
        txtName.text = nil
        txtEmail.text = nil
        txtPhoneNumber.text = nil
    }

    var employee: Employee? {
        didSet {
            if let employee = employee {
             
                txtName.text = "\(employee.lastName) \(employee.firstName)"
                txtEmail.text = employee.contactDetails.email
                txtPhoneNumber.text = employee.contactDetails.phone
            }
        }
    }
    
}
