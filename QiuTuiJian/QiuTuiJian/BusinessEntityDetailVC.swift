//
//  BusinessEntityDetailVC.swift
//  QiuTuiJian
//
//  Created by Ping on 13/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit

class BusinessEntityDetailVC: UIViewController {
    
    // selected business entity to show details
    var businessEntity: BusinessEntity? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
//        if let detail: BusinessEntity = self.businessEntity {
//            println()
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.valueForKey("timeStamp").description
//            }
//        }
        
        
        println("*** configuring the business entity \(businessEntity) ***")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
