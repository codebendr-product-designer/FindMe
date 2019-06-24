//
//  Data.swift
//  FindMe
//
//  Created by codebendr on 18/06/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import Foundation
import SystemConfiguration

struct Data {
    static let TallinEmployerListUrl = "https://tallinn-jobapp.aw.ee/employee_list"
    static let TartuEmployerListUrl = "https://tartu-jobapp.aw.ee/employee_list"
    
    static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
    static func getEmployees(from url: String, _ employees: @escaping ([Employee]) -> Void) {
        
        guard let _url = URL(string: url) else { return }
        
        let reachability = SCNetworkReachabilityCreateWithName(nil, url)
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        if  isNetworkReachable(with: flags) {
            
            URLSession.shared.dataTask(with: _url) { (data, response
                , error) in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let employer = try decoder.decode(Employer.self, from: data)
                    employees(employer.employees)
                } catch {
                    employees([Employee]())
                }
                }.resume()
        } else {
            employees([Employee]())
        }
    }
}
