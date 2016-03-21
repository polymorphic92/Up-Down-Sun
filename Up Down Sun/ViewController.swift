//
//  ViewController.swift
//  Up Down Sun
//
//  Created by Kyle Braham on 3/17/15.
//  Copyright (c) 2015 Kyle Braham. All rights reserved.
//

import UIKit
import CoreLocation
import CelestialSpheres
class ViewController: UIViewController , CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    let date:NSDate = NSDate()
    let formatter:NSDateFormatter = NSDateFormatter()
    @IBOutlet weak var sunRiseLb: UILabel!
    @IBOutlet weak var sunsetLb: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        
        calSunTimes(lat,f2: long)
        cal()
    }
    
    
    
//    helper funcs 
    
    func cal(){
        let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: lat.text!.toDouble()!, longitude: long.text!.toDouble()!)
        
        formatter.dateFormat = "h:mm a"
        sunRiseLb.text = formatter.stringFromDate(sunCalc.sunrise)
        sunsetLb.text = formatter.stringFromDate(sunCalc.sunset)
    }
    func calSunTimes(f1: Double!, f2: Double!){
        self.locationManager.stopUpdatingLocation()
        lat.text = "\(f1)"
        long.text = "\(f2)"
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if (segue.identifier == "mainToSettings"){

     }
    }


    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
        
    }
}
extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}



