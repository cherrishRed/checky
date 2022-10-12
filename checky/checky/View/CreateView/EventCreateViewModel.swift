//
//  EventCreateViewModel.swift
//  checky
//
//  Created by RED on 2022/10/12.
//

import Foundation
import EventKit

class EventCreateViewModel: ObservableObject {
  let eventManager = EventManager()
  let categories: [EKCalendar]
  
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
      isShowDatePicker = true
      isShowEndDatePicker = false
      isShowCategoriesPicker = false
    }
  }
  
  func toggleEndDatePicker() {
    if isShowEndDatePicker == true {
      isShowEndDatePicker = false
    } else {
      isShowEndDatePicker = true
      isShowDatePicker = false
      isShowCategoriesPicker = false
    }
  }
  
  func toggleCategoriesPicker() {
    if isShowCategoriesPicker == true {
      isShowCategoriesPicker = false
    } else {
      isShowCategoriesPicker = true
      isShowDatePicker = false
      isShowEndDatePicker = false
    }
  }
  
  func toggleIsAllDay() {
    isAllDay.toggle()
  }
  
  func createEvent() {
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
    
    eventManager.createNewEvent(newEvent: newEvnet)
    reset()
  }
  
  func reset() {
    title = ""
    isAllDay = false
    date = .now
    endDate = .now
    memo = ""
    category = categories[0]
  }
  
  func changeMinimumEndDate() {
    if endDate < date {
      endDate = date
    }
  }
}
