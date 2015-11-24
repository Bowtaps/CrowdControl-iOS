//
//  UserProfile.swift
//  Crowd Control
//
//  Created by Evan Hammer on 11/24/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import Foundation

protocol UserProfileModel {
    var displayName: String {get set}
    var location: (Double, Double) {get set}
    var preferences: String? {get set}
    
}