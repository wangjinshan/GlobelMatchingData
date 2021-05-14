//
//  SceneDelegate.swift
//  GlobelMatching
//
//  Created by shan on 2021/5/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)
            let timeline = RootViewController()

            let navigation = UINavigationController(rootViewController: timeline)
            window.rootViewController = navigation

            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


