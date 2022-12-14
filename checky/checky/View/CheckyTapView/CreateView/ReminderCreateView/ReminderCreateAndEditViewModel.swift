//
//  ReminderCreateAndEditViewModel.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import Foundation
import EventKit

final class ReminderCreateAndEditViewModel: ObservableObject {
  let reminderManager: ReminderManager
  let categories: [EKCalendar]
  let reminder: Reminder?
  
  @Published var mode: Mode
  @Published var title: String
  @Published var memo: String
  @Published var category: EKCalendar?
  @Published var priority: Int
  @Published var date: Date
  @Published var isSetDate: Bool
  @Published var isSetTime: Bool
  @Published var isShowCategoriesPicker: Bool
  @Published var isShowDatePicker: Bool
  @Published var isShowTimePicker: Bool
  @Published var isShowAlert: Bool
  @Published var alertDiscription: String
  
  
  init(
    mode: ReminderCreateAndEditViewModel.Mode,
    title: String = "",
    memo: String = "",
    priority: Int = 0,
    date: Date = .now,
    isSetDate: Bool = false,
    isSetTime: Bool = false,
    isShowCategoriesPicker: Bool = false,
    isShowDatePicker: Bool = false,
    isShowTimePicker: Bool = false,
    reminderManager: ReminderManager
  ) {
    self.mode = mode
    self.title = title
    self.memo = memo
    self.priority = priority
    self.date = date
    self.isSetDate = isSetDate
    self.isSetTime = isSetTime
    self.isShowCategoriesPicker = isShowCategoriesPicker
    self.isShowDatePicker = isShowDatePicker
    self.isShowTimePicker = isShowTimePicker
    self.isShowAlert = false
    self.alertDiscription = ""
    self.reminderManager = reminderManager
    self.categories = reminderManager.getTaskCategories()
    self.category = categories.first
    
    
    self.reminder = nil
  }
  
  init(
    reminder: Reminder,
    reminderManager: ReminderManager
  ) {
    self.mode = .edit
    
    self.reminder = reminder
    
    self.title = reminder.ekreminder.title
    self.memo = reminder.ekreminder.notes ?? ""
    self.priority = reminder.ekreminder.priority
    
    self.isShowCategoriesPicker = false
    self.isShowDatePicker = false
    self.isShowTimePicker = false
    self.isShowAlert = false
    self.alertDiscription = ""
    self.reminderManager = reminderManager
    self.categories = reminderManager.getTaskCategories()
    self.category = reminder.ekreminder.calendar
    
    self.date = .now
    self.isSetDate = false
    self.isSetTime = false
    
    if reminder.ekreminder.dueDateComponents?.minute != nil{
      guard let date = reminder.ekreminder.dueDateComponents?.date else { return }
      self.date = date
      self.isSetDate = true
      self.isSetTime = true
    } else if reminder.ekreminder.dueDateComponents?.day != nil {
      guard let date = reminder.ekreminder.dueDateComponents?.date else { return }
      self.date = date
      self.isSetDate = true
      self.isSetTime = false
    }
  }
  
  enum Mode {
    case create
    case edit
    
    var title: String {
      switch self {
        case.create:
          return "????????? ???????????? ??????"
        case.edit:
          return "???????????? ??????"
      }
    }
  }
  
  enum Action {
    case tappedOutOfRange
    case tappedCloseButton
    case tappedCheckButton
    case tappedDeleteButton
    case togglePicker(Pickers)
    case tappedDateToggleButton
    case tappedTimeToggleButton
  }
  
  func action(_ action: Action) {
    switch action {
      case .tappedOutOfRange:
        tappedOutOfRange()
      case .tappedCloseButton:
        tappedCloseButton()
      case .tappedCheckButton:
        tappedCheckButton()
        closedModal()
      case .tappedDeleteButton:
        tappedDeleteButton()
      case .togglePicker(let picker):
        togglePicker(selectedPicker: picker)
      case .tappedDateToggleButton:
        tappedDateToggleButton()
      case .tappedTimeToggleButton:
        tappedTimeToggleButton()
    }
  }
  
  enum Pickers {
    case datePicker
    case timePicker
    case categoriesPicker
  }
  
  private func togglePicker(selectedPicker: Pickers) {
    var isShow: Bool
    
    switch selectedPicker {
      case .datePicker:
        isShow = isShowDatePicker
      case .timePicker:
        isShow = isShowTimePicker
      case .categoriesPicker:
        isShow = isShowCategoriesPicker
    }
    
    if isShow == false {
      closeAllPickers()
    }
    
    switch selectedPicker {
      case .datePicker:
        isShowDatePicker.toggle()
      case .timePicker:
        isShowTimePicker.toggle()
      case .categoriesPicker:
        isShowCategoriesPicker.toggle()
    }
  }
  
  private func tappedDateToggleButton() {
    if isSetDate == false {
      isSetDate = true
    } else {
      isSetDate = false
      isSetTime = false
      closeAllPickers()
    }
  }
  
  private func tappedTimeToggleButton() {
    if isSetTime == false {
      isSetTime = true
    } else {
      isSetTime = false
      closeAllPickers()
    }
  }
  
  private func tappedCheckButton() {
    if mode == .create {
      saveNewReminder()
    } else {
      editReminder()
    }
    closeAllPickers()
    reset()
  }
  
  private func tappedCloseButton() {
    closeAllPickers()
    reset()
  }
  
  private func tappedOutOfRange() {
    closeAllPickers()
  }
  
  private func tappedDeleteButton() {
    guard let task = reminder?.ekreminder else { return }
    reminderManager.deleteTask(task: task)
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
    category = categories.first
  }
  
  private func saveNewReminder() {
    let newReminder = EKReminder(eventStore: reminderManager.store)
    newReminder.title = title
    newReminder.priority = priority
    newReminder.notes = memo
    newReminder.calendar = category
    
    guard isSetDate == true else {
      
      switch reminderManager.createNewTask(newTask: newReminder) {
        case .failure(let failure):
          alertDiscription = failure.localizedDescription
        case .success(let success):
          alertDiscription = success
      }
      
      isShowAlert = true
      return
    }
    
    if isSetTime == false {
      let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
      newReminder.dueDateComponents = dateComponents
    } else {
      let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .month], from: date)
      newReminder.dueDateComponents = dateComponents
    }
    
    switch reminderManager.createNewTask(newTask: newReminder) {
      case .failure(let failure):
        alertDiscription = failure.localizedDescription
      case .success(let success):
        alertDiscription = success
    }
    
    
    isShowAlert = true
  }
  
  private func editReminder() {
    guard var reminder = reminder else { return }
    guard let category = category else { return }
    
    reminder.ekreminder.title = title
    reminder.ekreminder.priority = priority
    reminder.ekreminder.notes = memo
    reminder.ekreminder.calendar = category
    
    reminder.category = category
    
    guard isSetDate == true else {
      switch reminderManager.createNewTask(newTask: reminder.ekreminder) {
        case .failure(let failure):
          alertDiscription = failure.localizedDescription
        case .success(let success):
          alertDiscription = success
      }
      
      return
    }
    
    if isSetTime == false {
      let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
      reminder.ekreminder.dueDateComponents = dateComponents
    } else {
      let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .month], from: date)
      reminder.ekreminder.dueDateComponents = dateComponents
    }
    
    switch reminderManager.createNewTask(newTask: reminder.ekreminder) {
      case .failure(let failure):
        alertDiscription = failure.localizedDescription
        isShowAlert.toggle()
      case .success(let success):
        alertDiscription = success
        isShowAlert.toggle()
    }
  }
  
  private func closedModal() {
    NotificationCenter.default.post(name: Notification.Name("closedModal"), object: nil, userInfo: ["modal": true])
  }
}
