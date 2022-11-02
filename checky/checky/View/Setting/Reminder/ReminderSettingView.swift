//
//  ReminderSettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct ReminderSettingView: View {
  @ObservedObject var viewModel: ReminderSettingViewModel
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  var body: some View {
    
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(viewModel.categories) { category in
          
          Button(action: {
            coordinator.show(.ReminderSettingButton(category: category))
          }, label: {
            ZStack {
              Rectangle()
                .fill(Color.white)
                .frame(height: 30)
                .frame(maxWidth: .infinity)

              HStack {
                Text(category.title)
                  .foregroundColor(Color.fontDarkBlack)
                  .font(.title3)
                
                Spacer()
                
                Rectangle()
                  .fill(Color(cgColor: category.cgColor))
                  .frame(width: 10, height: 10)
               }
              .padding(.horizontal)
            }
            .frame(alignment: .top)
          })
        }
      }
      .padding(.horizontal, 15)
    }
    .background(Color.backgroundGray)
  }
}