//
//  BusinessEntityDetailVC.swift
//  QiuTuiJian
//
//  Created by Ping on 13/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit

class BusinessEntityDetailVC: UIViewController {
    
    @IBOutlet var labelCategory: UILabel!
    
    @IBOutlet var labelName: UILabel!
    
    // selected business entity to show details
    var businessEntity: BusinessEntity? {
        didSet {
            // You CAN NOT update view at this stage
            // That's because the IBOutlet has NOT been weaved yet and is still nil!
            //self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let businessEntity: BusinessEntity = self.businessEntity {
            println("*** configuring the business entity \(businessEntity) ***")
            
            labelCategory.text = businessEntity.category
            labelName.text = businessEntity.name
            
        } else {
            println("*** ERROR (programming): How come the busiess entity is not passed t the detail screen ***")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
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
