//
//  MainViewController.swift
//  MicNotes
//
//  Created by Thatcher Clough on 1/8/21.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBAction func settingsButtonAction(_ sender: Any) {
        present(settingsNav, animated: true, completion: nil)
    }
    
    var settings: SettingsViewController!
    var settingsNav: UINavigationController!
    var setupNav: UINavigationController!
    
    override func viewDidLoad() {
        settingsNav = storyboard?.instantiateViewController(withIdentifier: "SettingsNavigationController") as? UINavigationController
        settingsNav.isModalInPresentation = true
        settings = settingsNav.viewControllers.first as? SettingsViewController
        settings.delegate = self
        setupNav = storyboard?.instantiateViewController(withIdentifier: "SetupNavigationController") as? UINavigationController
        setupNav.isModalInPresentation = true
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "finishedSetupBefore")
        if !launchedBefore {
            present(setupNav, animated: true, completion: nil)
        }
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func didSetNoteTitle(title: String!) {
        UserDefaults.standard.set(title, forKey: "noteTitle")
    }
    
    func didSelectShowSetup() {
        present(setupNav, animated: true, completion: nil)
    }
}
