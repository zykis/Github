//
//  AppDelegate.swift
//  Github
//
//  Created by Артём Зайцев on 15.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootVC = UserViewController(nibName: nil, bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

