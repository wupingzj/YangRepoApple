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
    
    @IBOutlet var dataLoadResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataLoadResult.text = "Click button to load data. Restart app to show created data"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize = self.contentView.bounds.size
    }

    @IBAction func createTestData(sender: AnyObject) {
        testCreateEntity()
    }
    
    func testCreateEntity() {
        println("Creating busines entities...")
        
        let dataLoader: DataLoader = DataLoader()
        let succeed: Bool = dataLoader.createEntity()
        
        if succeed {
            dataLoadResult.text = "Horay! Loading data succeeded!"
        } else {
            dataLoadResult.text = "Oops, failed to load data."
        }
    }
    
    @IBAction func listBusinessEntities(sender: UIButton) {
        let dataLoader: DataLoader = DataLoader()
        dataLoader.listEntities()
    }
    
    @IBAction func checkNetwork(sender: UIButton) {
        println("Checking network status...")
    }
    
    @IBAction func retrieveRemoteData(sender: UIButton) {
        println("Retrieve remote data from server ...")
    }
    
}
