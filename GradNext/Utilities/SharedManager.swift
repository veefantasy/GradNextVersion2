//
//  SharedManager.swift
//  RPMDoctor
//
//  Created by Admin on 06/02/17.
//  Copyright © 2017 HCL Technologies. All rights reserved.
//

import Foundation

final class SharedManager {
    // Declare class instance property
    static let sharedInstance = SharedManager()
    // Declare an initializer
    // Because this class is singleton only one instance of this class can be created
    init() {
        print("Singleton has been initialized")
    }
    var userLabelText: String?
    var userDetailLabelText: String?
    var isCheckValue : String?
    var sessionID: String?

    
 
    
    
    var temperatureNormalRangeOne = ""
    var temperatureNormalRangeTwo = ""
    
    var temperatureLow  = ""
    var temperatureHigh = ""
    
    var GlucoseLow  = ""
    var GlucoseHigh = ""
    
    var SystolicLow  = ""
    var SystolicHigh = ""
    
    var DystolicLow  = ""
    var DystolicHigh = ""
    
    var recentBp = [String:String]()
    var recentWeight = [String:String]()
    var recentTemperature = [String:String]()
    var recentGlucose = [String:String]()
    var recentHeartRate = [String:String]()
    
    var treatmentDetailedTherapyType = String()
    
    var selectedSkills = [String]()
    
}
