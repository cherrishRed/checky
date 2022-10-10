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
  case daily
  case add
  case setting
  case market
  
  var iconName: String {
    switch self {
    case .calendar:
      return "calendar"
    case .daily:
      return "circle"
    case .add:
      return "plus.circle"
    case .setting:
      return "gearshape"
    case .market:
      return "key"
    }
  }
    
  var color: Color {
    switch self {
    case .calendar:
      return Color.red
    case .daily:
      return Color.blue
    case .add:
      return Color.green
    case .setting:
      return Color.black
    case .market:
      return Color.yellow
    }
  }
}
