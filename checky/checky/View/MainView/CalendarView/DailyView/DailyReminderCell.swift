//
//  DailyReminderCell.swift
//  checky
//
//  Created by RED on 2022/10/31.
//

import SwiftUI
import EventKit

struct DailyReminderCell: View {
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
          
          VStack(alignment: .leading) {
            Text(viewModel.reminder.ekreminder.title)
              .font(.title3)
              .fontWeight(.semibold)
            if viewModel.reminder.ekreminder.notes != "" {
              Text(viewModel.reminder.ekreminder.notes ?? "")
                .padding(.leading, 2)
            }
          }
          .padding(.horizontal, 4)
          .padding(.vertical, 6)
        }
      }
      .fixedSize(horizontal: false, vertical: true)
    }
  }
}
