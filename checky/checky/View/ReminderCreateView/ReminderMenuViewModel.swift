//
//  ReminderMenuViewModel.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import Foundation
import EventKit

class ReminderMenuViewModel: ObservableObject {
  let eventManager = EventManager()
  let categories: [EKCalendar]
  
  @Published var title: String = ""
  @Published var memo: String = ""
  
  @Published var category: EKCalendar
  @Published var isShowCategoriesPicker: Bool = false
  
  @Published var priority: Int = 0
  
  @Published var isSetDate: Bool = false
  @Published var isShowDatePicker: Bool = false
  @Published var date: Date = .now
  
  @Published var isShowTimePicker: Bool = false
  @Published var isSetTime: Bool = false
  
  
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
  
  func closeAllPickers() {
    isShowCategoriesPicker = false
    isShowDatePicker = false
    isShowTimePicker = false
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
  
  func reset() {
    title = ""
    memo = ""
    isSetTime = false
    isSetTime = false
    priority = 0
    category = categories[0]
  }
  
  func saveNewReminder() {
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
