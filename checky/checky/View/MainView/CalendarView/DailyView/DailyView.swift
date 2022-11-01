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
        VStack {
          eventView
            .padding()
          Text("마감 임박 일정")
          reminderView
            .padding()
          Text("오늘 완료한 일정")
          clearReminderView
            .padding()
        }
      }
      .background(Color.backgroundGray)
    }
  }
  
  var eventView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(Color.basicWhite)
      VStack(spacing: 10) {
        // 하루종일 일정
        ForEach(viewModel.allDayEvents, id: \.self) { event in
          DailyCellView(event: event)
        }
        
        // 시간이 정해져 있는 이벤트
        ForEach(0..<viewModel.timeEvents.count, id: \.self) { index in
          VStack(alignment: .leading) {
            DailyCellView(event: viewModel.timeEvents[index])
          }
        }
      }
      .padding()
    }
  }
  
  var reminderView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(Color.basicWhite)
      VStack(spacing: 10) {
        
        // 하루종일 reminder
        ForEach(viewModel.dayReminders, id: \.self) { reminder in
          DailyReminderCell(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
        }
        
        // 시간이 정해져 있는 리마인더
        ForEach(viewModel.timeReminders, id: \.self) { reminder in
          DailyReminderCell(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
        }
      }
      .padding()
    }
  }
  
  var clearReminderView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(Color.basicWhite)
      VStack(spacing: 10) {
        
        // 하루종일 reminder
        ForEach(viewModel.dayReminders, id: \.self) { reminder in
          DailyReminderCell(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
        }
        
        // 시간이 정해져 있는 리마인더
        ForEach(viewModel.timeReminders, id: \.self) { reminder in
          DailyReminderCell(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
        }
      }
      .padding()
    }
  }
}

extension EKEvent {
  func overlapTime(_ event: EKEvent) -> Bool {
    return self.endDate > event.startDate
  }
}
