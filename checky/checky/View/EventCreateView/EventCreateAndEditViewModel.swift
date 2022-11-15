//
//  EventCreateAndEditViewModel.swift
//  checky
//
//  Created by RED on 2022/10/12.
//

import Foundation
import EventKit

class EventCreateAndEditViewModel: ObservableObject {
  let eventManager: EventManager
  let categories: [EKCalendar]
  let event: Event?
  
  @Published var mode: Mode
  @Published var title: String
  @Published var date: Date
  @Published var endDate: Date
  @Published var isAllDay: Bool
  @Published var category: EKCalendar
  @Published var memo: String
  @Published var alram: AlramTime
  @Published var isShowDatePicker: Bool
  @Published var isShowEndDatePicker: Bool
  @Published var isShowCategoriesPicker: Bool
  @Published var isShowAlramPicker: Bool
  @Published var isShowAlert: Bool
  @Published var alertDescription: String
  
  
  init(
    mode: EventCreateAndEditViewModel.Mode,
    title: String = "",
    date: Date = .now,
    endDate: Date = .now,
    isAllDay: Bool = false,
    memo: String = "",
    alram: AlramTime = .none,
    isShowDatePicker: Bool = false,
    isShowEndDatePicker: Bool = false,
    isShowCategoriesPicker: Bool = false,
    isShowAlramPicker: Bool = false,
    eventManager: EventManager
    
  ) {
    self.mode = mode
    self.title = title
    self.date = date
    self.endDate = endDate
    self.isAllDay = isAllDay
    self.memo = memo
    self.alram = alram
    self.isShowDatePicker = isShowDatePicker
    self.isShowEndDatePicker = isShowEndDatePicker
    self.isShowCategoriesPicker = isShowCategoriesPicker
    self.isShowAlramPicker = isShowAlramPicker
    self.isShowAlert = false
    self.alertDescription = ""
    
    let fetchedCategories = eventManager.getTaskCategories()
    self.categories = fetchedCategories.filter { $0.title != "Birthdays"}
    self.category = categories[0]
    self.eventManager = eventManager
    self.event = nil
  }
  
  init(
    event: Event,
    eventManager: EventManager
  ) {
    self.mode = .edit
    
    self.title = event.ekevent.title
    self.date = event.ekevent.startDate
    self.endDate = event.ekevent.endDate
    self.isAllDay = event.ekevent.isAllDay
    self.memo = event.ekevent.notes ?? ""

    self.alram = .none
    if event.ekevent.hasAlarms == false {
      self.alram = .none
    } else {
      self.alram = AlramTime(rawValue: event.ekevent.alarms?[0].relativeOffset ?? -1) ?? AlramTime.onTime
    }
    
    self.isShowDatePicker = false
    self.isShowEndDatePicker = false
    self.isShowCategoriesPicker = false
    self.isShowAlramPicker = false
    self.isShowAlert = false
    self.alertDescription = ""
    self.categories = eventManager.getTaskCategories()
    self.category = event.category
    self.eventManager = eventManager
    
    self.event = event
  }
  
  enum Mode {
    case create
    case edit
    
    var title: String {
      switch self {
      case.create:
        return "새로운 일정 추가"
      case.edit:
        return "일정 수정"
      }
    }
  }
  
  enum Action {
    case tappedOutOfRange
    case tappedCloseButton
    case tappedCheckButton
    case changeMinimumEndDate
    case tappedDeleteButton
    case togglePicker(Pickers)
    case toggleIsAllDay
  }
  
  func action(_ action: Action) {
    switch action {
    case .tappedOutOfRange:
      tappedOutOfRange()
    case .tappedCloseButton:
      tappedCloseButton()
    case .tappedCheckButton:
      tappedCheckButton()
    case .changeMinimumEndDate:
      changeMinimumEndDate()
    case .tappedDeleteButton:
      tappedDeleteButton()
    case .togglePicker(let picker):
      togglePicker(selectedPicker: picker)
    case .toggleIsAllDay:
      toggleIsAllDay()
    }
  }
  
  var dateRange: ClosedRange<Date> {
    let max = Calendar.current.date(
      byAdding: .year,
      value: 10,
      to: date
    ) ?? Date()
    return date...max
  }
  
  enum Pickers {
    case datePicker
    case endDatePicker
    case categoriesPicker
    case alramPicker
  }
  
  func togglePicker(selectedPicker: Pickers) {
    var isShow: Bool
    
    switch selectedPicker {
    case .datePicker:
      isShow = isShowDatePicker
    case .endDatePicker:
      isShow = isShowEndDatePicker
    case .categoriesPicker:
      isShow = isShowCategoriesPicker
    case .alramPicker:
      isShow = isShowAlramPicker
    }
    
    if isShow == false {
      closeAllPickers()
    }
    
    switch selectedPicker {
    case .datePicker:
      isShowDatePicker.toggle()
    case .endDatePicker:
      isShowEndDatePicker.toggle()
    case .categoriesPicker:
      isShowCategoriesPicker.toggle()
    case .alramPicker:
      isShowAlramPicker.toggle()
    }
  }
  
  private func changeMinimumEndDate() {
    if endDate < date {
      endDate = date
    }
  }
  
  private func tappedCloseButton() {
    closeAllPickers()
    reset()
  }
  
  private func tappedCheckButton() {
    if mode == .create {
      createEvent()
    } else {
      editEvent()
    }
    closeAllPickers()
    reset()
  }
  
  private func toggleIsAllDay() {
    isAllDay.toggle()
    isShowDatePicker = false
    isShowEndDatePicker = false
  }
  
  private func tappedOutOfRange() {
    closeAllPickers()
  }
  
  private func tappedDeleteButton() {
    guard let ekevent = event?.ekevent else { return }
    
    switch eventManager.deleteTask(task: ekevent) {
    case .success(let success):
      alertDescription = success
    case .failure(let failure):
      alertDescription = failure.localizedDescription
    }
    isShowAlert.toggle()
    closeAllPickers()
    reset()
  }
  
  private func closeAllPickers() {
    isShowCategoriesPicker = false
    isShowDatePicker = false
    isShowEndDatePicker = false
    isShowAlramPicker = false
  }
  
  private func createEvent() {
    let newEvnet = EKEvent(eventStore: eventManager.store)
    newEvnet.title = title
    newEvnet.isAllDay = isAllDay
    newEvnet.startDate = date
    newEvnet.calendar = category
    newEvnet.notes = memo
    
    if isAllDay == false {
      newEvnet.endDate = endDate
    } else {
      newEvnet.endDate = date
    }
    
    if alram != .none {
      newEvnet.addAlarm(EKAlarm(relativeOffset: alram.second))
    }
    
    switch eventManager.createNewTask(newTask: newEvnet) {
    case .success(let success):
      alertDescription = success
    case .failure(let failure):
      alertDescription = failure.localizedDescription
    }

    isShowAlert.toggle()
    reset()
  }
  
  private func editEvent() {
    guard var event = event else { return }
    event.ekevent.title = title
    event.ekevent.isAllDay = isAllDay
    event.ekevent.startDate = date
    event.ekevent.calendar = category
    event.ekevent.notes = memo
    
    event.category = category
    
    if isAllDay == false {
      event.ekevent.endDate = endDate
    } else {
      event.ekevent.endDate = date + 86400
    }
    
    if alram != .none {
      event.ekevent.alarms = [EKAlarm(relativeOffset: alram.second)]
    }
    
    switch eventManager.editTask(task: event.ekevent) {
    case .success(let success):
      alertDescription = success
    case .failure(let failure):
      alertDescription = failure.localizedDescription
    }
    isShowAlert.toggle()
    
    reset()
  }
  
  private func reset() {
    title = ""
    isAllDay = false
    date = .now
    endDate = .now
    memo = ""
    category = categories[0]
  }
}
