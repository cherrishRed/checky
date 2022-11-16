//
//  WeeklyCellView.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import SwiftUI

struct WeeklyCellView: View {
  @StateObject var viewModel: WeeklyCellViewModel
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.basicWhite)
      
      VStack(alignment: .leading, spacing: 4) {
        HStack {
          Text(viewModel.dateValue.date.dayOfWeek)
            .font(.caption2)
            .foregroundColor(Color.fontBlack.opacity(0.5))
          ZStack {
            if Calendar.current.isDateInToday(viewModel.dateValue.date) {
              Circle()
                .fill(Color.fontBlack)
                .frame(width: 20, height: 20)
            }
            Text(viewModel.dateValue.date.day)
              .font(.caption2)
              .foregroundColor(Calendar.current.isDateInToday(viewModel.dateValue.date) ? Color.basicWhite : Color.fontBlack)
          }
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
        
        ScrollView {
          VStack(alignment: .leading, spacing: 6) {
            
            VStack(alignment: .leading, spacing: 2) {
              ForEach(viewModel.allEvnets, id: \.self) { event in
                WeeklyEventBlockView(event: event)
                  .frame(height: 20)
              }
            }
            
            VStack(alignment: .leading, spacing: 2) {
              ForEach(viewModel.filteredHightPriorityDuedateReminder(), id: \.self) { reminder in
                WeeklyReminderBlockView(reminder: reminder)
                  .frame(height: 14)
              }
              
              ForEach(viewModel.filteredHightPriorityClearedReminder(), id: \.self) { reminder in
                WeeklyReminderBlockView(reminder: reminder)
                  .frame(height: 14)
              }
            }
          }
          .padding(.horizontal, 6)
        }
      }
    }
  }
}

struct WeeklyEventBlockView: View {
  let event: Event
  
  var body: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 4)
        .fill(color)
        .frame(maxWidth: .infinity)
        .layoutPriority(1)
      
      Text(event.ekevent.title)
        .lineLimit(1)
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundColor(Color.basicWhite)
        .fixedSize(horizontal: true, vertical: false)
        .padding(.horizontal, 4)
    }
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

struct WeeklyReminderBlockView: View {
  let reminder: Reminder
  
  var body: some View {
    HStack(spacing: 4) {
      ZStack {
        
        Circle()
          .stroke(color)
          .frame(width: 10 , height: 10)
        Circle()
          .fill(color)
          .frame(width: 6 , height: 6)
          .opacity(reminder.ekreminder.isCompleted ? 1.0 : 0.0)
      }
      
      Text(reminder.ekreminder.title)
        .font(.caption)
        .foregroundColor(Color.fontBlack)
        .fixedSize(horizontal: true, vertical: false)
    }
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
