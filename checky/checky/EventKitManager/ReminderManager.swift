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
        $0.ekreminder.dueDateComponents?.month == calendar.dateComponents([.month], from: date).month && $0.ekreminder.dueDateComponents?.year == calendar.dateComponents([.year], from: date).year}
  }
  
  func filterHighPriorityTask(_ taget: [Reminder], _ date: Date) -> [Reminder] {
    taget
      .filter { $0.ekreminder.priority == 1 }
  }
  
  func filterClearTask(_ taget: [Reminder], _ date: Date) -> [Reminder] {
    taget
      .filter { $0.ekreminder.completionDate != nil }
      .filter { $0.ekreminder.completionDate?.day == date.day && $0.ekreminder.completionDate?.month == date.month && $0.ekreminder.completionDate?.year == date.year }
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
  
  func  getAllreminder(by category: EKCalendar, completionHandler: @escaping ([Reminder]) -> Void) {
    var list: [Reminder] = []
    
    let predicate: NSPredicate = store.predicateForReminders(in: [category])
    
    store.fetchReminders(matching: predicate) { reminders in
      for ekreminder in reminders ?? [] {
        let reminder = Reminder(ekreminder: ekreminder, category: category)
        list.append(reminder)
      }
      completionHandler(list)
    }
  }
  
  func createNewTask(newTask: EKCalendarItem) -> Result<String, ReminderManagerError> {
    guard let newTask = newTask as? EKReminder else { return .failure(.EKReminderTypeCastingError) }
    
    do {
      try store.save(newTask, commit: true)
      return .success("reminder 저장에 성공했어요!")
    } catch {
      return .failure(.createError)
    }
  }
  
  func getTaskCategories() -> [EKCalendar] {
    return store.calendars(for: .reminder)
  }
  
  func editReminder(_ reminder: EKReminder) -> Result<Bool, ReminderManagerError> {
    do {
      try store.save(reminder, commit: true)
      return .success(reminder.isCompleted)
    } catch {
      return .failure(.editError)
    }
  }
  
  func deleteTask(task: EKCalendarItem) -> Result<String, ReminderManagerError> {
    guard let task = task as? EKReminder else { return .failure(.EKReminderTypeCastingError)}
    do {
      try store.remove(task, commit: true)
      return .success("reminder 삭제 성공🥲")
    } catch {
      return .failure(.deleteError)
    }
  }
}



