//
//  ReminderSettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct ReminderSettingView: View {
  @ObservedObject var viewModel: ReminderSettingViewModel
    var body: some View {
      
      ForEach(viewModel.categories) { category in
        HStack {
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
