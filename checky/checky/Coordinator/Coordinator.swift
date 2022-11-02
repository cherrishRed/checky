//
//  Coordinator.swift
//  checky
//
//  Created by RED on 2022/10/06.
//

import SwiftUI

class Coordinator<Router: NavigationRouter>: ObservableObject {
  
  let navigationController: UINavigationController
  let startingRoute: Router?
  
  init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
    self.navigationController = navigationController
    self.startingRoute = startingRoute
  }
  
  func start() {
    guard let route = startingRoute else { return }
    show(route)
  }
  
  func show(_ route: Router, animated: Bool = true) {
    let view = route.view()
    let viewWithCoordinator = view.environmentObject(self)
    let viewController = UIHostingController(rootView: viewWithCoordinator)
    switch route.transition {
    case .push:
      navigationController.pushViewController(viewController, animated: animated)
    case .presentModally:
      viewController.modalPresentationStyle = .formSheet
      navigationController.present(viewController, animated: animated)
    case .presentFullscreen:
      viewController.modalPresentationStyle = .fullScreen
      navigationController.present(viewController, animated: animated)
    case .presentHalfModally:
      viewController.sheetPresentationController?.detents = [.medium(), .large()]
      viewController.sheetPresentationController?.prefersGrabberVisible = true
      navigationController.present(viewController, animated: animated)
    }
  }
  
  func pop(animated: Bool = true) {
    navigationController.popViewController(animated: animated)
  }
  
  func popToRoot(animated: Bool = true) {
    navigationController.popToRootViewController(animated: animated)
  }
  
  func dismiss(animated: Bool = true) {
    navigationController.dismiss(animated: true)
  }
}
