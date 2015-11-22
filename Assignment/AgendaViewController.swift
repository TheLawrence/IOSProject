//
//  ThirdViewController.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-19.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit

class AgendaViewController: UITableViewController {
    var agendas:[Agenda] = agendaData
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.redColor()
        self.tableView.layoutMargins = UIEdgeInsetsZero;
        
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("AgendaCell", forIndexPath: indexPath) as! AgendaCell
            
            let agenda = agendas[indexPath.row] as Agenda
            cell.agenda = agenda
            
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            
            return cell
    }
    
}

