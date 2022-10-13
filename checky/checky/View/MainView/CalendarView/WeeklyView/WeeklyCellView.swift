//
//  WeeklyCellView.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import SwiftUI

struct WeeklyCellView: View {
  @State var dateValue: DateValue
  @State var allEvnets: [Event] = []
  @State var allReminders: [Reminder] = []
  
  var body: some View {
    ZStack {
      
      RoundedRectangle(cornerRadius: 10)
        .fill(Color("basicWhite"))
      
      VStack(alignment: .leading) {
        HStack {
          Text(dateValue.date.dayOfWeek)
            .foregroundColor(.black.opacity(0.5))
          Text(dateValue.date.day)
        }
        
        ForEach(allEvnets, id: \.self) { event in
          WeeklyEventBlockView(event: event)
        }
        
        ForEach(allReminders, id: \.self) { reminder in
          ReminderBlockView(reminder: reminder)
        }
      }
    }
  }
}

struct WeeklyEventBlockView: View {
  let event: Event
  
  var body: some View {
    ZStack(alignment: .leading) {
      Rectangle()
        .fill(Color(event.category.cgColor))
        .frame(maxWidth: .infinity)
        .layoutPriority(1)
      
      Text(event.ekevent.title)
        .padding(1)
        .lineLimit(1)
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundColor(Color("basicWhite"))
        .fixedSize(horizontal: true, vertical: false)
    }
    .frame(height: 16)
    .padding(.vertical, 1.1)
  }
}

struct WeeklyReminderBlockView: View {
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
          .fill(Color("basicWhite"))
          .frame(maxWidth: .infinity)
          .layoutPriority(1)
        Text(reminder.ekreminder.title)
          .font(.caption)
          .foregroundColor(Color("fontDarkBlack"))
          .fixedSize(horizontal: true, vertical: false)
        Text(reminder.ekreminder.description)
          .font(.caption)
          .foregroundColor(Color("fontDarkBlack"))
          .fixedSize(horizontal: true, vertical: false)
      }
    }
    .frame(height: 16)
    .padding(.horizontal, 2)
  }
}
