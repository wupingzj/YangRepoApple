//
//  Utils.swift
//  QiuTuiJian
//
//  Created by Ping on 19/09/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import UIKit

let utils = Utils()
public class Utils {
    private let osVersion = UIDevice.currentDevice().systemVersion
    
    // Singleton
    public class var sharedInstance : Utils {
        return utils
    }
    
    func displaySystemInfo() {
        let currentDevice = UIDevice.currentDevice()
        println("systemVersion=\(currentDevice.systemVersion)")
        println("systemName=\(currentDevice.systemName)")
        println("model=\(currentDevice.model)")
    }
    
    func isIOS703() -> Bool {
        return osVersion == "7.0.3"
    }
    
    func isIOS71() -> Bool {
        return osVersion == "7.1"
    }
    
    func isIOS80() -> Bool {
        return osVersion == "8.0"
    }
}