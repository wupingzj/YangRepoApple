//
//  AdVC.swift
//  QiuTuiJian
//
//  Created by Ping on 21/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit

class AdVC: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var contentView: UIView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize = self.contentView.bounds.size
    }

}
