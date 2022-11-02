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
    
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(viewModel.categories) { category in
          
          Button(action: {
            coordinator.show(.EventSettingButton(category: category))
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
                  .fill(fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier))
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
