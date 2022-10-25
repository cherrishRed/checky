//
//  TabBarItem.swift
//  CustomTabView
//
//  Created by RED, Taeangel on 2022/10/10.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
  case calendar
  case reminder
  case setting
  
  var iconName: String {
    switch self {
    case .calendar:
      return "square.on.square"
    case .reminder:
      return "circle"
    case .setting:
      return "gearshape"
    }
  }
  
  var selectedName: String {
    switch self {
    case .calendar:
      return "square.filled.on.square"
    case .reminder:
      return "circle.fill"
    case .setting:
      return "gearshape.fill"
    }
  }
    
  var color: Color {
    switch self {
    case .calendar:
      return Color.pointRed
    case .reminder:
      return Color.pointRed
    case .setting:
      return Color.pointRed
    }
  }
}
