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
          .stroke(viewModel.color)
          .background(Color.basicWhite)
        
        HStack {
          
          Button {
            viewModel.action(.tappedCompletion)
          } label: {
            ZStack {
              Circle()
                .stroke(viewModel.color)
                .background(Color.basicWhite)
                .frame(width: 30)
              
              if viewModel.isCompletion {
                Circle()
                  .fill(viewModel.color)
                  .frame(width: 20)
              }
            }
            .padding(.vertical, 2)
          }
          .padding(.leading, 4)
          .alert(isPresented: $viewModel.isShowAlert) {
            getAlert(alertDescription: viewModel.alertDescription)
          }
          
          Button {
            coordinator.dismiss()
            coordinator.show(.editReminder(viewModel.reminder, viewModel.reminderManager))
          } label: {
            HStack {
              VStack(alignment: .leading) {
                Text(viewModel.reminder.ek.title)
                  .font(.headline)
                if viewModel.reminder.ek.hasNotes {
                  Text(viewModel.reminder.ek.notes ?? "")
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
  
  func getAlert(alertDescription: String) -> Alert {
    Alert(title: Text(alertDescription), dismissButton: .default(Text("확인")))
  }

}
