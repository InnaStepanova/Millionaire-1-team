//
//  SceneDelegate.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 06.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = GameViewController()
        window?.makeKeyAndVisible()
    }
    
}
