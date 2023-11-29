//
//  ShareActivity.swift
//  CinemaTix
//
//  Created by Eky on 28/11/23.
//

import Foundation
import UIKit

class AirDropActivity: UIActivity {
    
    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType.airDrop
    }
    
    override var activityTitle: String? {
        return "AirDrop"
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        // Check if your app can perform the activity
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        // Prepare for the activity, if needed
    }
    
    override func perform() {
        // Perform the custom activity
        activityDidFinish(true)
    }
}
