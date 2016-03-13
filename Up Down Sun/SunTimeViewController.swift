//
//  SunTimeViewController.swift
//  Up Down Sun
//
//  Created by Kyle Braham on 3/12/16.
//  Copyright © 2016 Kyle Braham. All rights reserved.
//

import UIKit

class SunTimeViewController: UIViewController {

    @IBOutlet weak var sunRiselb: UILabel!
    @IBOutlet weak var sunSetlb: UILabel!

     var riseTime: String = ""
     var setTime: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        sunRiselb.text = riseTime
        sunSetlb.text  = setTime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
