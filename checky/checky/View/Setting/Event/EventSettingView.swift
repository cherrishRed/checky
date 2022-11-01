//
//  EventSettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct EventSettingView: View {
  @ObservedObject var viewModel: EventSettingViewModel
  var body: some View {
    
    
    HStack {
      ForEach(viewModel.categories) { category in
        Circle()
          .fill(Color(cgColor: category.cgColor))
          .frame(width: 10, height: 10)
        Text(category.title)
          .foregroundColor(Color.fontDarkBlack)
          .font(.title3)
      }
    }
  }
}
