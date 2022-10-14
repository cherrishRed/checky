//
//  ReminderCreateAndEditViewModel.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import Foundation
import EventKit

class ReminderCreateAndEditViewModel: ObservableObject {
  let eventManager = EventManager()
  let categories: [EKCalendar]
  
  @Published var mode: Mode = .create
  
  @Published var title: String = ""
  @Published var memo: String = ""
  @Published var category: EKCalendar
  @Published var priority: Int = 0
  @Published var date: Date = .now
  
  @Published var isSetDate: Bool = false
  @Published var isSetTime: Bool = false
  
  @Published var isShowCategoriesPicker: Bool = false
  @Published var isShowDatePicker: Bool = false
  @Published var isShowTimePicker: Bool = false
  
  enum Mode {
    case create
    case edit
    
    var title: String {
      switch self {
        case.create:
          return "새로운 미리알림 추가"
        case.edit:
         return "미리알림 수정"
      }
    }
  }
  
  init() {
    self.categories = eventManager.getReminderCategories()
    self.category = categories[0]
  }
  
  func toggleCategoriesPicker() {
    if isShowCategoriesPicker == true {
      isShowCategoriesPicker = false
    } else {
      closeAllPickers()
      isShowCategoriesPicker = true
    }
  }
  
  func toggleDatePicker() {
    if isShowDatePicker == true {
      isShowDatePicker = false
    } else {
      closeAllPickers()
      isShowDatePicker = true
    }
  }
  
  func toggleTimePicker() {
    if isShowTimePicker == true {
      isShowTimePicker = false
    } else {
      closeAllPickers()
      isShowTimePicker = true
    }
  }
  
  
  func tappedDateToggleButton() {
    if isSetDate == false {
      isSetDate = true
    } else {
      isSetDate = false
      isSetTime = false
      closeAllPickers()
    }
  }
  
  func tappedTimeToggleButton() {
    if isSetTime == false {
      isSetTime = true
    } else {
      isSetTime = false
      closeAllPickers()
    }
  }
  
  func tappedCheckButton() {
    if mode == .create {
      saveNewReminder()
    } else {
      // edit
    }
    closeAllPickers()
    reset()
  }
  
  func tappedCloseButton() {
    closeAllPickers()
    reset()
  }
  
  func tappedOutOfRange() {
    closeAllPickers()
  }
  
  func tappedDeleteButton() {
    
  }
  
  private func closeAllPickers() {
    isShowCategoriesPicker = false
    isShowDatePicker = false
    isShowTimePicker = false
  }
  
  private func reset() {
    title = ""
    memo = ""
    isSetTime = false
    isSetTime = false
    priority = 0
    category = categories[0]
  }
  
  private func saveNewReminder() {
    let newReminder = EKReminder(eventStore: eventManager.store)
    newReminder.title = title
    newReminder.priority = priority
    newReminder.notes = memo
    newReminder.calendar = category
  
    if isSetDate == true && isSetTime == false {
      let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
      newReminder.dueDateComponents = dateComponents
    } else if isSetDate == true && isSetTime == true {
      let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .month], from: date)
      newReminder.dueDateComponents = dateComponents
    }
    
    eventManager.createNewReminder(newReminder: newReminder)
  }
}
