//
//  CalendarCellView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import SwiftUI

struct MonthlyCellView: View {
  
  @StateObject var viewModel: MonthlyCellViewModel
  
  var body: some View {
    ZStack(alignment: .top) {
      Rectangle()
        .fill(viewModel.dateValue.isCurrentMonth ? Color.basicWhite : Color.backgroundLightGray)
      
      VStack(spacing: 0) {
        ZStack {
          if Calendar.current.isDateInToday(viewModel.dateValue.date) {
            Circle()
              .fill(Color.fontBlack)
              .frame(width: 20, height: 20)
            Text(viewModel.dateValue.date.day)
              .font(.caption2)
              .foregroundColor(Color.basicWhite)
          } else {
            Text(viewModel.dateValue.date.day)
              .font(.caption2)
              .foregroundColor(viewModel.dateValue.isCurrentMonth ? Color.fontMediumGray : Color.fontLightGray)
          }
        }
        
        ForEach(viewModel.allEvnets, id: \.self) { event in
          EventBlockView(event: event)
        }
        
        ForEach(viewModel.dueDateReminders, id: \.self) { reminder in
          ReminderBlockView(reminder: reminder)
        }
      }
    }
  }
}

struct EventBlockView: View {
  let event: Event
  
  var body: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 2)
        .fill(Color(event.category.cgColor))
        .frame(maxWidth: .infinity)
        .layoutPriority(1)
      
      Text(event.ekevent.title)
        .padding(1)
        .lineLimit(1)
        .font(.caption2)
        .fontWeight(.semibold)
        .foregroundColor(Color.basicWhite)
        .fixedSize(horizontal: true, vertical: false)
    }
    .frame(height: 16)
    .padding(.vertical, 1.1)
    .padding(.horizontal, 0.5)
  }
}

struct ReminderBlockView: View {
  let reminder: Reminder
  
  var body: some View {
    HStack(spacing: 1) {
      ZStack {
        Circle()
          .stroke(Color(reminder.category.cgColor))
          .frame(width: 10 , height: 10)
        Circle()
          .fill(Color(reminder.category.cgColor))
          .frame(width: 6 , height: 6)
          .opacity(reminder.ekreminder.isCompleted ? 1.0 : 0.0)
      }
      
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(Color.basicWhite)
          .frame(maxWidth: .infinity)
          .layoutPriority(1)
        Text(reminder.ekreminder.title)
          .font(.caption2)
          .foregroundColor(Color.fontDarkBlack)
          .fixedSize(horizontal: true, vertical: false)
      }
    }
    .frame(height: 16)
    .padding(.horizontal, 2)
  }
}
