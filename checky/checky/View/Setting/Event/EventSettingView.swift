//
//  EventSettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct EventSettingView: View {
  @ObservedObject var viewModel: EventSettingViewModel
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>

  var body: some View {
    
    VStack(alignment: .leading) {
      ForEach(viewModel.categories) { category in
        
        Button(action: {
          coordinator.show(.EventSettingButton(category: category, eventManager: viewModel.eventManager))
        }, label: {
          Rectangle()
            .fill(Color(cgColor: category.cgColor))
            .frame(width: 10, height: 10)
          Text(category.title)
            .foregroundColor(Color.fontDarkBlack)
            .font(.title3)
        })
      }
    }.background(Color.backgroundGray)
  }
}
