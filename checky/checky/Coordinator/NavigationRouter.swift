//
//  NavigationRouter.swift
//  checky
//
//  Created by RED on 2022/10/06.
//

import SwiftUI

protocol NavigationRouter {
    
    associatedtype V: View

    var transition: NavigationTranisitionStyle { get }

    @ViewBuilder
    func view() -> V
}
