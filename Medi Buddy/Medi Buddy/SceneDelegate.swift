//
//  SceneDelegate.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let firstNavigationController = UINavigationController(rootViewController: MediListViewController())
        let secondNavigationController = UINavigationController(rootViewController: MediCalendarViewController())
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([firstNavigationController, secondNavigationController], animated: true)
        tabBarController.tabBar.tintColor = .systemCyan
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "clock.badge.checkmark")
            items[0].image = UIImage(systemName: "clock.badge.checkmark")
            
            items[1].selectedImage = UIImage(systemName: "calendar")
            items[1].image = UIImage(systemName: "calendar")
        }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
