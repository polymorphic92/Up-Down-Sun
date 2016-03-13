//
//  ViewController.swift
//  Up Down Sun
//
//  Created by Kyle Braham on 3/17/15.
//  Copyright (c) 2015 Kyle Braham. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController , CLLocationManagerDelegate ,  UITextFieldDelegate{

    
    
    
    
    let locationManager = CLLocationManager()
    let date:NSDate = NSDate()
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var long: UITextField!
    
//    @IBAction func getTimes(sender: UIButton) {
//        
//        
//    calSunTimes(lat.text!.toDouble()!,f2: long.text!.toDouble()!)
//        
//    }
    
    
    
    
    
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
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                
                print("Error:" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
            }else {
                
                print("Error with data");
            }
            
        })
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
//        print(placemark.locality)
//        print(placemark.postalCode)
//        print(placemark.administrativeArea)
//        print(placemark.country)
        let lat =  Double(placemark.location!.coordinate.latitude)
        let long =  Double(placemark.location!.coordinate.longitude)
        calSunTimes(lat,f2: long)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let sunTimeView: SunTimeViewController = segue.destinationViewController as! SunTimeViewController
        if lat.text != nil && long.text != nil{
            

            let sunCalc:SunCalc = SunCalc.getTimes(date, latitude: lat.text!.toDouble()!, longitude: long.text!.toDouble()!)
            let formatter:NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "h:mm a"
            let sunriseString:String = formatter.stringFromDate(sunCalc.sunrise)
            let sunsetString:String = formatter.stringFromDate(sunCalc.sunset)
            
   
            sunTimeView.setTime = "Sun Set: " + sunsetString
            sunTimeView.riseTime = "Sun Rise: " + sunriseString
            
        }
    }

    func calSunTimes(f1: Double!, f2: Double!){
        lat.text = "\(f1)"
        long.text = "\(f2)"
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}

