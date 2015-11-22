//
//  NewsViewController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
    var news = ["Announcements": ["Finals Schedule"], "Course News": ["COMP4977", "COMP4976"]]
    var testString = "long string of text that should get dot dot dotted because there is not enough room to display all of this junk. hello world."
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"
        
        for(key, value) in news
        {
            print("\(key)) -> \(value)")
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
