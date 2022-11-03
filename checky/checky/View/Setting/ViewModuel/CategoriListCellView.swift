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
  @State var color: Color = .white
  @State var emoji: String = ""
  let category: EKCalendar
  let buttonAction: () -> ()
  let mode: EventMode
  var colorChangedNotification = NotificationCenter.default
    .publisher(for: UserDefaults.didChangeNotification)
  
  init(category: EKCalendar,mode: EventMode ,buttonAction: @escaping () -> ()) {
    self.category = category
    self.buttonAction = buttonAction
    self.mode = mode
    self.colorChangedNotification = NotificationCenter.default
      .publisher(for: UserDefaults.didChangeNotification)
  }
  
  var body: some View {
    Button(action: {
      buttonAction()
    }, label: {
      ZStack {
        Rectangle()
          .fill(Color.white)
          .frame(height: 30)
          .frame(maxWidth: .infinity)

        HStack {
          Text(category.title)
            .foregroundColor(Color.fontDarkBlack)
            .font(.title3)
          
          Spacer()
          
          if mode == .calendar {
            Text(emoji)
          }
          
          Rectangle()
            .fill(color)
            .frame(width: 10, height: 10)
        }
        .padding(.horizontal)
      }
    })
    .onAppear {
      color = fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier)
      emoji = fetchUserDefaultEmoji(calendarIdentifier: category.calendarIdentifier)
    }
    .onReceive(colorChangedNotification) { _ in
      color = fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier)
      emoji = fetchUserDefaultEmoji(calendarIdentifier: category.calendarIdentifier)

    }
  }
  
}
