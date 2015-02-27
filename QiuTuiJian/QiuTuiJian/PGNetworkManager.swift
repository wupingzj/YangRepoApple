//
//  PGNetworkManager.swift
//  QiuTuiJian
//
//  Created by Ping on 28/10/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import SystemConfiguration

class PGNetworkManager {
    let serverHost: String = "localhost";
//    var RemoteReachability: Reachability! = nil
//    var RemoteIsReachable: Bool = false
    
    func isNetworkAvailable() -> Bool {
//        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
//        let networkStatus: Int = reachability.currentReachabilityStatus().value
//        return networkStatus != 0
        return true;
    }
    
    func isServerAvailable() -> Bool {
        return true
    }
}