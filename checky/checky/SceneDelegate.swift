//
//  SceneDelegate.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
        
//    private let coordinator: Coordinator<MapRouter> = .init(startingRoute: .map)
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = coordinator.navigationController
        window?.rootViewController = UIHostingController(rootView: checkyApp())
        window?.makeKeyAndVisible()
//        coordinator.start()
    }
}
