//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct ReminderButtonView: View {
  @ObservedObject var viewModel: ReminderButtonViewModel
 
    var body: some View {
      Text(viewModel.category.calendarIdentifier)
    }
}
