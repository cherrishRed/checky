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
  let closedModalNotification = NotificationCenter.default.publisher(for: .closedModal)
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(viewModel: HeaderViewModel(dateHolder: viewModel.dateHolder, calendarHelper: viewModel.calendarHelper))
      
      HStack {
        Spacer()
        if viewModel.currentMonth == false {
          Button("Today") {
            viewModel.dateHolder.date = Date()
          }
          .buttonStyle(ToggleButtonStyle())
          .padding(.top, 10)
        }
        
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
      })
      .onReceive(closedModalNotification, perform: { output in
        viewModel.fetchEvents()
      })
      
    }
    .background(Color.backgroundGray)
    .gesture(
      DragGesture()
        .onChanged { value in
          viewModel.currentOffsetX = value.translation
        }
        .onEnded { value in
          viewModel.action(.dragGestur)
          withAnimation(.linear(duration: 0.4)) {
            viewModel.action(.resetCurrentOffsetX)
          }
        }
    )
  }
}
