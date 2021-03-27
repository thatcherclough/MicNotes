//
//  InterfaceController.swift
//  MicNotes WatchKit Extension
//
//  Created by Thatcher Clough on 1/3/21.
//

import WatchKit
import Foundation
import WatchConnectivity
import ClockKit

class InterfaceController: WKInterfaceController {
    
    @IBAction func newNoteButtonPressAction(_ sender: Any) {
        getNoteAndSend(inputMode: .plain)
    }
    
    @IBAction func newNoteButtonLongPressAction(_ sender: Any) {
        if let state = (sender as? WKLongPressGestureRecognizer)?.state {
            if state == .began {
                getNoteAndSend(inputMode: .allowEmoji)
            }
        }
    }
    
    func getNoteAndSend(inputMode: WKTextInputMode) {
        presentTextInputController(withSuggestions: nil, allowedInputMode: inputMode, completion:{(results) -> Void in
            if let note = results?[0] as? String {
                WKInterfaceDevice.current().play(.success)
                self.sendNote(note: note)
            }
        })
    }
    
    func sendNote(note: String) {
        let data: [String: Any] = ["note": note as Any]
        if session.isReachable {
            session.sendMessage(data, replyHandler: nil) { (error) in
                self.storeNote(note: note)
            }
        } else {
            storeNote(note: note)
        }
    }
    
    func storeNote(note: String) {
        let defaults = UserDefaults.standard
        if var storredNotes = defaults.value(forKey: "storredNotes") as? [String] {
            storredNotes.append(note)
            defaults.set(storredNotes, forKey: "storredNotes")
        } else {
            defaults.set([note], forKey: "storredNotes")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        initWatchConnectivity()
    }

    let session = WCSession.default
    func initWatchConnectivity() {
        session.delegate = self
        session.activate()
    }
}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {}
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        let defaults = UserDefaults.standard
        if let storredNotes = defaults.value(forKey: "storredNotes") as? [String] {
            defaults.set(nil, forKey: "storredNotes")
            for note in storredNotes {
                sendNote(note: note)
            }
        }
    }
}

extension InterfaceController: WKExtensionDelegate {
    override func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
        getNoteAndSend(inputMode: .plain)
    }
}
