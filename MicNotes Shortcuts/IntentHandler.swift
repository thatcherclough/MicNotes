//
//  IntentHandler.swift
//  MicNotes Shortcuts
//
//  Created by Thatcher Clough on 1/3/21.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        switch intent {
        case is GetNotesIntent:
            return GetNotesHandler()
        default:
            fatalError("No handler for this intent")
        }
    }
}
