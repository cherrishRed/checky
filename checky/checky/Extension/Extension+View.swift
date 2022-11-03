//
//  Extension+View.swift
//  checky
//
//  Created by RED on 2022/10/12.
//

import SwiftUI

// MARK: - keyBoard
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

// MARK: - Color
extension View {
  func fetchUserDefaultColor(calendarIdentifier: String) -> Color {
    guard let colorComponent = UserDefaults.standard.object(forKey: ("\(calendarIdentifier)_color")) as? [CGFloat] else {
      return Color.white
    }
    
   return  Color(.sRGB, red: colorComponent[0], green: colorComponent[1], blue: colorComponent[2], opacity: colorComponent[3])
  }
}

// MARK: - Emoji

extension View {
  func fetchUserDefaultEmoji(calendarIdentifier: String) -> String {
   return UserDefaults.standard.string(forKey: ("\(calendarIdentifier)_imoji")) ?? ""
  }
}
