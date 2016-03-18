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


    @IBOutlet weak var sunRiseTodayLb: UILabel!
    @IBOutlet weak var sunSetTodayLb: UILabel!
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
        let suncal:SunCalc = SunCalc(date: date, latitude: lat, longitude: long)
        formatter.dateFormat = "h:mm a"
        let sunriseString:String = formatter.stringFromDate(suncal.sunrise)
        let sunsetString:String = formatter.stringFromDate(suncal.sunset)
        sunRiseTodayLb.text = "Sun Rise: "+sunriseString
        sunSetTodayLb.text  =  "Sun Set: " + sunsetString

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.NewData)
    }
//    @IBAction func openButtonPressed(){
//        
//        var url =  NSURL(string:"todayExtensionSample://")
//        
//        self.extensionContext?.openURL(url, completionHandler:{(success: Bool) -> Void in
//            println("task done!")
//        })
//    }
    @IBAction func openAppbtn(sender: UIButton) {
        let myAppUrl = NSURL(string: "UpDownSun://")!
        print(myAppUrl)
        extensionContext?.openURL(myAppUrl, completionHandler: { (success) in
            if (!success) {
                print("Need to fix")
                
                
                

            }
        })
    }
}
