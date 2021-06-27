//
//  AppDelegate.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/03.
//

import UIKit
import WatchConnectivity

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

@main
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("iOS activationDidCompleteWith state= \(activationState.rawValue)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("iOS sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("iOS sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        replyHandler(["reply" : "OK"])
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if WCSession.isSupported() {
            print("is Supported")
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
                    fatalError("Not found: '/path/to/.env'.\nPlease create .env file reference from .env.sample")
                }
                let url = URL(fileURLWithPath: path)
                do {
                    let data = try Data(contentsOf: url)
                    let str = String(data: data, encoding: .utf8) ?? "Empty File"
                    let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
                    let envVars = clean.components(separatedBy:"\n")
                    for envVar in envVars {
                        let keyVal = envVar.components(separatedBy:"=")
                        if keyVal.count == 2 {
                            setenv(keyVal[0], keyVal[1], 1)
                        }
                    }
                } catch {
                    fatalError(error.localizedDescription)
                }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

