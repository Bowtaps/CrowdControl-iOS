//
//  CCUserModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/22/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

protocol CCUserModel {
    //CCUser Table in Parse
    var status: String {get set}
    var location: (Double, Double) {get set}
    var preferences: String {get set}
    
    //ParseUser Table in Parse
    var objectId: String {get}
    var username: String {get set}
    var password: String {get}
    var authData: String {get}
    var emailVerified: Bool {get}
    var email: String {get}
    var createdAt: NSDate {get}
    var updatedAt: NSDate {get set}
    
    func load()
    func loadAsync()
    func save()
    func saveAsync()
}
