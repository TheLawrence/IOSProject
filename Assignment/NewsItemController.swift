//
//  NewsItemController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit

class NewsItemController: UIViewController{
    
    
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var testTextView: UITextView!
    
    var pageTitle: String!
    var newsTitle: String!
    var fullNews: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageTitle
        newsName.text = newsTitle
        testTextView.text = fullNews
        testTextView.userInteractionEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}