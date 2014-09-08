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
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        
        let msg: String = "Please go back to select a business entity."
        let errorMsg: UITextView = UITextView(frame: CGRectMake(leading, top_space, screenSize.width - leading - trailing, 200))
        
        errorMsg.editable = false
        errorMsg.selectable = false
        errorMsg.font = UIFont(name: nil, size: 20)
//        let cgRect = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, errorMsg.contentSize.width, errorMsg.contentSize.height);

        errorMsg.text = msg
        contentView.addSubview(errorMsg)
        
// The following works but doesn't have impact on GUI.
//        The constrains are not in effect and so greyed out
        
//        let sizeLabel: UILabel = UILabel(frame: CGRectMake(leading, 8*top_space, 600, 20))
        let sizeLabel: UILabel = UILabel()

//        sizeLabel.text = "width \(self.contentView.frame.width), height=\(self.contentView.frame.height)"
        sizeLabel.text = "width \(errorMsg.contentSize.width), height=\(errorMsg.contentSize.height) abcd cefkljlk f ljdfladjsf  aksdfajdfa;sfdhk; hadsfha;sfha;dfa;dsnf;a jfdasdfnkasnfaksdjn kadfskjfdakjf7777777"
        sizeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(sizeLabel)
        

        var viewsDictionary: Dictionary = ["sizeLabel":sizeLabel, "contentView":contentView, "errorMsg":errorMsg]
        var constraintsH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[sizeLabel]-50-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
//        var constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[sizeLabel]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        var constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-120-[sizeLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        
        var constraintsSizeH = NSLayoutConstraint.constraintsWithVisualFormat("H:[sizeLabel(>=50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        var constraintsSizeV = NSLayoutConstraint.constraintsWithVisualFormat("V:[sizeLabel(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.contentView.addConstraints(constraintsH)
        self.contentView.addConstraints(constraintsV)
        
        sizeLabel.addConstraints(constraintsSizeV)
        sizeLabel.addConstraints(constraintsSizeH)
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