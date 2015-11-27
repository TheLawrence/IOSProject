//
//  NewsItemController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsItemController: UIViewController{
    
    
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var testTextView: UITextView!
    
    var pageTitle: String!
    var newsTitle: String!
    var fullNews: String!
    
    let apiKey = "PhtqFHoc1aUPEipHEtyCeI7SE8h-OIOf"
    let dbName = "lawsarcomp4977"
    let collectionName = "news"
    
    let c = "\"courseNum\""
    //let cNews = "\"\(newsTitle)\""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageTitle
        newsName.text = newsTitle
        testTextView.userInteractionEnabled = false
        
        var url: NSString!{
            return String("https://api.mongolab.com/api/1/databases/lawsarcomp4977/collections/news?q{\(c):\"\(newsTitle)\"}&fo=true&apiKey=PhtqFHoc1aUPEipHEtyCeI7SE8h-OIOf")
        }
        
        let searchURL : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        print(searchURL)
        Alamofire.request(.GET, searchURL)
            .responseJSON { response in
                if let json = response.result.value {
                    let json = JSON(response.result.value!)
                    print(json)
                    self.testTextView.text = json["newsDetail"].stringValue
                    
                }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}