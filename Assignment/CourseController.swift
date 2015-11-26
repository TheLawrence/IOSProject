//
//  CourseController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CourseController: UIViewController {
    
    var programName:String!
    var courseNum:String!
    
    @IBOutlet weak var tchName: UILabel!
    @IBOutlet weak var crsName: UILabel!
    
    
    @IBOutlet weak var courseDesc: UITextView!
    @IBOutlet weak var officeHrs: UILabel!

    @IBOutlet weak var officeLoc: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var classDetailsView: UIView!
    @IBOutlet weak var forumView: UIView!
    

    var myAPIKey = "H5Vvh0k8Nmb3JZLtUsx1RsD9xdoIUrtO"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.setEnabled( true, forSegmentAtIndex: 0)
        self.title =  programName + " " + courseNum
        var url: NSString!{
            return String("https://api.mongolab.com/api/1/databases/iosproject/collections/course?q={\"_courseId\": \(courseNum)}&fo=true&apiKey=\(myAPIKey)")
        }
        let searchURL : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        var courses = [String]()
        Alamofire.request(.GET, searchURL)
            .responseJSON { response in
                //print("Response JSON: \(response.result.value)")
                if let json = response.result.value {
                    let json = JSON(response.result.value!)
                    
                    for yo in json
                    {
                        //print(String(yo.1))
                        courses.append(String(yo.1))
                    }
                    self.crsName.text = courses[6]
                    self.tchName.text = courses[1]
                    self.email.text = courses[7]
                    self.officeLoc.text = courses[4]
                    self.officeHrs.text = courses[5]
                    self.courseDesc.text = courses[3]                }
        }
        classDetailsView.hidden = false
        forumView.hidden = true
    }
    
    @IBAction func indexChanged(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            classDetailsView.hidden = false
            forumView.hidden = true
        case 1:
            classDetailsView.hidden = true
            forumView.hidden = false
        default:
            break;
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
}

