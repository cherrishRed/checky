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
      DailyHeaderView(date: viewModel.date)
      ScrollView(.vertical) {
        VStack(alignment: .leading) {
          if viewModel.events.count == 0 {
            VStack(alignment: .center) {
              Text("오늘은 일정이 없어요!")
                .padding(.top)
                .frame(maxWidth: .infinity)
            }
          } else {
            VStack(alignment: .leading, spacing: 4) {
              Text("오늘 일정")
                .padding(.leading, 4)
              eventView
            }
            .padding()
          }
          
          if viewModel.dayReminders.count != 0 || viewModel.timeReminders.count != 0 {
            VStack(alignment: .leading, spacing: 4) {
              Text("오늘이 마감인 미리알림")
                .padding(.leading, 4)
              reminderView
            }
            .padding()
          }
          
          if viewModel.clearedReminders.count == 0 {
            
          } else {
            VStack(alignment: .leading, spacing: 4) {
              Text("오늘 완료한 미리알림")
                .padding(.leading, 4)
              clearReminderView
            }
            .padding()
          }
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
        
        ForEach(viewModel.allDayEvents, id: \.self) { event in
          DailyCellView(viewModel: DailyCellViewModel(event: event, eventManager: viewModel.eventManager))
            .environmentObject(coordinator)
            .foregroundColor(Color.fontBlack)
        }
        
        ForEach(0..<viewModel.timeEvents.count, id: \.self) { index in
          VStack(alignment: .leading) {
            DailyCellView(viewModel: DailyCellViewModel(event: viewModel.timeEvents[index], eventManager: viewModel.eventManager))
              .environmentObject(coordinator)
              .foregroundColor(Color.fontBlack)
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
        
        ForEach(viewModel.dayReminders, id: \.self) { reminder in
          DailyReminderCellView(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
            .environmentObject(coordinator)
            .foregroundColor(Color.fontBlack)
        }
        
        ForEach(viewModel.timeReminders, id: \.self) { reminder in
          DailyReminderCellView(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
            .environmentObject(coordinator)
            .foregroundColor(Color.fontBlack)
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
        
        ForEach(viewModel.clearedReminders, id: \.self) { reminder in
          DailyReminderCellView(viewModel: DailyReminderCellViewModel(reminder: reminder, reminderManager: viewModel.reminderManager))
            .foregroundColor(Color.fontBlack)
        }
      }
      .padding()
    }
  }
}
