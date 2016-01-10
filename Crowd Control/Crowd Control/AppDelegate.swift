//
//  AppDelegate.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-10-15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit

import Parse
import Bolts
import FBSDKCoreKit
import ParseFacebookUtilsV4
import Fabric
import Optimizely

/// The core delegate for the app. Contains pseudo-globa variables and functions that can be
/// accessed from anywhere in the app.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	/// The main instance of this class for the entire application.
	var instance: AppDelegate {
		get {
			return UIApplication.sharedApplication().delegate as! AppDelegate
		}
	}
	
	/// Optional reference to the current app window.
	var window: UIWindow?

	/// Optional reference to the current model manager.
	var modelManager: ModelManager?



	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("xJ5uDHyuSDxuMVBhNennSenRo9IRLnHx2g8bfPEv",
            clientKey: "PuShwUtOWCdhCa9EmEDWjSuJ0AhFkMy9kJhELxHi")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
		
		PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
		
		// Once connections to Parse have been initialzied, initialize the Parse model manager
		modelManager = ParseModelManager()
		
		return true
	}

	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
			return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		FBSDKAppEvents.activateApp()
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

}

