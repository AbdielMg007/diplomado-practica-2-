//
//  SplashScreenController.swift
//  proyecto2ios
//
//  Created by Abdiel Mg on 07/01/23.
//

import UIKit

class SplashScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "LaunchMenu", sender: nil)
        }
    }
    

}
