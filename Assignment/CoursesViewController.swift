//
//  SecondViewController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-09.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CoursesViewController: UITableViewController {

   
    var setId = "\"COMP4R\""
    var names = ["COMP": ["4977", "4976", "4711", "4560", "4735"], "BLAW": ["3600"]]
    var myAPIKey = "H5Vvh0k8Nmb3JZLtUsx1RsD9xdoIUrtO"

    var url: NSString!{
        return String("https://api.mongolab.com/api/1/databases/iosproject/collections/set?q={\"_SetId\": \(setId)}&fo=true&apiKey=\(myAPIKey)")
    }

    struct Objects {
        
        var sectionName : String!
        var sectionObjects : [String]!
    }
    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Courses"
        /*for (key, value) in names {
            //print("\(key) -> \(value)")
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }*/
        print(url)
        let searchURL : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        Alamofire.request(.GET, searchURL)
            .responseJSON { response in
                //print("Response JSON: \(response.result.value)")
                if let json = response.result.value {
                    let json = JSON(response.result.value!)
 
                    for (key, value):(String, JSON) in json{
                        //print("\(key) -> \(value)")
                        //self.objectArray.append(Objects(sectionName: key, sectionObjects: value.stringValue))
                        //print(key)
                        //print(value)
                        //print("hi")
                        
                    }
                    //print(self.objectArray)
                }
                
               
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return objectArray[section].sectionName
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        //print(currentCell.textLabel!.text)
        //print(objectArray[indexPath!.section].sectionName)
        tableView.deselectRowAtIndexPath(indexPath!, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("CourseController") as! CourseController
        destination.programName = objectArray[indexPath!.section].sectionName
        destination.courseNum = currentCell.textLabel!.text;
        
        navigationController?.pushViewController(destination, animated: true)
        
        
    }

}

