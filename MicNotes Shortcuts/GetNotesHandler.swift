//
//  GetNotesHandler.swift
//  MicNotes Shortcuts
//
//  Created by Thatcher Clough on 1/3/21.
//

import Foundation
import Intents

class GetNotesHandler: NSObject, GetNotesIntentHandling {
    func handle(intent: GetNotesIntent, completion: @escaping (GetNotesIntentResponse) -> Void) {
        let defaults = UserDefaults(suiteName: "group.dev.thatcherclough.MicNotes")!
        if let note = defaults.value(forKey: "test") as? String {
            defaults.set("success", forKey: "test")
            completion(GetNotesIntentResponse.success(notes: [note]))
        } else if let notes = defaults.value(forKey: "notes") as? [String] {
            defaults.set(nil, forKey: "notes")
            completion(GetNotesIntentResponse.success(notes: notes))
        } else {
            completion(GetNotesIntentResponse.success(notes: []))
        }
    }
}
