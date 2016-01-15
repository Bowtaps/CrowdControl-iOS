//
//  LocationModel.swift
//  Crowd Control
//
//  Created by Evan Hammer on 12/29/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

/// Model protocol representing a location in string form also a sender and a recipient
protocol LocationModel: BaseModel{
    /// String holding the longitudinal coordinate
    var longitude: String {get set}
    
    /// String holding the latitudinal coordinate
    var latitude: String {get set}
    
    /// UserProfileModel holding the recipient information when the locations are being sent
    /// to parse so that they can be sent encrypted to the intended recipient
    var recipient: UserProfileModel {get}
    
    /// This is the Current users' `UserProfileModel` holding the reference for the storage on 
    /// parse.
    var sender: UserProfileModel {get}
}