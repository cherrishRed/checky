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
        return
      }
      
      guard granted == true else {
        return
      }
    }
  }
  
  func filterTask(_ target: [CheckyEventkitRepositoryProtocol], _ date: Date) -> [CheckyEventkitRepositoryProtocol] {
    target
      .filter {
        $0.ek.dueDateComponents?.day == calendar.dateComponents([.day], from: date).day &&
        $0.ek.dueDateComponents?.month == calendar.dateComponents([.month], from: date).month && $0.ek.dueDateComponents?.year == calendar.dateComponents([.year], from: date).year
      }
  }
  
  func filterHighPriorityTask(_ target: [Reminder], _ date: Date) -> [Reminder] {
    target
      .filter { $0.ek.priority == 1 }
  }
  
  func filterClearTask(_ target: [Reminder], _ date: Date) -> [Reminder] {
    target
      .filter { $0.ek.completionDate != nil }
      .filter { $0.ek.completionDate?.day == date.day && $0.ek.completionDate?.month == date.month && $0.ek.completionDate?.year == date.year }
  }
  
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([CheckyEventkitRepositoryProtocol]) -> Void) {
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
        let reminder = Reminder(ek: ekreminder, category: category)
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
  
  func editTask(task: EKCalendarItem) -> Result<Bool, ReminderManagerError> {
    guard let task = task as? EKReminder else { return .failure(.EKReminderTypeCastingError) }
    do {
      try store.save(task, commit: true)
      return .success(task.isCompleted)
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



