//
//  ContentView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

struct MonthlyView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @StateObject var viewModel: MonthlyViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(viewModel: HeaderViewModel(dateHolder: viewModel.dateHolder, calendarHelper: viewModel.calendarHelper))
      
      HStack {
        Spacer()
        Button("Weekly") { viewModel.action(.moveToWeekly) }
          .buttonStyle(ToggleButtonStyle())
          .padding(.top, 10)
          .padding(.horizontal, 10)
      }
      
      VStack(spacing: 0) {
        DayOfWeekStackView(viewModel: DayOfWeekStackViewModel())
        GeometryReader { geo in
          let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
          let columnsCount: CGFloat = viewModel.gridCloumnsCount
          
          LazyVGrid(columns: columns, spacing: 0) {
            ForEach(viewModel.allDatesForDisplay) { value in
              
              let events = viewModel.filteredEvent(value.date)
              let reminders = viewModel.filteredReminder(value.date)
              let clearedReminders = viewModel.filteredClearedReminder(value.date)
              
              MonthlyCellView(viewModel: MonthlyCellViewModel(dateValue: value,
                                                              allEvnets: events,
                                                              dueDateReminders: reminders,
                                                              clearedReminders: clearedReminders,
                                                              eventManager: viewModel.eventManager,
                                                              reminderManager: viewModel.reminderManager))
              .onTapGesture {
                coordinator.show(.daily(value.date, events, reminders, clearedReminders, viewModel.eventManager, viewModel.reminderManager))
                print("tabbed!!!chell")
              }
              .frame(width: geo.size.width / 7, height: geo.size.height / columnsCount, alignment: .top)
              .clipped()
            }
          }
        }
        .frame(maxHeight: .infinity)
        .onAppear {
          viewModel.action(.actionOnAppear)
      }
      }
      .background(Color.basicWhite)
      .cornerRadius(10)
      .padding(.vertical)
      .padding(.horizontal, 4)
      .onReceive(viewModel.dateHolder.$date, perform: { output in
        viewModel.fetchEvents()
        viewModel.fetchEvents()
      })
      
      HStack(spacing: 10) {
        Button {
          viewModel.moveToPreviousMonth()
        } label: {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.basicWhite)
            Image(systemName: "arrow.left")
              .foregroundColor(Color.fontBlack)
          }
        }
        
        Button {
          viewModel.moveToNextMonth()
        } label: {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.basicWhite)
            Image(systemName: "arrow.right")
              .foregroundColor(Color.fontBlack)
          }
        }
      }
      .frame(height: 20)
      .padding(.horizontal, 4)
      .padding(.bottom, 10)
    }
    .background(Color.backgroundGray)
  }
}
