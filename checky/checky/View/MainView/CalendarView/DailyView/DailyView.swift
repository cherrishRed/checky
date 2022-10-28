//
//  DailyView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct DailyView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  @State var events: [Event]
  
  init(events: [Event]) {
    self.events = events
  }
  
  var body: some View {
    VStack {
      HeaderView(viewModel: HeaderViewModel(dateHolder: DateHolder(), calendarHelper: WeeklyCalendarHelper()))
      ScrollView(.vertical) {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.basicWhite)
          VStack(spacing: 10) {
          ForEach(events, id: \.self) { event in
            let _ = print(event)
              DailyCellView(event: event)
            }
          }
          .padding()
        }
        .padding(.horizontal)
      }
    }
    .background(Color.backgroundGray)
  }
}
