//
//  ReminderManager.swift
//  checky
//
//  Created by song on 2022/10/27.
//

import Foundation
import EventKit

struct ReminderManager: ManagerProtocol {
  var store: EKEventStore
  var calendar: Calendar
  
  typealias task = Reminder
  typealias EKTask = EKReminder
  
  init(store: EKEventStore = EKEventStore(),
       calendar: Calendar = Calendar(identifier: .gregorian)) {
    self.store = store
    self.calendar = calendar
  }
  
  func getPermission() {
    store.requestAccess(to: .reminder) { granted, error in
      guard error == nil else {
        print("에러가 있습니다")
        return
      }
      
      guard granted == true else {
        print("권한이 이상합니다")
        return
      }
    }
  }
  
  func filterTask(_ taget: [Reminder], _ date: Date) -> [Reminder] {
    taget
      .filter {
        $0.ekreminder.dueDateComponents?.day == calendar.dateComponents([.day], from: date).day &&
        $0.ekreminder.dueDateComponents?.month == calendar.dateComponents([.month], from: date).month }
  }
  
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([Reminder]) -> Void) {
    let categories = store.calendars(for: .reminder)
    
    var list: [Reminder] = []
    
    for category in categories {
      let predicate: NSPredicate = store.predicateForReminders(in: [category])
      
      store.fetchReminders(matching: predicate) { reminders in
        for ekreminder in reminders ?? [] {
          let reminder = Reminder(ekreminder: ekreminder, category: category)
          list.append(reminder)
        }
        completionHandler(list)
      }
    }
  }

  func createNewTask(newTask: EKCalendarItem) {
    guard let newTask = newTask as? EKReminder else { return }
    
    do {
      try store.save(newTask, commit: true)
    } catch {
      print("reminder 저장 실패🥲")
      print(error.localizedDescription)
    }
  }
  
  func getTaskCategories() -> [EKCalendar] {
    return store.calendars(for: .reminder)
  }
}


extension EKCalendar: Identifiable {}