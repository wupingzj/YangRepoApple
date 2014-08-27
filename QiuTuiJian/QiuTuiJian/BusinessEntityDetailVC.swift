//
//  BusinessEntityDetailVC.swift
//  QiuTuiJian
//
//  Created by Ping on 13/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit

class BusinessEntityDetailVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        self.scrollView.layoutIfNeeded()
//        self.scrollView.contentSize = self.contentView.bounds.size
    }

    // actions
    @IBAction func call(sender: UIButton) {
        println("Making a call ...")
        // Reference: http://stackoverflow.com/questions/5028329/ios-4-2-return-to-app-after-phone-call
        let app: UIApplication = UIApplication.sharedApplication()
        app.openURL(NSURL.URLWithString("telprompt:0401482083"))

        // Note1: the call is aynchronous. So, the application continues while calling.
        // the application will applicationWillResignActive and then applicationDidEnterBackground.
        
        // Note2: when telprompt protocol is used, the appcalition automatically resumes after call finishes
        //        However, if tel protocol is used, the application will NOT resume.
        println("Just made a phone call")
        
    }
    
    
    @IBAction func sendEmail(sender: UIButton) {
        // TODO 
        println("Sending an email ...")
        let app: UIApplication = UIApplication.sharedApplication()
        app.openURL(NSURL.URLWithString("email:test@yangahha.com"))
        println("Just sent an email")
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
