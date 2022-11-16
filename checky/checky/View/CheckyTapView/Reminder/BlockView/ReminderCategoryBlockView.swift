//
//  ReminderCategoryBlockView.swift
//  checky
//
//  Created by RED on 2022/11/08.
//

import SwiftUI
import EventKit

struct ReminderCategoryBlockView: View {
  @ObservedObject var viewModel: ReminderCategoryBlockViewModel

  init(category: EKCalendar, reminderManager: ReminderManager) {
    self._viewModel = ObservedObject(wrappedValue: ReminderCategoryBlockViewModel(category: category, reminderManager: reminderManager))
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(.white)
      VStack(alignment: .leading) {
        Text(viewModel.category.title)
        Rectangle()
          .fill(viewModel.color)
          .frame(height: 2)
        ForEach(viewModel.reminders, id: \.self) { reminder in
          HStack {
              ZStack {
                Circle()
                  .stroke(viewModel.color)
                  .frame(width: 14 , height: 14)
                Circle()
                  .fill(viewModel.color)
                  .frame(width: 8 , height: 8)
                  .opacity(reminder.ekreminder.isCompleted ? 1.0 : 0.0)
              }
         
            Text(reminder.ekreminder.title)
          }
        }
      }
      .padding()
    }
    .fixedSize(horizontal: false, vertical: true)

  }
}

class ReminderCategoryBlockViewModel: ViewModelable {
  @Published var reminders: [Reminder]
  
  let category: EKCalendar
  let reminderManager: ReminderManager
  
  init(category: EKCalendar, reminderManager: ReminderManager) {
    self.category = category
    self.reminderManager = reminderManager
    self.reminders = []
    
    
    reminderManager.getAllreminder(by: category) { reminders in
      DispatchQueue.main.async {
        self.reminders = reminders
      }
    }
  }
  
  enum Action {
    case onAppear
  }
  
  func action(_ action:Action) {
    switch action {
      case .onAppear:
        break
    }
  }
  
  var color: Color {
    let userColor = fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier)
    
    if userColor == Color.white {
      return Color(category.cgColor)
    } else {
      return fetchUserDefaultColor(calendarIdentifier: category.calendarIdentifier)
    }
  }
}
