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
    private var businessEntity: BusinessEntity?
    private var contentView: UIView
    private var contentViewsDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    
    private let leading: CGFloat = 20
    private let trailing: CGFloat = 20
    private let top_space: CGFloat = 20
    
    
    init(businessEntity: BusinessEntity?, contentView: UIView) {
        self.businessEntity = businessEntity
        self.contentView = contentView
        
        self.contentViewsDictionary["contentView"] = contentView

    }
    
    public func showBusinessEntityMissingMessage() {
        // errorMsgLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        let errorMsg: UITextView = UITextView()
        self.contentViewsDictionary["errorMsg"] = errorMsg

        //let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        //let cgRect = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, errorMsg.contentSize.width, errorMsg.contentSize.height);

        errorMsg.font = UIFont(name: nil, size: 20)
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
        //self.contentView.backgroundColor = UIColor.greenColor()

        println("*** configuring the business entity \(businessEntity) ***")
        
        //labelCategory.text = businessEntity.category
        //            labelName.text = businessEntity.getContactName()
        // The phone number needs to be normailzed so that no need to show country code if locally
        //labelMobile.text = businessEntity.getContactPhone()
        //labelEmail.text = businessEntity.email
        
        let addressView: UIView = createAddressView()
        
        
        
//        let emailLable = UILabel(frame: CGRectMake(20, 0, 40, 20))
//        emailLable.text = "This is my email address"
//        emailLable.backgroundColor = UIColor.redColor()
//        //emailLable.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.contentView.addSubview(emailLable)
//        
//        let phoneLable = UILabel(frame: CGRectMake(20, 200, 40, 20))
//        phoneLable.text = "phone number"
//        phoneLable.backgroundColor = UIColor.grayColor()
//        //phoneLable.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.contentView.addSubview(phoneLable)
    }
    
    private func createAddressView() -> UIView {
        let addressView: UIView = UIView()
        self.contentView.addSubview(addressView)
        addressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentViewsDictionary["addressView"] = addressView
        addressView.backgroundColor = UIColor.blackColor()
        
        var addressViewDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        var metricsDictionary: Dictionary<String, AnyObject> = ["labelWidth":50.0, "labelHeight":20.0]
        
        // create address labels
        let addressLine1: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "addressLine1", labelText: "My addressLine1")
        addressLine1.backgroundColor = UIColor.greenColor()
        
        let addressLine2: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "addressLine2", labelText: "My addressLine2")
        addressLine2.backgroundColor = UIColor.blueColor()
        
        
        let city: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "city", labelText: "My City")
        city.backgroundColor = UIColor.redColor()
        
        let state: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "state", labelText: "My state")
        let country: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "country", labelText: "My country")
        let postCode: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "postCode", labelText: "My postCode")
        
        // setup address label constraints
        let constraintCreator: ConstraintCreator = ConstraintCreator(view: addressView, metrics: metricsDictionary, views: addressViewDictionary)
        constraintCreator.addConstraint("H:|-[addressLine1(>=labelWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-[addressLine2(>=labelWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-[city(>=labelWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-[state(>=labelWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-[country(>=labelWidth)]-|", options: NSLayoutFormatOptions(0))
        constraintCreator.addConstraint("H:|-[postCode(>=labelWidth)]-|", options: NSLayoutFormatOptions(0))
        
        var formatV: String = "V:|-[addressLine1(labelHeight)]-[addressLine2(labelHeight)]-[city(labelHeight)]-[state(labelHeight)]-[country(labelHeight)]-[postCode(labelHeight)]"
        constraintCreator.addConstraint(formatV, options: NSLayoutFormatOptions(0))

        return addressView
    }
    
    // the viewDictionary is added with the newly created label
    private func createLabel(view: UIView, inout viewDictionary: Dictionary<String, AnyObject>, labelName:String, labelText:String) -> UILabel {

        var label: UILabel = UILabel()
        label.text = labelText
        view.addSubview(label)
        viewDictionary[labelName] = label
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return label
    }
}