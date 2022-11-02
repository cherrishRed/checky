//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct EventButtonView: View {
  @ObservedObject var viewModel: EventButtonViewModel
  
  var body: some View {
    Text(viewModel.category.calendarIdentifier)
  }
}
