//
//  ManagerProtocol.swift
//  checky
//
//  Created by song on 2022/10/27.
//

import Foundation
import EventKit

protocol ManagerProtocol {
  var store: EKEventStore { get set }
  var calendar: Calendar { get set }
  
  associatedtype Task: CheckyEventkitRepositoryProtocol
  associatedtype ManagerError: Error
  
  func getPermission()
  func filterTask(_ target: [Task], _ date: Date) -> [Task]
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([Task]) -> Void)
  func createNewTask(newTask: EKCalendarItem) -> Result<String, ManagerError>
  func getTaskCategories() -> [EKCalendar]
  func editTask(task: EKCalendarItem) -> Result<Bool, ManagerError>
  func deleteTask(task: EKCalendarItem) -> Result<String, ManagerError>
}

protocol CheckyEventkitRepositoryProtocol {}

extension Reminder: CheckyEventkitRepositoryProtocol {}

extension Event: CheckyEventkitRepositoryProtocol {}
