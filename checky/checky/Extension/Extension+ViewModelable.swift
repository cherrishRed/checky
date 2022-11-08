//
//  Extension+ViewModelable.swift
//  checky
//
//  Created by RED on 2022/11/08.
//

import SwiftUI

extension ViewModelable {
  func fetchUserDefaultColor(calendarIdentifier: String) -> Color {
    guard let colorComponent = UserDefaults.standard.object(forKey: ("\(calendarIdentifier)_color")) as? [CGFloat] else {
      return Color.white
    }
    
   return  Color(.sRGB, red: colorComponent[0], green: colorComponent[1], blue: colorComponent[2], opacity: colorComponent[3])
  }
}
