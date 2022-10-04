//
//  Extension+Text.swift
//  checky
//
//  Created by song on 2022/10/04.
//

import SwiftUI

extension Text {
  func weekStyle() -> some View {
    self.frame(maxWidth: .infinity)
      .padding(.top)
      .lineLimit(1)
  }
}
