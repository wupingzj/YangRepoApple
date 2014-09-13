//
//  ConstraintCreator.swift
//  QiuTuiJian
//
//  Created by Ping on 10/09/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import UIKit

class ConstraintCreator {
    private var view: UIView
    private var metrics: Dictionary<String, AnyObject>
    private var views: Dictionary<String, AnyObject>
    
    init(view:UIView, metrics: Dictionary<String, AnyObject>, views: Dictionary<String, AnyObject>) {
        self.view = view
        self.metrics = metrics
        self.views = views
    }
    
    // Given a constraint format, add it to view with metrics and views dictionary
    func addConstraint(format: String, options: NSLayoutFormatOptions) -> Array<AnyObject> {
//        println("format=\(format)")
//        showDictionary(views)
//        showDictionary(metrics)
        
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: self.metrics, views: self.views)
        self.view.addConstraints(constraints)
        
        return constraints
    }
    
    // Given an array of constraint formats, add all to view with metrics and views dictionary
    func addConstraints(formats: [String], options: NSLayoutFormatOptions) {
        for format in formats {
            addConstraint(format, options: options)
        }
    }
    
    private func showDictionary(dictionary: Dictionary<String, AnyObject>) {
        for (key, value) in dictionary {
            println("key=\(key), value=\(value)")
        }
    }
}
