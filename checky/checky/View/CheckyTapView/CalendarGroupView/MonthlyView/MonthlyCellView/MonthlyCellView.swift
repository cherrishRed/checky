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
              .frame(height: 20)
              .font(.caption2)
              .foregroundColor(viewModel.dateValue.isCurrentMonth ? Color.fontMediumGray : Color.fontLightGray)
              
          }
        }
        Group {
          ForEach(viewModel.allEvnets, id: \.self) { event in
            EventBlockView(event: event)
          }
          
          ForEach(viewModel.filteredHightPriorityDuedateReminder(), id: \.self) { reminder in
            ReminderBlockView(reminder: reminder)
          }
          
          ForEach(viewModel.filteredHightPriorityClearedReminder(), id: \.self) { reminder in
            ReminderBlockView(reminder: reminder)
          }
        }
        .opacity(viewModel.dateValue.isCurrentMonth ? 1.0 : 0.3)
      }
    }
  }
}

struct EventBlockView: View {
  let event: Event
  
  var body: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 2)
        .fill(color)
        .frame(maxWidth: .infinity)
        .layoutPriority(1)
      
      Text(event.ekevent.title)
        .padding(1)
        .lineLimit(1)
        .font(.caption2)
        .font(Font.title.weight(.semibold))
        .foregroundColor(Color.basicWhite)
        .fixedSize(horizontal: true, vertical: false)
    }
    .frame(height: 16)
    .padding(.vertical, 1.1)
    .padding(.horizontal, 0.5)
  }
  
  var color: Color {
    let userColor = fetchUserDefaultColor(calendarIdentifier: event.category.calendarIdentifier)
    
    if userColor == Color.white {
      return Color(event.category.cgColor)
    } else {
      return fetchUserDefaultColor(calendarIdentifier: event.category.calendarIdentifier)
    }
  }
}

struct ReminderBlockView: View {
  let reminder: Reminder
  
  var body: some View {
    HStack(spacing: 1) {
      ZStack {
        Circle()
          .stroke(color)
          .frame(width: 10 , height: 10)
        Circle()
          .fill(color)
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
          .foregroundColor(Color.fontBlack)
          .fixedSize(horizontal: true, vertical: false)
      }
    }
    .frame(height: 16)
    .padding(.horizontal, 2)
  }
  
  var color: Color {
    let userColor = fetchUserDefaultColor(calendarIdentifier: reminder.category.calendarIdentifier)
    
    if userColor == Color.white {
      return Color(reminder.category.cgColor)
    } else {
      return fetchUserDefaultColor(calendarIdentifier: reminder.category.calendarIdentifier)
    }
  }
}
