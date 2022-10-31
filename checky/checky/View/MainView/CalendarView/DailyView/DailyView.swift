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
  @ObservedObject var viewModel: DailyViewModel
  
  init(viewModel: DailyViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      HeaderView(viewModel: HeaderViewModel(dateHolder: DateHolder(), calendarHelper: WeeklyCalendarHelper()))
      ScrollView(.vertical) {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.basicWhite)
          VStack(spacing: 10) {
            ForEach(viewModel.allDayEvents, id: \.self) { event in
              DailyCellView(event: event)
            }
            
            ForEach(viewModel.reminders, id: \.self) { reminder in
              DailyReminderCell(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
            }
            
            ForEach(0..<viewModel.timeEvents.count, id: \.self) { index in
              VStack(alignment: .leading) {
                DailyCellView(event: viewModel.timeEvents[index])
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
