//
//  ButtonStyle.swift
//  checky
//
//  Created by RED on 2022/10/25.
//

import SwiftUI

struct ToggleButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .frame(minWidth: 70)
      .padding(.horizontal, 4)
      .background {
        RoundedRectangle(cornerRadius: 4)
          .foregroundColor(.gray)
      }
  }
}
