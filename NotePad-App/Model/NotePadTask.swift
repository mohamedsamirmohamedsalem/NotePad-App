//
//  ToDoTask.swift
//  ToDoList
//
//  Created by mohamed samir on 21/04/2021.
//

import Foundation
import RealmSwift
import  CoreLocation


class NotePadTask: Object{
    @objc dynamic var taskName = ""
    @objc dynamic var taskCreatedAt = NSDate()
    @objc dynamic var taskDescription = ""
    var location  = CLLocation(latitude: 0.0, longitude: 0.0)
    @objc dynamic var locationSelected = false
    @objc dynamic var noteImage = NSData()
}

