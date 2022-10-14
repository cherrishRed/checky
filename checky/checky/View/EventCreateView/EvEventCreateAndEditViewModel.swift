//
//  EventCreateAndEditViewModel.swift
//  checky
//
//  Created by RED on 2022/10/12.
//

import Foundation
import EventKit

class EventCreateAndEditViewModel: ObservableObject {
  let eventManager = EventManager()
  let categories: [EKCalendar]
  
  @Published var mode: Mode = .edit
  
  // 제목
  @Published var title: String = ""
  
  // 날짜
  @Published var date: Date = .now
  @Published var endDate: Date = .now
  @Published var isShowDatePicker: Bool = false
  @Published var isShowEndDatePicker: Bool = false
  @Published var isAllDay: Bool = false
  
  // 카테고리
  @Published var category: EKCalendar
  @Published var isShowCategoriesPicker: Bool = false
  
  // 메모
  @Published var memo: String = ""
  
  //
  @Published var alram: AlramTime = .none
  @Published var isShowAlramPicker: Bool = false
  
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
  
  init() {
    self.categories = eventManager.getEventCategories()
    self.category = categories[0]
  }
  
  var dateRange: ClosedRange<Date> {
    let max = Calendar.current.date(
         byAdding: .year,
         value: 10,
         to: date
       ) ?? Date()
    return date...max
  }
  
  func toggleDatePicker() {
    if isShowDatePicker == true {
      isShowDatePicker = false
    } else {
      closeAllPickers()
      isShowDatePicker = true
    }
  }
  
  func toggleEndDatePicker() {
    if isShowEndDatePicker == true {
      isShowEndDatePicker = false
    } else {
      closeAllPickers()
      isShowEndDatePicker = true
    }
  }
  
  func toggleCategoriesPicker() {
    if isShowCategoriesPicker == true {
      isShowCategoriesPicker = false
    } else {
      closeAllPickers()
      isShowCategoriesPicker = true
    }
  }
  
  func toggleAlramPicker() {
    if isShowAlramPicker == true {
      isShowAlramPicker = false
    } else {
      closeAllPickers()
      isShowAlramPicker = true
    }
  }
  
  func changeMinimumEndDate() {
    if endDate < date {
      endDate = date
    }
  }
  
  func tappedCloseButton() {
    closeAllPickers()
    reset()
  }
  
  func tappedCheckButton() {
    if mode == .create {
      createEvent()
    } else {
      // edit
    }
    closeAllPickers()
    reset()
  }
  
  func toggleIsAllDay() {
    isAllDay.toggle()
  }
  
  func tappedOutOfRange() {
    closeAllPickers()
  }
  
  func tappedDeleteButton() {
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
    
    eventManager.createNewEvent(newEvent: newEvnet)
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
