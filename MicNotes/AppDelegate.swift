//
//  AppDelegate.swift
//  MicNotes
//
//  Created by Thatcher Clough on 1/3/21.
//

import UIKit
import WatchConnectivity

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initWatchConnectivity()
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    var session: WCSession?
    func initWatchConnectivity() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
}

extension AppDelegate: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("deactivated")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activated")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if var note = message["note"] as? String {
                let title = UserDefaults.standard.value(forKey: "noteTitle") ?? "Note from Apple Watch."
                note = "\(title)\n\(note)"
                
                let defaults = UserDefaults(suiteName: "group.dev.thatcherclough.MicNotes")!
                if var existingNotes = defaults.value(forKey: "notes") as? [String] {
                    existingNotes.append(note)
                    defaults.set(existingNotes, forKey: "notes")
                } else {
                    defaults.set([note], forKey: "notes")
                }
            }
        }
    }
}
