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
    
    private let leading: CGFloat = 20
    private let trailing: CGFloat = 20
    private let top_space: CGFloat = 20
    
    
    init(businessEntity: BusinessEntity?, contentView: UIView) {
        self.businessEntity = businessEntity
        self.contentView = contentView
    }
    
    public func showBusinessEntityMissingMessage() {
        // errorMsgLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        let errorMsg: UITextView = UITextView()
        var viewsDictionary: Dictionary = ["contentView":contentView, "errorMsg":errorMsg]

        //let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        //let cgRect = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, errorMsg.contentSize.width, errorMsg.contentSize.height);

        errorMsg.font = UIFont(name: nil, size: 20)
        errorMsg.text = "Please go back and select a business entity."
        // This line must be before the constraints as constraints needs to know the superview
        contentView.addSubview(errorMsg)
        
        // errorMsg location
        errorMsg.setTranslatesAutoresizingMaskIntoConstraints(false)
        var constraintsH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[errorMsg(>=50)]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        var constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[errorMsg(100)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.contentView.addConstraints(constraintsH)
        self.contentView.addConstraints(constraintsV)
    }
    
    func getContentView() -> UIView {
        let view: UIView = UIView(frame: CGRectMake(
            20,
            0,
            40,
            400))
        
        view.backgroundColor = UIColor.greenColor()
        //view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let emailLable = UILabel(frame: CGRectMake(20, 0, 40, 20))
        emailLable.text = "This is my email address"
        emailLable.backgroundColor = UIColor.redColor()
        //emailLable.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(emailLable)
        
        let phoneLable = UILabel(frame: CGRectMake(20, 200, 40, 20))
        phoneLable.text = "phone number"
        phoneLable.backgroundColor = UIColor.grayColor()
        //phoneLable.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(phoneLable)
        
        return view
    }
    
}