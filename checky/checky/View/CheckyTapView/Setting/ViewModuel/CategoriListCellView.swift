//
//  CategoriListCellView.swift
//  checky
//
//  Created by song on 2022/11/03.
//

import SwiftUI
import EventKit
import Combine

enum EventMode {
  case calendar
  case reminder
}

struct CategoriListCellView: View {
  @State var color: Color = Color.basicWhite
  @State var emoji: String = ""
  let category: EKCalendar
  let buttonAction: () -> ()
  let mode: EventMode
  var ChangedNotification = NotificationCenter.default
    .publisher(for: UserDefaults.didChangeNotification)
  
  init(category: EKCalendar,mode: EventMode ,buttonAction: @escaping () -> ()) {
    self.category = category
    self.buttonAction = buttonAction
    self.mode = mode
  }
  
  var body: some View {
    Button(action: {
      buttonAction()
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.basicWhite)
          .frame(maxWidth: .infinity)

        HStack {
          Text(category.title)
            .foregroundColor(Color.fontBlack)
            .font(.title3)
          
          Spacer()
          
          if mode == .calendar {
            Text(emoji)
          }
          
          RoundedRectangle(cornerRadius: 2)
            .fill(color)
            .frame(width: 16, height: 16)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
      }
    })
    .onAppear {
      color = fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier)
      if mode == .calendar {
        emoji = fetchUserDefaultEmoji(calendarIdentifier: category.calendarIdentifier)
      }
    }
    .onReceive(ChangedNotification) { _ in
      color = fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier)
      if mode == .calendar {
        emoji = fetchUserDefaultEmoji(calendarIdentifier: category.calendarIdentifier)
      }
    }
  }
}
