//
//  CalendarCellView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import SwiftUI

struct CalendarCellView: View {
  @State var dateValue: DateValue
  @State var allEvnets: [Event] = []
  @State var allReminders: [Reminder] = []
  
    var body: some View {
      ZStack(alignment: .top) {
        Rectangle()
              .fill(dateValue.isCurrentMonth ? Color("basicWhite") : Color("backgroundLightGray"))
          VStack(spacing: 0) {
          Text(dateValue.date.day)
            .foregroundColor(dateValue.isCurrentMonth ? Color("fontMediumGray") : Color("fontLightGray"))
          ForEach(allEvnets, id: \.self) { event in
              EventBlockView(event: event)
                  .padding(1)
        }
          ForEach(allReminders, id: \.self) { reminder in
            HStack(spacing: 1) {
              if reminder.ekreminder.isCompleted == true {
                Image(systemName: "circle.fill")
                  .foregroundColor(Color(reminder.category.cgColor))
                  .frame(width: 4, height: 4)
              } else {
                Image(systemName: "circle")
                  .foregroundColor(Color(reminder.category.cgColor))
                  .frame(width: 4, height: 4)
              }
              Text(reminder.ekreminder.title)
                .lineLimit(1)
                .font(.caption)
                .frame(maxWidth: .infinity)
            }

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
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(Color("basicWhite"))
            .fixedSize(horizontal: true, vertical: false)
        }
        .frame(height: 16)
    }
}
