//
//  Extension+View.swift
//  checky
//
//  Created by RED on 2022/10/12.
//

import SwiftUI

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
