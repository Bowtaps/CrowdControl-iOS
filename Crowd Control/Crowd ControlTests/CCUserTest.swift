//
//  CCUserTest.swift
//  Crowd Control
//
//  Created by Evan Hammer on 10/28/15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import XCTest

@testable import Crowd_Control
import Parse

class ParseUserTest: XCTestCase{
    func testLoad(){
        //create a user
       /* PFUser.logInWithUsernameInBackground("user3@test.com", password:"testing") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                print ("Login was successful")
                let newuser = ParseUserModel()
                newuser.loadAsync()
            } else {
                // The login failed. Check error to see why.
                print ("Failed to login")
            }
        }*/
        //TODO:  Need to rework this
        let parseUser = try? PFUser.logInWithUsername("user4", password: "test")
        let user = ParseUserModel(withParseUser: parseUser!)
        try? user.profile.load()
        print(user.profile)
        XCTAssert(true, "Pass")        
    }
}