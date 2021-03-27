//
//  DownloadShortcutsViewController.swift
//  MicNotes
//
//  Created by Thatcher Clough on 1/7/21.
//

import Foundation
import UIKit

class DownloadShortcutsViewController: UIViewController {
    @IBAction func downloadButtonAction(_ sender: Any) {
        let url = URL(string: "itms-apps://apple.com/app/id915249334")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Could not opern url", message: "Please try again or manually donwload Siri Shortcuts.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                alert.view.tintColor = UIColor(named: "AccentColor")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
