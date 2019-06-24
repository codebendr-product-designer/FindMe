//
//  ContactDetailCollectionView.swift
//  FindMe
//
//  Created by codebendr on 21/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactDetailCollectionView: UIViewController {
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    @IBOutlet weak var txtPosition: UILabel!
    @IBOutlet weak var txtProjects: UILabel!
    @IBOutlet weak var btnViewContacts: UIButton!
    
    var employee: Employee?
    var contact: CNContact?
    
    override func viewDidLoad() {
    
        if let employee = employee {
            txtName.text = "\(employee.lastName) \(employee.firstName)"
            txtEmail.text = employee.contactDetails.email
            txtPhone.text = employee.contactDetails.phone
            txtPosition.text = employee.position
            txtProjects.text  = employee.projects?.joined(separator:" | ") ?? "None Started Yet"
            
            let store = CNContactStore()
            let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
            
            if authorizationStatus == .notDetermined {
                
                store.requestAccess(for: .contacts) { didAuthorize,
                    error in
                    if didAuthorize {
                        self.getNactiveContact()
                       
                    }
                }
            } else if authorizationStatus == .authorized {
                self.getNactiveContact()
            }
        }
        
    }
    
    func retrieveContacts(by fullname: String) -> [CNContact] {
        let store = CNContactStore()
        var contacts = [CNContact]()
        let predicate = CNContact.predicateForContacts(matchingName: fullname)
        do {
            contacts = try store.unifiedContacts(matching: predicate, keysToFetch: [CNContactViewController.descriptorForRequiredKeys()])
        } catch {
            
        }
        return contacts
    }
    
    fileprivate func getNactiveContact() {
        if let employee = self.employee {
            let fullName = "\(employee.lastName) \(employee.firstName)"
            let contacts = self.retrieveContacts(by: fullName)
            if !contacts.isEmpty && contacts.count == 1  {
                self.contact = contacts[0]
                DispatchQueue.main.async {
                    self.btnViewContacts.isHidden = false
                }
            }
        }
    }
    
    @IBAction func viewContactsButtonPressed(_ sender: Any) {
        if let contact = contact {
        let contactViewController = CNContactViewController(for: contact)
        navigationController?.pushViewController(contactViewController, animated: true)
        } else {
             self.btnViewContacts.isHidden = true
        }
     
    }
    
}
