//
//  SceneDelegate.swift
//  JTAppleCalendarExample
//
//  Created by Seokho on 2019/11/22.
//  Copyright © 2019 Seokho. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.windowScene = scene
        
        let viewControlelr = ViewController()
        self.window?.rootViewController = viewControlelr
        self.window?.makeKeyAndVisible()
    }

}

