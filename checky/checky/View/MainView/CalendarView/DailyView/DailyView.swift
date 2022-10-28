//
//  DailyView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct DailyView: View {
  var body: some View {
    VStack {
      HeaderView(viewModel: HeaderViewModel(dateHolder: DateHolder(), calendarHelper: WeeklyCalendarHelper()))
      ScrollView(.vertical) {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.basicWhite)
          VStack(spacing: 10) {
            DailyCellView()
            DailyCellView()
          }
          .padding()
        }
        .padding(.horizontal)
      }
    }
    .background(Color.backgroundGray)
  }
}

struct DailyView_Previews: PreviewProvider {
  static var previews: some View {
    DailyView()
  }
}
