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
        VStack {
          Text(dateValue.date.day)
            .foregroundColor(dateValue.isCurrentMonth ? Color("fontMediumGray") : Color("fontLightGray"))
          ForEach(allEvnets, id: \.self) { event in
            Text(event.ekevent.title)
              .lineLimit(1)
              .font(.caption)
              .foregroundColor(.white)
              .background(Color(event.category.cgColor))
              .cornerRadius(2)
              .frame(maxWidth: .infinity)
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
