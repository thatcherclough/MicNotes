//
//  FinishViewController.swift
//  MicNotes
//
//  Created by Thatcher Clough on 3/27/21.
//

import Foundation
import UIKit

class FinishViewController: UIViewController {
    @IBAction func doneAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "finishedSetupBefore")
        dismiss(animated: true, completion: nil)
    }
}
