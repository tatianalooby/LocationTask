//
//  ViewController.swift
//  LocationTask
//
//  Created by Tatiana Looby on 04/03/2017.
//  Copyright © 2017 Tatiana Looby. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var displayLocationLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("Error: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if (error != nil) {
                print("Error: " + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let placemark = placemarks![0] as CLPlacemark
                self.displayLocationDetails(placemark: placemark, location: manager.location!)
            } else {
                print("Error retrieving data")
            }
        }
    }
    
    func displayLocationDetails(placemark: CLPlacemark, location: CLLocation) {
        locationManager.stopUpdatingLocation()
        displayLocationLabel.text = "Latitude: \(location.coordinate.latitude)\nLongitude: \(location.coordinate.longitude)\nLocality: \(placemark.locality!). Postal Code: \(placemark.postalCode!)\nAdministrative Area: \(placemark.administrativeArea!)\nCountry: \(placemark.country!)"
    }
    
    @IBAction func showMyLocationButtonTapped(_ sender: UIButton) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        print("button tapped")
    }

}

