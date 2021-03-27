//
//  AddMicNotesShortcutViewController.swift
//  MicNotes
//
//  Created by Thatcher Clough on 3/27/21.
//

import Foundation
import UIKit

class AddMicNotesShortcutViewController: UIViewController {
    @IBAction func downloadShortcutAction(_ sender: Any) {
        let url = URL(string: "https://www.icloud.com/shortcuts/6a1b52c859a44647b553412356ec491c")!
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
}
