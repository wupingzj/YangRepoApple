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
    private var selectedBusinessEntity: BusinessEntity?
    private var contentView: UIView
    private var contentViewsDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    private var metricsDictionary: Dictionary<String, AnyObject> = ["labelWidth":80.0, "textWidth":100.0, "labelHeight":20.0]
    var labelFormatV: String = "Not Initiliazed"
    var textFormatV: String = "Not Initiliazed"
    
    private let leading: CGFloat = 20
    private let trailing: CGFloat = 20
    private let top_space: CGFloat = 20
    
    
    init(businessEntity: BusinessEntity?, contentView: UIView) {
        self.selectedBusinessEntity = businessEntity
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

        if let businessEntity = self.selectedBusinessEntity {
            var formatH: [String] = []
            
            println("*** configuring the business entity \(businessEntity) ***")
            
            labelFormatV = "V:|"
            textFormatV = "V:|"

            // category
//    println("contentViewsDictionaryA=\(contentViewsDictionary.count)")
//    showDictionary(contentViewsDictionary)
            let categoryLabel: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "categoryLabel", labelText: "Category:")
            let category: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "category", labelText: businessEntity.category)
            formatH.append("H:|-[categoryLabel(labelWidth)]-[category(>=textWidth)]-|")
            addToLabelFormatV("categoryLabel")
            addToTextFormatV("category")

            // name
            let nameLabel: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "nameLabel", labelText: "Name:")
            let name: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "name", labelText: businessEntity.getContactName())
            formatH.append("H:|-[nameLabel(labelWidth)]-[name(>=textWidth)]-|")
            addToLabelFormatV("nameLabel")
            addToTextFormatV("name")

            
            // phone
            if businessEntity.phone {
                let phoneLabel: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "phoneLabel", labelText: "Phone:")
                let phone: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "phone", labelText: businessEntity.phone!)
                formatH.append("H:|-[phoneLabel(labelWidth)]-[phone(>=textWidth)]-|")
                addToLabelFormatV("phoneLabel")
                addToTextFormatV("phone")
            }
            
            // mobile
            if let mobileNumber = businessEntity.getMobile() {
                let mobileLabel: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "mobileLabel", labelText: "Mobile:")
                let mobile: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "mobile", labelText: mobileNumber)
                formatH.append("H:|-[mobileLabel(labelWidth)]-[mobile(>=textWidth)]-|")
                addToLabelFormatV("mobileLabel")
                addToTextFormatV("mobile")
            }

            // email
            if businessEntity.email != nil {
                let emailLabel: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "emailLabel", labelText: "Email:")
                let email: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "email", labelText: businessEntity.email!)
                formatH.append("H:|-[emailLabel(labelWidth)]-[email(>=textWidth)]-|")
                addToLabelFormatV("emailLabel")
                addToTextFormatV("email")
            }

            // address
            let addressView: UIView = createAddressView()
            self.contentView.addSubview(addressView)
            contentViewsDictionary["addressView"] = addressView
            addressView.setTranslatesAutoresizingMaskIntoConstraints(false)
            labelFormatV = labelFormatV + "-[addressView]"
            textFormatV = textFormatV + "-[addressView]"

            // uuid - for debugging
            if true {
                let uuidLabel: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "uuidLabel", labelText: "uuid:")
                let uuid: UILabel = createLabel(self.contentView, viewDictionary: &contentViewsDictionary, labelName: "uuid", labelText: businessEntity.uuid)
                formatH.append("H:|-[uuidLabel(labelWidth)]-[uuid(>=textWidth)]-|")
                addToLabelFormatV("uuidLabel", gap: "180.0")
                addToTextFormatV("uuid", gap: "180.0")
            }


            println("labelFormatV=\(labelFormatV)")
            println("textFormatV=\(textFormatV)")
            let constraintCreator: ConstraintCreator = ConstraintCreator(view: self.contentView, metrics: metricsDictionary, views: contentViewsDictionary)
            constraintCreator.addConstraints(formatH, options: NSLayoutFormatOptions(0))
            constraintCreator.addConstraint(labelFormatV, options: NSLayoutFormatOptions(0))
            constraintCreator.addConstraint(textFormatV, options: NSLayoutFormatOptions(0))
            
            

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
    }
    
    private func showDictionary(dictionary: Dictionary<String, AnyObject>) {
        for (key, value) in dictionary {
            println("key=\(key), value=\(value)")
        }
        
    }
    
    private func addToLabelFormatV(label: String) {
        labelFormatV = labelFormatV + "-[" + label + "(labelHeight)]"
    }
    
    private func addToTextFormatV(text: String) {
        textFormatV = textFormatV + "-[" + text + "(labelHeight)]"
    }

    private func addToLabelFormatV(label: String, gap: String) {
        labelFormatV = labelFormatV + "-" + gap + "-[" + label + "(labelHeight)]"
    }
    
    private func addToTextFormatV(text: String, gap: String) {
        textFormatV = textFormatV + "-" + gap + "-[" + text + "(labelHeight)]"
    }

    
    private func createAddressView() -> UIView {
        let businessEntity: BusinessEntity = selectedBusinessEntity!
        let addressView: UIView = UIView()
        self.contentView.addSubview(addressView)
        addressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentViewsDictionary["addressView"] = addressView
        
        var addressViewDictionary: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        // address label
        let addressLabel: UILabel = createLabel(addressView, viewDictionary: &addressViewDictionary, labelName: "addressLabel", labelText: "Address:")
        //addressLabel.backgroundColor = UIColor.redColor()
        
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
}