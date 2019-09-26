//
//  ViewController.swift
//  FindMe
//
//  Created by codebendr on 18/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class ContactCollectionViewController: UICollectionViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var refreshControl:UIRefreshControl!
    var employeeDictionary = [String:[Employee]]()
    var employeeGroups = [EmployeeGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5);
        refreshControl.addTarget(self, action: #selector(fetchEmployerListFromUrl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = true
        
        UI.registerCollectionViewNib(identifier: Config.ContactCollectionViewCell, collectionView: self.collectionView)
        
         fetchEmployerListFromUrl()
        
//        do {
//            let employeesData = try context.fetch(EmployeesData.fetchRequest()) as! [EmployeesData]
//            if !employeesData.isEmpty {
//
//                for data in employeesData {
//
//                    var existingItems = self.employeeDictionary[data.position!] ?? [Employee]()
//                    existingItems.append(Employee(firstName: data.firstName!, lastName: data.lastName!, contactDetails: Contact(email: data.email!, phone: data.phone), position: data.position!, projects: data.projects))
//
//                    self.employeeDictionary[data.position!] = existingItems
//
//                }
//
//                self.employeeGroups = [EmployeeGroup]()
//                for employeeGroup in self.employeeDictionary {
//                    self.employeeGroups.append(EmployeeGroup(section: employeeGroup.key, employee: employeeGroup.value.sorted()))
//                }
//                employeeGroups.sort()
//
//                collectionView.reloadData()
//                refreshControl.endRefreshing()
//                fetchEmployerListFromUrl()
//
//            } else {
//                fetchEmployerListFromUrl()
//            }
//
//        } catch {
//            let alert = UI.showError {
//                self.fetchEmployerListFromUrl()
//            }
//            self.present(alert, animated: true)
//        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        if let contactDetailViewController = destination as? ContactDetailCollectionView {
            contactDetailViewController.employee = sender as? Employee
        }
    }
    
    @objc fileprivate func fetchEmployerListFromUrl() {
        Data.getEmployees(from: Data.TallinEmployerListUrl) { employees in
            
            if !employees.isEmpty {
                
                for employee in employees {
                    
                    var existingItems = self.employeeDictionary[employee.position] ?? [Employee]()
                    existingItems.append(employee)
                    self.employeeDictionary[employee.position] = existingItems
                    
//                    let employeesData = EmployeesData(entity: EmployeesData.entity(), insertInto: self.context)
//                    employeesData.firstName = employee.firstName
//                    employeesData.lastName = employee.lastName
//                    employeesData.position = employee.position
//                    employeesData.projects = employee.projects
//                    employeesData.email = employee.contactDetails.email
//                    employeesData.phone = employee.contactDetails.phone
                    
                }
                
                self.employeeGroups = [EmployeeGroup]()
                for employeeGroup in self.employeeDictionary {
                    self.employeeGroups.append(EmployeeGroup(section: employeeGroup.key, employee: employeeGroup.value.sorted()))
                }
                self.employeeGroups.sort()
                
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.collectionView.reloadData()
                }
                
              //  self.appDelegate.saveContext()
                
            } else {
                
                let alert = UI.showError {
                    self.fetchEmployerListFromUrl()
                }
                self.present(alert, animated: true)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ContactCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let employee = employeeGroups[indexPath.section].employee[indexPath.row]
        performSegue(withIdentifier: Config.ContactDetailSegue, sender: employee)
        
    }
}

// MARK: - UICollectionViewDataSource
extension ContactCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview: UICollectionReusableView?
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Config.ContactHeader, for:indexPath) as! ContactHeader
            
            let section = employeeGroups[indexPath.section].section
            headerView.section = section
            
            reusableview = headerView
            return headerView
            
        default:
            return reusableview!
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return employeeGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employeeGroups[section].employee.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UI.getCollectionViewCell(forCellReuseIdentifier: Config.ContactCollectionViewCell, collectionView: collectionView, cellForRowAtIndexPath: indexPath) as! ContactCollectionViewCell
        cell.employee = employeeGroups[indexPath.section].employee[indexPath.row]
        return cell
        
    }
}
