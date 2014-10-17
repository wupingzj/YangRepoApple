//
//  BusinessEntityLayoutFactory.swift
//  QiuTuiJian
//
//  Created by Ping on 8/09/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import UIKit

class BusinessEntityLayoutFactory {
    private var businessEntityDetailVC: UIViewController
    private var selectedBusinessEntity: BusinessEntity?
    private var contentView: UIView
    
    private var contentViewsDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    private var metricsDictionary: Dictionary<String, CGFloat> = ["labelWidth":80.0, "textWidth":100.0]
    private let standardLineGap = CGFloat(8.0)
    private var adjustableViews: [UIView] = []
    
    init(businessEntityDetailVC: UIViewController, businessEntity: BusinessEntity?, contentView: UIView) {
        self.businessEntityDetailVC = businessEntityDetailVC
        self.selectedBusinessEntity = businessEntity
        self.contentView = contentView
        
        self.contentViewsDictionary["contentView"] = contentView
        

        // TODO - find out the totoal height of UI components on different devices
        if Utils.sharedInstance.isIOS703() || Utils.sharedInstance.isIOS71() {
            // For iOS7, increase the gap
            standardLineGap = CGFloat(12.0)
        }
        metricsDictionary["labelHeight"] = CGFloat(20.0)
    }
    
    func showBusinessEntityMissingMessage() {
        let errorMsg: UITextView = UITextView()
        self.contentViewsDictionary["errorMsg"] = errorMsg

        errorMsg.font = UIFont.systemFontOfSize(20.0)
        errorMsg.text = "Please go back and select a business entity."

        self.contentView.addSubview(errorMsg)
        
        // errorMsg location
        errorMsg.setTranslatesAutoresizingMaskIntoConstraints(false)
        var constraintsH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[errorMsg(>=50)]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: contentViewsDictionary)
        var constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[errorMsg(100)]", options: NSLayoutFormatOptions(0), metrics: nil, views: contentViewsDictionary)
        
        self.contentView.addConstraints(constraintsH)
        self.contentView.addConstraints(constraintsV)
    }
    
    func showBusinessEntityDetails() {
        // This view is very dynamic. Mixed-layout mechanisms are used to generate dyanmic views and orientation
        // The contentView relies on auto resizeing to constraints
        // The subviews are purely programatically aligned using layout format constraints
        
        if let businessEntity = self.selectedBusinessEntity {
            println("*** configuring the business entity \(businessEntity) ***")
            
            var startY = CGFloat(0)

            // basics
            let basicsView: UIView = createBasicsView(x: 0, y: startY)
            adjustableViews.append(basicsView)
            
            // address
            startY += basicsView.bounds.height
            
            
            let addressView: UIView = createAddressView(x: 0, y: startY)
            adjustableViews.append(addressView)
            
            // optional description
            startY += addressView.bounds.height
            let descView: UIView? = createDescriptionView(x: 0, y: startY)
            if (descView != nil) {
                adjustableViews.append(descView!)
            }
        }
        //self.contentView.backgroundColor = UIColor.greenColor()
    }
    
    func adjustViewBounds() {
        for view: UIView in adjustableViews {
            adjustViewBounds(view)
        }
    }
    
    private func adjustViewBounds(view: UIView) {
        // adjust width only
        let bounds = UIScreen.mainScreen().bounds
        
        let currentX = view.frame.origin.x
        let currentY = view.frame.origin.y
        let currentHeight = view.frame.height
        
        view.frame = CGRect(x: currentX, y: currentY, width: bounds.width, height: currentHeight)
    }
    
    private func showDictionary(dictionary: Dictionary<String, AnyObject>) {
        for (key, value) in dictionary {
            println("key=\(key), value=\(value)")
        }
        
    }
    
    private func appendToFormatV(inout format:String, label: String) {
        format = format + "-[" + label + "(labelHeight)]"
    }
    
    // create basic details view of the business entity
    private func createBasicsView(#x: CGFloat, y: CGFloat) -> UIView {
        let businessEntity: BusinessEntity = selectedBusinessEntity!
        let basicsView: UIView = UIView()
        self.contentView.addSubview(basicsView)
        //basicsView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentViewsDictionary["basicsView"] = basicsView
        basicsView.backgroundColor = UIColor.greenColor()

        var basicsViewDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()

        //*****
        // Better be integer but CGFloat saves the hassle of data type conversion
        var lineCount = CGFloat(0)
        
        var formatH: [String] = []
        var labelFormatV = "V:|"
        var textFormatV = "V:|"

        // category
        let categoryLabel: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "categoryLabel", labelText: "Category:")
        let category: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "category", labelText: businessEntity.category)
        formatH.append("H:|-[categoryLabel(labelWidth)]-[category(>=textWidth)]-|")
        appendToFormatV(&labelFormatV, label: "categoryLabel")
        appendToFormatV(&textFormatV, label: "category")
        ++lineCount


        // name
        let nameLabel: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "nameLabel", labelText: "Name:")
        let name: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "name", labelText: businessEntity.getContactName())
        formatH.append("H:|-[nameLabel(labelWidth)]-[name(>=textWidth)]-|")
        appendToFormatV(&labelFormatV, label: "nameLabel")
        appendToFormatV(&textFormatV, label: "name")
        ++lineCount


        
        // phone
        if (businessEntity.phone != nil) {
            let phoneLabel: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "phoneLabel", labelText: "Phone:")
            let phone: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "phone", labelText: businessEntity.phone!)
            formatH.append("H:|-[phoneLabel(labelWidth)]-[phone(>=textWidth)]-|")
            appendToFormatV(&labelFormatV, label: "phoneLabel")
            appendToFormatV(&textFormatV, label: "phone")
            ++lineCount

            
            registerAction(phone, action:"callPhone")
        }
        
        // mobile
        if let mobileNumber = businessEntity.getMobile() {
            let mobileLabel: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "mobileLabel", labelText: "Mobile:")
            let mobile: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "mobile", labelText: mobileNumber)
            formatH.append("H:|-[mobileLabel(labelWidth)]-[mobile(>=textWidth)]-|")
            appendToFormatV(&labelFormatV, label: "mobileLabel")
            appendToFormatV(&textFormatV, label: "mobile")
            ++lineCount

            
            registerAction(mobile, action:"callMobile")
        }

        // email
        if businessEntity.email != nil {
            let emailLabel: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "emailLabel", labelText: "Email:")
            let email: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "email", labelText: businessEntity.email!)
            formatH.append("H:|-[emailLabel(labelWidth)]-[email(>=textWidth)]-|")
            appendToFormatV(&labelFormatV, label: "emailLabel")
            appendToFormatV(&textFormatV, label: "email")
            ++lineCount

            
            registerAction(email, action:"sendEmail")
        }

        
        // uuid - enable for debugging
        if false {
            let uuidLabel: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "uuidLabel", labelText: "uuid:")
            let uuid: UILabel = createLabel(basicsView, viewDictionary: &basicsViewDictionary, labelName: "uuid", labelText: businessEntity.uuid)
            formatH.append("H:|-[uuidLabel(labelWidth)]-[uuid(>=textWidth)]-|")
            appendToFormatV(&labelFormatV, label: "uuidLabel")
            appendToFormatV(&textFormatV, label: "uuid")
            ++lineCount
        }
        
        println("labelFormatV=\(labelFormatV)")
        println("textFormatV=\(textFormatV)")
        let constraintCreator: ConstraintCreator = ConstraintCreator(view: basicsView, metrics: metricsDictionary, views: basicsViewDictionary)
        constraintCreator.addConstraints(formatH, options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint(labelFormatV, options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint(textFormatV, options: NSLayoutFormatOptions(0))
        
        
        // calculate total view height
        let viewHeight: CGFloat = lineCount * (metricsDictionary["labelHeight"]! + standardLineGap)
        println("lineCount=\(lineCount), viewHeight=\(viewHeight)")

        let bounds = UIScreen.mainScreen().bounds

        // set view bounds
        basicsView.frame = CGRect(x: x, y: y, width: bounds.width, height: viewHeight)

        return basicsView
    }

    private func createAddressView(#x: CGFloat, y:CGFloat) -> UIView {
        let businessEntity: BusinessEntity = selectedBusinessEntity!
        let addressView: UIView = UIView()
        
        let bounds = UIScreen.mainScreen().bounds
        addressView.frame = CGRect(x: x, y: y, width: bounds.width, height: 180)
        
        self.contentView.addSubview(addressView)
        //addressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentViewsDictionary["addressView"] = addressView
        addressView.backgroundColor = UIColor.blueColor()
        
        var addressViewDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        // address label
        let addressLabel: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "addressLabel", labelText: "Address:")
        
        // address detail
        let addressLine1: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "addressLine1", labelText: businessEntity.address.getLine1())
        let addressLine2: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "addressLine2", labelText: businessEntity.address.getLine2())
        let city: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "city", labelText: businessEntity.address.city)
        let state: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "state", labelText: businessEntity.address.state)
        let country: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "country", labelText: businessEntity.address.country)
        let postCode: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "postCode", labelText: businessEntity.address.postCode)
        
        // setup address label constraints
        let constraintCreator: ConstraintCreator = ConstraintCreator(view: addressView, metrics: metricsDictionary, views: addressViewDictionary)
        constraintCreator.addConstraint("H:|-[addressLabel(labelWidth)]-[addressLine1(>=textWidth)]-|", options: NSLayoutFormatOptions(0))
        
        constraintCreator.addConstraint("H:|-95-[addressLine2(>=textWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-95-[city(>=textWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-95-[state(>=textWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-95-[country(>=textWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-95-[postCode(>=textWidth)]-|", options: NSLayoutFormatOptions(0))
        
        constraintCreator.addConstraint("V:|-[addressLabel(labelHeight)]", options: NSLayoutFormatOptions(0))
        var formatV: String = "V:|-[addressLine1(labelHeight)]-[addressLine2(labelHeight)]-[city(labelHeight)]-[state(labelHeight)]-[country(labelHeight)]-[postCode(labelHeight)]"
        constraintCreator.addConstraint(formatV, options: NSLayoutFormatOptions(0))

        return addressView
    }
    
    
    // create basic details view of the business entity
    private func createDescriptionView(#x: CGFloat, y: CGFloat) -> UIView? {
        let businessEntity: BusinessEntity = selectedBusinessEntity!

        if businessEntity.desc == nil {
                return nil
        }
        
        let descView: UIView = UIView()
        self.contentView.addSubview(descView)
        self.contentViewsDictionary["descView"] = descView
        descView.backgroundColor = UIColor.grayColor()
        
        var descViewDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        // Better be integer but CGFloat saves the hassle of data type conversion
        var lineCount = CGFloat(0)
        
        var formatH: [String] = []
        var labelFormatV = "V:|"
        var textFormatV = "V:|"
        
        if let description = businessEntity.desc {
            let descLabel: UILabel = createLabel(descView, viewDictionary: &descViewDictionary, labelName: "descLabel", labelText: "Description:")
            let desc: UILabel = createLabel(descView, viewDictionary: &descViewDictionary, labelName: "desc", labelText: description)
            formatH.append("H:|-[descLabel(labelWidth)]-[desc(>=textWidth)]-|")
            appendToFormatV(&labelFormatV, label: "descLabel")
            appendToFormatV(&textFormatV, label: "desc")
            ++lineCount
        }
        
        println("labelFormatV=\(labelFormatV)")
        println("textFormatV=\(textFormatV)")
        let constraintCreator: ConstraintCreator = ConstraintCreator(view: descView, metrics: metricsDictionary, views: descViewDictionary)
        constraintCreator.addConstraints(formatH, options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint(labelFormatV, options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint(textFormatV, options: NSLayoutFormatOptions(0))
        
        
        // calculate total view height
        let viewHeight: CGFloat = lineCount * (metricsDictionary["labelHeight"]! + standardLineGap)
        println("lineCount=\(lineCount), viewHeight=\(viewHeight)")
        
        let bounds = UIScreen.mainScreen().bounds
        
        // set view bounds
        descView.frame = CGRect(x: x, y: y, width: bounds.width, height: viewHeight)
        
        //        println("UIScreen.mainScreen().bounds.height=\(bounds.height)")
        //        println("UIScreen.mainScreen().bounds.width=\(bounds.width)")
        //        println("descView.frame.height=\(descView.frame.height)")
        //        println("descView.frame.width=\(descView.frame.width)")
        //        println("descView.frame.size=\(descView.frame.size)")
        //        println("descView.bounds.width=\(descView.bounds.width)")
        //        println("descView.bounds.height=\(descView.bounds.height)")
        //        println("descView.bounds.size=\(descView.bounds.size)")
        
        return descView
    }
    
    
    
    // the viewDictionary is added with the newly created label
    // Parameter:   labelName is the label name in the viewDictionary
    //              labelText is the label text that is displayed on view
    private func createLabel(view: UIView, inout viewDictionary: Dictionary<String, AnyObject>, labelName:String, labelText:String) -> UILabel {

        var label: UILabel = UILabel()
        label.text = labelText
        view.addSubview(label)
        viewDictionary[labelName] = label
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return label
    }

    private func registerAction(view: UIView, action: String) {
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self.businessEntityDetailVC, action: Selector(action))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
        
        println("registering action for view \(view). action=\(action)")
        
    }
}
