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
    // Singleton
    public class var sharedInstance : Utils {
        return utils
    }
    
    func displaySystemInfo() {
        let currentDevice = UIDevice.currentDevice()
        println("systemVersion=\(currentDevice.systemVersion)")
        println("systemName=\(currentDevice.systemName)")
        println("model=\(currentDevice.model)")
        
        // check OS version
        let yosemite = NSOperatingSystemVersion(majorVersion: 10, minorVersion: 10, patchVersion: 0)
        let isAtLeastYosemite: Bool = NSProcessInfo().isOperatingSystemAtLeastVersion(yosemite) // false
        
        println("isAtLeastYosemite=\(isAtLeastYosemite)")
    }
}