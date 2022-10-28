//
//  DailyView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI
import EventKit

struct DailyView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  @State var events: [Event]
  @State var allDayEvents: [Event]
  @State var timeEvents: [Event]
  
  init(events: [Event]) {
    self.events = events
    self.allDayEvents = events.filter { $0.ekevent.isAllDay == true }
    self.timeEvents = events.filter { $0.ekevent.isAllDay == false }
      .sorted { first, second in
        return first.ekevent.startDate < second.ekevent.startDate
      }
  }
  
  var body: some View {
    VStack {
      HeaderView(viewModel: HeaderViewModel(dateHolder: DateHolder(), calendarHelper: WeeklyCalendarHelper()))
      ScrollView(.vertical) {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.basicWhite)
          VStack(spacing: 10) {
            ForEach(allDayEvents, id: \.self) { event in
              DailyCellView(event: event)
            }
            ForEach(0..<timeEvents.count, id: \.self) { index in
              VStack(alignment: .leading) {
                Button {
                  //
                } label: {
                  if index == 0 {
                    EmptyView()
                  } else if timeEvents[index-1].ekevent.overlapTime(timeEvents[index].ekevent) {
                    Image(systemName: "infinity")
                      .padding(.leading, 20)
                  } else {
                    Image(systemName: "plus.circle")
                      .padding(.leading, 20)
                  }
                }

                DailyCellView(event: timeEvents[index])
              }
            }
          }
          .padding()
        }
        .padding()
      }
      .background(Color.backgroundGray)
    }
  }
}

extension EKEvent {
  func overlapTime(_ event: EKEvent) -> Bool {
    return self.endDate > event.startDate
  }
}
