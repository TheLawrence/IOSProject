//
//  Agenda.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-21.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import Foundation
import UIKit

struct Agenda {
  var name: String?
  var type: String?
  var set: String?
  var date: NSDate?
  var recurring: Bool?
  
  init(name: String!, type: String!, date: NSDate!, recurring: Bool!, set: String! ) {
    self.name = name
    self.type = type
    self.date = date
    self.set = set
    self.recurring = recurring
  }
  
  init(){
    
  }
}

struct agendaArray {
  var sectionName: String!
  var sectionObjects: [Agenda]!
}