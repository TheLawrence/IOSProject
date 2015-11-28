//
//  User.swift
//  Assignment
//
//  Created by Jathavan on 2015-11-27.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import Foundation

var user = User()

struct User {
  var name: String?
  var set: String?
  var studentNumber: String?
  
  init(name: String!, set: String!, studentNumber: String!) {
    self.name = name
    self.studentNumber = studentNumber
    self.set = set
  }
  
  init(){
    
  }
}


