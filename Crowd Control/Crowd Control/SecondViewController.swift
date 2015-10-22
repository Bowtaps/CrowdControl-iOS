//
//  SecondViewController.swift
//  Crowd Control
//
//  Created by Daniel Andrus on 2015-10-15.
//  Copyright © 2015 Bowtaps. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {

	@IBOutlet weak var map: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let userTrackingButton = MKUserTrackingBarButtonItem(mapView: map)
		self.navigationItem.leftBarButtonItem = userTrackingButton
		self.navigationItem.title = "Map"
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

