//
//  AppDelegate.swift
//  covid19
//
//  Created by Stefan Projchev on 3/31/20.
//  Copyright © 2020 venikom.com. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
#warning("You need to add your own GoogleService-Info.plist file")
    
    var window: UIWindow?
    var auth: Auth!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /* Third Party */
        FirebaseApp.configure()
        auth = Auth.auth()
        
        /* Localization */
        if auth.currentUser == nil {
            LocalizationManager.changeLocalizationTo(localization: .macedonian)
            
            #warning("Remove this line after you successfully fill firestore with data")
            DBImport.saveDataToFirestore()
        }
        
        /* Mesh Network */
        ConnectionsManager.shared.startNetwork()
        
                
        /* Sign In Anonymously */
        signInAnonymously()

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        ConnectionsManager.shared.saveTimer?.invalidate()
        ConnectionsManager.shared.saveData()
    }
    
    private func signInAnonymously() {
        guard auth.currentUser == nil else { return }
        auth.signInAnonymously { (_, _) in
            /* Mesh Network */
            ConnectionsManager.shared.startPublishing()
            
        }
    }
}
