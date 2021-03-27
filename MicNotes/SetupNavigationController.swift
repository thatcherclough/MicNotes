//
//  SetupNavigationController.swift
//  MicNotes
//
//  Created by Thatcher Clough on 1/7/21.
//

import Foundation
import UIKit

class SetupNavigationController: UINavigationController {
    override func viewDidLoad() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
}
