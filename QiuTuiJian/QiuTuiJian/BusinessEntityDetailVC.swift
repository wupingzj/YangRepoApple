//
//  BusinessEntityDetailVC.swift
//  QiuTuiJian
//
//  Created by Ping on 13/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit
import MessageUI

class BusinessEntityDetailVC: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
//    @IBOutlet var labelCategory: UILabel!
//    
//    @IBOutlet var labelName: UILabel!
//    
//    @IBOutlet var labelAddress1: UILabel!
//    
//    @IBOutlet var labelAddress2: UILabel!
//    
//    @IBOutlet var labelCity: UILabel!
//    
//    @IBOutlet var labelState: UILabel!
//    
//    @IBOutlet var labelCountry: UILabel!
//    
    var labelMobile: UILabel!

    var labelEmail: UILabel!
//
//    @IBOutlet var addressView: UIView!

    // selected business entity to show details
    var businessEntity: BusinessEntity?
    
    func configureView() {
        businessEntity = nil
        
        if !self.businessEntity {
            let msg: String = "*** No busiess entity to display ***"
            println(msg)
            let errorMsgLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 600, 20))
            //errorMsgLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            errorMsgLabel.text = msg
            contentView.addSubview(errorMsgLabel)

            let sizeLabel: UILabel = UILabel(frame: CGRectMake(0, 40, 600, 20))
            sizeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            sizeLabel.text = "width \(self.contentView.frame.width), height=\(self.contentView.frame.height)"
            contentView.addSubview(sizeLabel)

            let screenLabel: UILabel = UILabel(frame: CGRectMake(0, 60, 600, 20))
            screenLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            screenLabel.text = "width \(self.view.frame.width), height=\(self.view.frame.height)"
            contentView.addSubview(screenLabel)
            
            var  viewsDictionary: Dictionary<String, UILabel> = ["sizeLabel":sizeLabel, "screenLabel":screenLabel]
            var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[sizeLabel]-30-[screenLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
            
            //let constraints = [contraint1];
            self.contentView.addConstraints(constraints)
            self.contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
            //self.scrollView.addConstraints(constraints)
            
            return
        }
        
        // Update the user interface for the detail item.
        if let businessEntity: BusinessEntity = self.businessEntity {
            println("*** configuring the business entity \(businessEntity) ***")
            
            //labelCategory.text = businessEntity.category
            //            labelName.text = businessEntity.getContactName()
            //            labelAddress1.text = "TODO_Address1"
            //            labelAddress2.text = "TODO_Address2"
            //            labelCity.text = "TODO_City"
            //            labelCountry.text = "TODO_Country"
            //            labelState.text = "TODO_State"
            // The phone number needs to be normailzed so that no need to show country code if locally
            //labelMobile.text = businessEntity.getContactPhone()
            //labelEmail.text = businessEntity.email
            
            let addressView: UIView = UIView(frame: CGRectMake(0, 0, 300, 80))
            addressView.backgroundColor = UIColor.grayColor()
            
            var addressLine1: UILabel = UILabel(frame: CGRectMake(20, 4, 200, 20))
            addressLine1.text = "Address Line 1"
            addressLine1.backgroundColor = UIColor.greenColor()
            addressView.addSubview(addressLine1)
    
            var addressLine2: UILabel = UILabel(frame: CGRectMake(20, 24, 300, 20))
            addressLine2.text = "Address Line 2"
            addressView.addSubview(addressLine2)
    
            var city: UILabel = UILabel(frame: CGRectMake(20, 44, 300, 20))
            city.text = "city"
            addressView.addSubview(city)
            
            contentView.addSubview(addressView)
        } else {
            println("*** ERROR (programming): How come the busiess entity is not passed t the detail screen ***")
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: "UIDeviceOrientationDidChangeNotificaion", object: nil)
    }
    
    public func orientationChanged(notification: NSNotification) {
        println("RECEIVE ORIENTATION notification")
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
        
        // Reference: http://stackoverflow.com/questions/5028329/ios-4-2-return-to-app-after-phone-call
        let mobileString:String = "telprompt:" + labelMobile.text
        println("Making a call to \(mobileString) ...")
        
        
        let app: UIApplication = UIApplication.sharedApplication()
        app.openURL(NSURL.URLWithString(mobileString))

        // Note1: the call is aynchronous. So, the application continues while calling.
        // the application will applicationWillResignActive and then applicationDidEnterBackground.
        
        // Note2: when telprompt protocol is used, the appcalition automatically resumes after call finishes
        //        However, if tel protocol is used, the application will NOT resume.
        println("Just made a phone call")
        
    }
    
    @IBAction func sendEmail(sender: UIButton) {
        let emailString:String = "email:" + labelEmail.text
        println("Sending an email to \(emailString) ...")
        let app: UIApplication = UIApplication.sharedApplication()
        //app.openURL(NSURL.URLWithString(emailString))
        
        let mcVC: MFMailComposeViewController  = MFMailComposeViewController()
        mcVC.mailComposeDelegate = self
        mcVC.setSubject("TestSubject")
        mcVC.setMessageBody("TestBody", isHTML: true)
        mcVC.setToRecipients(["KevinPingWu@gmail.com"])
        
        self.presentViewController(mcVC, animated: true, completion: nil)
        println("Just sent an email")
    }

    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        println("Mail \(result)");
        
        // Ref: http://stackoverflow.com/questions/25099153/xcode-6-beta-4-messagecomposeresult-is-not-convertible-to-optionalnilcompariso
        // The code below doesn't compile, but actually it is a bug in XCode bridging.
        
//        switch result
//        {
//            case MFMailComposeResultCancelled:
//                println("Mail cancelled");
//                break;
//            case MFMailComposeResultSaved:
//                println("Mail saved");
//                break;
//            case MFMailComposeResultSent:
//                println("Mail sent");
//                break;
//            case MFMailComposeResultFailed:
//                println("Mail sent failure: \(error.localizedDescription)");
//                break;
//            default:
//                break;
//        }
        
        // Close the Mail Interface
        self.dismissViewControllerAnimated(true, completion:nil);
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        
    }
    
@IBAction func addToFavorite(sender: UIBarButtonItem) {
}

@IBAction func writeReview(sender: UIBarButtonItem) {
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
