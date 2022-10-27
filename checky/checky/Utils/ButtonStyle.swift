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

struct CreateButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Self.Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.basicWhite)
        .frame(maxWidth:.infinity)
      
      HStack {
        configuration.label
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(.fontBlack)
      }
    }
  }
}
