//
//  SceneDelegate.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
  
  private let coordinator: Coordinator<checkyRouter> = .init(startingRoute: .main)
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = coordinator.navigationController
    window?.makeKeyAndVisible()
    coordinator.start()
  }
}
