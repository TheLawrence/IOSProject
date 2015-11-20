//
//  CourseController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit

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
    

    var values = [String]!()
    
    var crsDeetz : [String: [String]] = [
        "4977":
        [
            "iOS Application Development for iPhone and iPad",
            "D'arcy Smith",
            "dsmith25@my.bcit.ca",
            "SW2-301",
            "TBA.",
            "This hands-on course is designed for students who are able to code medium sized applications in an Object Oriented language. Students design and develop apps to Apple standards for the latest iOS platforms."
        ],
        "4976":
        [
            "Web Application with ASP.NET",
            "Medhat Elmasry",
            "melmasry1@my.bcit.ca",
            "SW2-121",
            "By appointment only",
            "This hands-on course is designed for those who are already familiar with an Object Oriented programming language such as Java or C++. Students are introduced to web application development using C# and the Microsoft ASP.NET Framework."
        ]
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.setEnabled( true, forSegmentAtIndex: 0)
        self.title =  programName + " " + courseNum
        if((crsDeetz[courseNum]?.isEmpty) != nil){
            values = crsDeetz[courseNum]
            self.crsName.text = values[0]
            self.tchName.text = values[1]
            self.email.text = values[2]
            self.officeLoc.text = values[3]
            self.officeHrs.text = values[4]
            self.courseDesc.text = values[5]
            

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

