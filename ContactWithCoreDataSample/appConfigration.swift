//
//  appConfigration.swift
//  ContactListWithCoreData
//
//  Created by IOS Developer6 on 19/06/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit

class ApplicationConfigurator {
    
    /// Method to configure Navigation Bar for entire application
    
    class func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 38.0/255.0, green: 50.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor =  UIColor(red: 38.0/255.0, green: 50.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    /// Method to configure Navigation Bar Back Button for entire application
    
    class func configureNavigationBackButton() {
        
        let backImage = #imageLiteral(resourceName: "back_white")
        let backButtonImage = backImage.withRenderingMode(.alwaysOriginal)
        
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
    }
    
    
}

