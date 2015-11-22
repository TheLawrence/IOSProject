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
    var date: NSDate?
    
    init(name: String?, type: String?, date: NSDate? ) {
        self.name = name
        self.type = type
        self.date = date
    }
}