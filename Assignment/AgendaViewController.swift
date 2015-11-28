//
//  ThirdViewController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AgendaViewController: UITableViewController {
  var objectArray = [agendaArray]()
  var agendaData : [Agenda] = []
  
  override func loadView() {
    super.loadView()
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController!.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 60/255.0, blue: 113/255.0, alpha: 0)
    navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    getData("calendar", database: "iosproject", apiKey: "wT2XOfoaP8f0Q1akvhXjKg0wpqqkgSX_")
    
    self.tableView.separatorColor = UIColor.blackColor()
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    
    self.tableView.tableFooterView = UIView(frame:CGRectZero)
    // Do any additional setup after loading the view, typically from a nib.
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
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    return objectArray[section].sectionName
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("AgendaCell", forIndexPath: indexPath) as! AgendaCell
      
      
      
      let agenda = objectArray[indexPath.section].sectionObjects[indexPath.row] as Agenda
      cell.agenda = agenda
      
      cell.separatorInset = UIEdgeInsetsZero
      cell.layoutMargins = UIEdgeInsetsZero
      
      return cell
  }
  
  func sort(agendaData: [Agenda]){
    let cal = NSCalendar.currentCalendar()
    var components = cal.components([.Era, .Year, .Month, .Day], fromDate:NSDate())
    let today = cal.dateFromComponents(components)!
    var todayArray = [Agenda]()
    var tomorrowArray = [Agenda]()
    
    for item:Agenda in agendaData {
      components = cal.components([.Era, .Year, .Month, .Day], fromDate:item.date!);
      let otherDate = cal.dateFromComponents(components)!
      
      if(today.isEqualToDate(otherDate)) {
        todayArray.append(item)
      }
      else {
        tomorrowArray.append(item)
      }
      
    }
    
    objectArray.append(agendaArray(sectionName: "Today", sectionObjects: todayArray))
    objectArray.append(agendaArray(sectionName: "Future", sectionObjects: tomorrowArray))
    
  }
  
  func parseJSON(json: JSON) {
    let name = json["name"].string
    let type = json["type"].string
    let set = json["set"].string
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .LongStyle
    dateFormatter.timeZone = NSTimeZone.localTimeZone()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
    
    let dateString = json["date"].string
    var date = dateFormatter.dateFromString(dateString!)
    var recurring = json["recurring"].boolValue
    let item = Agenda(name: name!, type: type!, date: date!, recurring: recurring, set: set!)
    agendaData.append(item)
  }
  
  func getData( coll: String!, database: String!, apiKey: String!){
    var recievedData : [Agenda] = []
    var url: NSString!{
      
      return String("https://api.mongolab.com/api/1/databases/\(database)/collections/\(coll)?q={\"set\":\"\(user.set!)\"}&apiKey=\(apiKey)")
    }
    
    let searchURL : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
    Alamofire.request(.GET, searchURL)
      .responseJSON
      { response in
        if let json = response.result.value {
          let json = JSON(response.result.value!)
          for (key, value):(String, JSON) in json{
            self.parseJSON(value)
          }
          
          dispatch_async(dispatch_get_main_queue()) {
            self.sort(self.agendaData)
            self.tableView.reloadData()
          }
          
        }
      }
  }
  
  
}

