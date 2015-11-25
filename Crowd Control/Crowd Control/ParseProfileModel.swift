//
//  ParseProfileModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 11/25/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation
import Parse

class ParseProfileModel: UserProfileModel{
    var displayName: String?
    
    var id: String?
    var created: NSDate?
    var update: NSDate?
    var modified: Bool
    
    init(){
        self.displayName = nil
        self.id = nil
        self.created = nil
        self.update = nil
        self.modified = false
    }
    
    func load(){}
    
    func loadInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?){}
    
    func save(){}
    
    func saveInBackground(callback: ((object: BaseModel?, error: NSError?) -> Void)?){}
}