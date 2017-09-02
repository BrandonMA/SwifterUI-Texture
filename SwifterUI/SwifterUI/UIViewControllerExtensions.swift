//
//  UIViewControllerExtensions.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

extension UIViewController {
    
    // showErrorAlert: Shows an alert with the alerts you added
    // - Parameters:
    //    title: Title of the alert you want to present
    //    errorDescription: Description of what is happening
    //    action: Action to perform once the user saw the alert
    public func showErrorAlert(title: String, errorDescription: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: errorDescription, preferredStyle: .alert) // Create a new UIAlertController
        actions.forEach { (action) in // Loop over all actions inside the array
            alert.addAction(action) // Add the current action
        }
        self.present(alert, animated: true, completion: nil) // Present the alert to the user
    }
    
}
