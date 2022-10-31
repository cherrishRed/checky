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
        
        if viewModel.reminder.ekreminder.startDateComponents?.minute != nil {
          VStack {
            Text("\(Calendar(identifier: .gregorian).date(from: viewModel.reminder.ekreminder.startDateComponents!)?.time ?? Date().time)")
              .font(.caption2)
          }
        }
        
        ZStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 6)
            .stroke(Color(viewModel.reminder.category.cgColor))
            .background(Color.basicWhite)
            
          HStack {
            ZStack {
              RoundedRectangle(cornerRadius: 4)
                .fill(Color(viewModel.reminder.category.cgColor))
                .frame(width: 40)
              
              Button {
                //
                viewModel.action(.tappedCompletion)
              } label: {
                ZStack {
                  Circle()
                    .fill(Color.basicWhite)
                    .frame(width: 30)
                  
                  if viewModel.isCompletion {
                    Circle()
                      .fill(Color(viewModel.reminder.category.cgColor))
                      .frame(width: 20)
                  }
                }
              }
            }
            
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
