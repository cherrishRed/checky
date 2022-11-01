//
//  MonthlyCellViewModel.swift
//  checky
//
//  Created by song on 2022/10/17.
//

import Foundation

class MonthlyCellViewModel: ObservableObject {
  @Published var dateValue: DateValue
  @Published var allEvnets: [Event] = []
  @Published var dueDateReminders: [Reminder] = []
  @Published var clearedReminders: [Reminder] = []
  
  init(
    dateValue: DateValue,
    allEvnets: [Event] = [],
    dueDateReminders: [Reminder] = [],
    clearedReminders: [Reminder] = []
  ) {
    self.dateValue = dateValue
    self.allEvnets = allEvnets
    self.dueDateReminders = dueDateReminders
    self.clearedReminders = clearedReminders
  }
}
