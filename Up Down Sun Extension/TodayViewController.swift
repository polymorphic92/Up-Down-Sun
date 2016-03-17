//
//  TodayViewController.swift
//  Up Down Sun Extension
//
//  Created by Kyle Braham on 3/16/16.
//  Copyright © 2016 Kyle Braham. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation
import CelestialSpheres
class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate {
        let locationManager = CLLocationManager()
        let formatter:NSDateFormatter = NSDateFormatter()
        let date:NSDate = NSDate()
    @IBOutlet weak var test: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
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
//        let suncal:SunCalc = SunCalc(date: <#T##NSDate#>, latitude: lat, longitude: long)
         let suncal:SunCalc = SunCalc.getTimes(date, latitude: lat, longitude: long)
        formatter.dateFormat = "h:mm a"
        let sunriseString:String = formatter.stringFromDate(suncal.sunrise)
        let sunsetString:String = formatter.stringFromDate(suncal.sunset)
        test.text = "Sun Rise:"+sunriseString + " Sun Set" + sunsetString
        
//        let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: lat.unwrappedTextDouble, longitude: long.unwrappedTextDouble)
//        
//        formatter.dateFormat = "h:mm a"
//        let sunriseString:String = formatter.stringFromDate(sunCalc.sunrise)
//        let sunsetString:String = formatter.stringFromDate(sunCalc.sunset)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
