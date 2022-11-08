//
//  ReminderView.swift
//  checky
//
//  Created by RED on 2022/11/08.
//

import SwiftUI
import EventKit

struct ReminderView: View {
  @ObservedObject var viewModel: ReminderViewModel
  let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 2)
  
  var body: some View {
    VStack {
      header
      eventView
      
      Button("toggle") {
        // toggle
      }
      .buttonStyle(ToggleButtonStyle())
      
      ScrollView {
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(viewModel.categories) { category in
            ReminderCategoryBlockView(category: category, reminderManager: viewModel.reminderManager)
          }
        }
      }

    }
    .background(Color.backgroundGray)
  }
}

extension ReminderView {
  var header: some View {
    ZStack {
      Rectangle()
        .fill(.white)
        .frame(height: 50)
      Text(Date().dateKoreanWithYear)
        .font(.title)
    }
  }
  
  var eventView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(.white)
      VStack {
        ForEach(viewModel.events, id: \.self) { event in
          ReminderViewEventBlockView(event: event)
            .frame(height: 30)
        }
      }
      .padding()
    }
    .padding()
    .fixedSize(horizontal: false, vertical: true)
  }
}
          
          
