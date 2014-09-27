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
    
    // selected business entity to show details
    var selectedBusinessEntity: BusinessEntity?

    var layoutFactory: BusinessEntityLayoutFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutFactory = BusinessEntityLayoutFactory(businessEntityDetailVC: self, businessEntity: selectedBusinessEntity, contentView: self.contentView)

        // Do any additional setup after loading the view.
        self.configureView()
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: "UIDeviceOrientationDidChangeNotificaion", object: nil)
    }
    
    func configureView() {
        Utils.sharedInstance.displaySystemInfo()
        
        //businessEntity = nil //test missing error message
        if (self.selectedBusinessEntity != nil) {
            layoutFactory!.showBusinessEntityDetails()
        } else {
            layoutFactory!.showBusinessEntityMissingMessage()
        }
    }

    
    func orientationChanged(notification: NSNotification) {
        println("RECEIVE ORIENTATION notification")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // view.layoutIfNeeded()
//        let bounds = UIScreen.mainScreen().bounds
//        println("adjustViewBounds: UIScreen.mainScreen().bounds.height=\(bounds.height)")
//        println("adjustViewBounds: UIScreen.mainScreen().bounds.width=\(bounds.width)")


        // adjust bounds accoring to orientation changes
        layoutFactory!.adjustViewBounds()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


    // actions
    func callPhone() {
        showMap()
        if true {
            return
        }
        
        println("Making a call to ...")
        if let businessEntity = self.selectedBusinessEntity {
            // Reference: http://stackoverflow.com/questions/5028329/ios-4-2-return-to-app-after-phone-call
            let phoneSting:String = "telprompt:" + businessEntity.getNormalizedPhone()!
            println("call... phone \(phoneSting) ...")
            
            
            let app: UIApplication = UIApplication.sharedApplication()
            app.openURL(NSURL.URLWithString(phoneSting))
            
            // Note1: the call is aynchronous. So, the application continues while calling.
            // the application will applicationWillResignActive and then applicationDidEnterBackground.
            
            // Note2: when telprompt protocol is used, the appcalition automatically resumes after call finishes
            //        However, if tel protocol is used, the application will NOT resume.
            println("Just called phone.")
        }
    }
    
    func callMobile() {
        if let businessEntity = self.selectedBusinessEntity {
            // Reference: http://stackoverflow.com/questions/5028329/ios-4-2-return-to-app-after-phone-call
            let mobileString:String = "telprompt:" + businessEntity.getMobile()!
            println("call... mobile \(mobileString) ...")
            
            
            let app: UIApplication = UIApplication.sharedApplication()
            app.openURL(NSURL.URLWithString(mobileString))
            
            // Note1: the call is aynchronous. So, the application continues while calling.
            // the application will applicationWillResignActive and then applicationDidEnterBackground.
            
            // Note2: when telprompt protocol is used, the appcalition automatically resumes after call finishes
            //        However, if tel protocol is used, the application will NOT resume.
            println("Just called mobile.")
        }
    }
    
    func sendEmail() {
        if let businessEntity = self.selectedBusinessEntity {
            if (businessEntity.email != nil) {
                let emailString:String = "email:" + businessEntity.email!
                println("Sending an email to \(emailString) ...")
                
                let mcVC: MFMailComposeViewController  = MFMailComposeViewController()
                mcVC.mailComposeDelegate = self
                mcVC.setSubject("TestSubject")
                mcVC.setMessageBody("TestBody", isHTML: true)
                mcVC.setToRecipients([businessEntity.email!])
                
                self.presentViewController(mcVC, animated: true, completion: nil)
                println("Just sent an email")
            }
        }
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

    // #pragma mark - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        println("****** prepareForSegue ******")
        println("*** sender: \(sender)")
        
//        if segue.identifier == "segueShowMap" {
//            println("*** Horray: show map")
//        } else {
//            println("*** ERROR: Unrecongnized segue name in SeekTableVC.prepareForSegue ***")
//        }
    }
    
    func showMap() {
        println("*** Tapped showMap")
        //self.performSegueWithIdentifier("segueShowMap", sender: nil)
        
        let mapVC = self.storyboard!.instantiateViewControllerWithIdentifier("mapVC") as MapVC
        self.showViewController(mapVC as UIViewController, sender: mapVC)
            //self.presentViewController(mapVC as UIViewController, animated: true, completion: nil)
    }
}
