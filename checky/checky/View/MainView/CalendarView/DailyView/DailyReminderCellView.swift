//
//  DailyReminderCell.swift
//  checky
//
//  Created by RED on 2022/10/31.
//

import SwiftUI
import EventKit

struct DailyReminderCellView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @ObservedObject var viewModel: DailyReminderCellViewModel
  
  var body: some View {

    HStack(spacing: 4) {
      
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 6)
          .stroke(Color(viewModel.reminder.category.cgColor))
          .background(Color.basicWhite)
        
        HStack {
          
          Button {
            //
            viewModel.action(.tappedCompletion)
          } label: {
            ZStack {
              Circle()
                .stroke(Color(viewModel.reminder.category.cgColor))
                .background(Color.basicWhite)
                .frame(width: 30)
              
              if viewModel.isCompletion {
                Circle()
                  .fill(Color(viewModel.reminder.category.cgColor))
                  .frame(width: 20)
              }
            }
          }
          .padding(.leading, 4)
          
          Button {
            //
            coordinator.dismiss()
            coordinator.show(.editReminder(viewModel.reminder, viewModel.reminderManager))
          } label: {
            HStack {
              VStack(alignment: .leading) {
                Text(viewModel.reminder.ekreminder.title)
                  .font(.headline)
                if viewModel.reminder.ekreminder.hasNotes {
                  Text(viewModel.reminder.ekreminder.notes ?? "")
                    .font(.footnote)
                    .padding(.leading, 2)
                    .multilineTextAlignment(.leading)
                }
              }
              .padding(.horizontal, 4)
              .padding(.vertical, 6)
              Spacer()
            }
          }
        }
      }
      .fixedSize(horizontal: false, vertical: true)
    }
  }
}
