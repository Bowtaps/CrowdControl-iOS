//
//  LocationModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 12/29/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

struct Location{
    var longitude: String
    var latitude: String
}

protocol LocationModel: BaseModel{
    var location: Location {get set}
    var recipient: UserProfileModel {get set}
    var sender: UserProfileModel {get set}
}