//
//  SettingsViewController.swift
//  MicNotes
//
//  Created by Thatcher Clough on 1/8/21.
//

import Foundation
import UIKit

protocol SettingsViewControllerDelegate {
    func didSelectShowSetup()
    func didSetNoteTitle(title: String!)
}

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate: SettingsViewControllerDelegate?
    
    @IBOutlet var noteTitleTextField: UITextField!
    @IBAction func doneButtonAction(_ sender: Any) {
        noteTitleTextField.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        noteTitleTextField.delegate = self
        if let noteTitle = UserDefaults.standard.value(forKey: "noteTitle") as? String {
            noteTitleTextField.text = noteTitle
        }
    }
    
    // MARK: TextField related
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if range.location == text.count && string == " " {
                textField.text = text + "\u{00a0}"
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if noteTitleTextField.text != "" {
            delegate?.didSetNoteTitle(title: noteTitleTextField.text)
        } else {
            delegate?.didSetNoteTitle(title: nil)
        }
    }
    
    // MARK: Table related
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.setSelected(false, animated: true)
        
        if let label = cell.textLabel?.text {
            if label == "Show setup" {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Setup", message: "Show the setup instructions?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alertAction in
                        self.dismiss(animated: true) {
                            self.delegate?.didSelectShowSetup()
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    alert.view.tintColor = UIColor(named: "AccentColor")
                    self.present(alert, animated: true, completion: nil)
                }
                
            } else if label == "Thatcher Clough" {
                let screenName = "thatcherclough"
                let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
                let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
                
                let application = UIApplication.shared
                if application.canOpenURL(appURL as URL) {
                    application.open(appURL as URL)
                } else {
                    application.open(webURL as URL)
                }
            }
        }
    }
}
