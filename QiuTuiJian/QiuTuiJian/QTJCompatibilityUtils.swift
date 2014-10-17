//
//  QTJCompatibilityUtils.swift
//  QiuTuiJian
//
//  Created by Ping on 11/10/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import UIKit

let qtjCompatibilityUtilsFactory = QTJCompatibilityUtilsFactory()
class QTJCompatibilityUtilsFactory {
    private let utils_ios8 = QTJCompatibilityUtils_IOS8()
    private let utils_ios703 = QTJCompatibilityUtils_IOS703()
    private let utils_ios71 = QTJCompatibilityUtils_IOS71()
    
    // Singleton
    class var sharedInstance : QTJCompatibilityUtilsFactory {
        return qtjCompatibilityUtilsFactory
    }
    
    func getCompatibilityUtils() -> QTJCompatibilityUtils {
        let osVersion = UIDevice.currentDevice().systemVersion
        
        switch osVersion {
            case "7.0.3":
                return utils_ios703;
            case "7.1":
                return utils_ios71
            case "8.0":
                return utils_ios8
        default:
                println("*** ERROR: NOT supported os version \(osVersion). Use iOS8.0")
                return utils_ios8
        }
    }
}

class QTJCompatibilityUtils {
}

class QTJCompatibilityUtils_IOS8: QTJCompatibilityUtils {
    func showAlertMsg(viewVC: UIViewController, title: String, message: String) {
        // TODO: UIAlertController requires iOS8
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
            handler: { action in
        })
        alertController.addAction(okAction)
        viewVC.presentViewController(alertController, animated: true, completion: nil)
    }
}

class QTJCompatibilityUtils_IOS703: QTJCompatibilityUtils {
}

class QTJCompatibilityUtils_IOS71: QTJCompatibilityUtils {
}
