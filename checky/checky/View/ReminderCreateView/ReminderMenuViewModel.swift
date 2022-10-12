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
}
