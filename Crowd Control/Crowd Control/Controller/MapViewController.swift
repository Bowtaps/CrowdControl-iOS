//
//  MapViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-10-15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit
import MapKit

/// Controller for the map view, which displays an interactive map that displays the user's
/// current location and the location of others in the group.
class MapViewController: UIViewController, CLLocationManagerDelegate {
	
	/// The location manager that handles automatic location tracking and display on the map.
	/// - SeeAlso: CLLocationManager
	let manager = CLLocationManager()
	
	/// Outlet to Interface Builder for the map view
	/// - SeeAlso: MKMapView
	@IBOutlet weak var map: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		if CLLocationManager.authorizationStatus() == .NotDetermined {
			manager.requestAlwaysAuthorization()
		}
		
		let userTrackingButton = MKUserTrackingBarButtonItem(mapView: map)
		self.navigationItem.leftBarButtonItem = userTrackingButton
		self.navigationItem.title = "Map"
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

