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
    isShowCategoriesPicker.toggle()
  }
  
  func toggleDatePicker() {
    isShowDatePicker.toggle()
  }
  
  func toggleTimePicker() {
    isShowTimePicker.toggle()
  }
  
  func closeAllPickers() {
    isShowCategoriesPicker = false
  }
}
