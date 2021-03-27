//
//  TestShortcutViewController.swift
//  MicNotes
//
//  Created by Thatcher Clough on 3/27/21.
//

import Foundation
import UIKit

class TestShortcutViewController: UIViewController {
    
    let defaults = UserDefaults(suiteName: "group.dev.thatcherclough.MicNotes")!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBAction func testShortcutAction(_ sender: Any) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.applicationEnteredForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        defaults.set("Welcome to MicNotes!", forKey: "test")
        
        let url = URL(string: "shortcuts://x-callback-url/run-shortcut?name=Export%20to%20notes&x-success=micnotes://")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Could not opern url", message: "Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                alert.view.tintColor = UIColor(named: "AccentColor")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func applicationEnteredForeground() {
        if let state = (defaults.value(forKey: "test") as Any) as? String {
            defaults.set(nil, forKey: "test")
            
            if state == "success" {
                nextButton.isEnabled = true
                nextButton.alpha = 1.0
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Success", message: "The shortcut has been successfully installed! You may continue the setup.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    alert.view.tintColor = UIColor(named: "AccentColor")
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: "The shortcut was not installed successfully. Please re-setup MicNotes.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    alert.view.tintColor = UIColor(named: "AccentColor")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
