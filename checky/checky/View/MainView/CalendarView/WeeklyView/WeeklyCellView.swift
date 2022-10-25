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
        .fill(Color("basicWhite"))
      
      VStack(alignment: .leading) {
        HStack {
          Text(viewModel.dateValue.date.dayOfWeek)
            .foregroundColor(.black.opacity(0.5))
          Text(viewModel.dateValue.date.day)
        }
        .padding(6)
        
        ScrollView {
          VStack {
            ForEach(viewModel.allEvnets, id: \.self) { event in
              WeeklyEventBlockView(event: event)
                .frame(height: 20)
            }
            
            ForEach(viewModel.allReminders, id: \.self) { reminder in
              ReminderBlockView(reminder: reminder)
                .frame(height: 14)
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
        .fill(Color(event.category.cgColor))
        .frame(maxWidth: .infinity)
        .layoutPriority(1)
      
      Text(event.ekevent.title)
        .lineLimit(1)
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundColor(Color("basicWhite"))
        .fixedSize(horizontal: true, vertical: false)
    }
  }
}

struct WeeklyReminderBlockView: View {
  let reminder: Reminder
  
  var body: some View {
    HStack() {
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
          .fill(Color("basicWhite"))
          .frame(maxWidth: .infinity)
          .layoutPriority(1)
        Text(reminder.ekreminder.title)
          .font(.caption)
          .foregroundColor(Color("fontDarkBlack"))
          .fixedSize(horizontal: true, vertical: false)
        Text(reminder.ekreminder.notes ?? "")
          .font(.caption)
          .foregroundColor(Color("fontDarkBlack"))
          .fixedSize(horizontal: true, vertical: false)
      }
    }
  }
}
