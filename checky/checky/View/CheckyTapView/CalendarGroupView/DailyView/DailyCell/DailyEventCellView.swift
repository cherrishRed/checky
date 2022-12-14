//
//  DailyEventCellView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct DailyEventCellView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @ObservedObject var viewModel: DailyEventCellViewModel
  
    var body: some View {
      Button {
        coordinator.dismiss()
        coordinator.show(.editEvent(viewModel.event, viewModel.eventManager))
      } label: {
        HStack(spacing: 4) {
          
          if viewModel.isAllday == false {
            VStack {
              Text("\(viewModel.event.ekevent.startDate.time)")
                .font(.caption2)
              Spacer()
              Text("\(viewModel.event.ekevent.endDate.time)")
                .font(.caption2)
            }
          }
          
          ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 6)
              .stroke(viewModel.color)
              .background(Color.basicWhite)
              
            HStack {
              ZStack {
                RoundedRectangle(cornerRadius: 4)
                  .fill(viewModel.color)
                  .frame(width: 40)
                Circle()
                  .fill(Color.basicWhite)
                  .frame(width: 30)
                Text(viewModel.icon)
              }
              
              VStack(alignment: .leading) {
                Text(viewModel.event.ekevent.title)
                  .font(.headline)
                if viewModel.event.ekevent.hasNotes {
                  Text(viewModel.event.ekevent.notes ?? "")
                    .font(.footnote)
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
}
