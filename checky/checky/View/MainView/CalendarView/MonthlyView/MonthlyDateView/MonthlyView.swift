//
//  ContentView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

struct MonthlyView: View {
  @StateObject var viewModel: MonthlyViewModel
  
  var body: some View {
    VStack(spacing: 1) {
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
        
        MonthlyGrid
      }
      .background(Color.basicWhite)
      .cornerRadius(20)
      .padding(.horizontal, 4)
      .padding(.vertical, 25)
    }
    .background(Color.backgroundGray)
    .onChange(of: viewModel.dateHolder.date) { _ in
      viewModel.action(.onChangeDate)
      }
    .onAppear {
      viewModel.action(.actionOnAppear)
    }
  }
}

extension MonthlyView {
  var MonthlyGrid: some View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
    
    let columnsCount: CGFloat = viewModel.gridCloumnsCount
    
    var body: some View {
      GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(viewModel.allDatesForDisplay) { value in
            
            let events = viewModel.filteredEvent(value.date)
            let reminders = viewModel.filteredReminder(value.date)
            
            MonthlyCellView(viewModel: MonthlyCellViewModel(dateValue: value,
                                                            allEvnets: events,
                                                            allReminders: reminders))
      
            .frame(width: geo.size.width / 7, height: geo.size.height / columnsCount)
          }
        }
      }
      .frame(maxHeight: .infinity)
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
    return body
  }
}
