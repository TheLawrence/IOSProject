//
//  NewsViewController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsViewController: UITableViewController {
    
    var news = ["Announcements": ["Finals Schedule"], "Course News": ["COMP4977", "COMP4976"]]
    var testString = "long string of text that should get dot dot dotted because there is not enough room to display all of this junk. hello world."
    
    let apiKey = "PhtqFHoc1aUPEipHEtyCeI7SE8h-OIOf"
    let dbName = "lawsarcomp4977"
    let collectionName = "news"
    let setR = "\"COMP4R\""
    let setD = "\"COMP4D\""
    
    var url: NSString!{
        //all
        return String("https://api.mongolab.com/api/1/databases/\(dbName)/collections/\(collectionName)?q={\"userSet\":\(setR)}&c=true&apiKey=\(apiKey)")
        //COMP4D
        //return String("https://api.mongolab.com/api/1/databases/\(dbName)/collections/\(collectionName)?q={\"userSet\": \(setD)"}&apiKey=\(apiKey)")
        //COMP4R
        //return String("https://api.mongolab.com/api/1/databases/\(dbName)/collections/\(collectionName)?q={\"userSet\": \(setR)}&apiKey=\(apiKey)")
    }
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"
        
        let searchURL : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        
        print(searchURL)
        
        Alamofire.request(.GET, searchURL)
            .responseJSON { response in
                if let json = response.result.value {
                    let json = JSON(response.result.value!)
                    print("\(json)")
                }
        }
        
        for(key, value) in news
        {
            //print("\(key)) -> \(value)")
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Configure the cell...
        cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        cell.detailTextLabel?.text = testString
        
        return cell
    }
    
    //shows header for news items, for (Courses, Announcements)
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return objectArray[section].sectionName
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        print(currentCell.textLabel!.text)
        tableView.deselectRowAtIndexPath(indexPath!, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("NewsItemController") as! NewsItemController
        destination.pageTitle = objectArray[indexPath!.section].sectionName
        destination.newsTitle = currentCell.textLabel!.text
        destination.fullNews = testString
        navigationController?.pushViewController(destination, animated: true)
    }
    
}
