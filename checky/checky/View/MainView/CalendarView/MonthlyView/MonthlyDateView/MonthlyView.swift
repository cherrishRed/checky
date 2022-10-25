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
        
        ZStack {
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 70, height: 30)
            .foregroundColor(.gray)
          Button("Week") { viewModel.moveToWeek() }
            .foregroundColor(.white)
        }
      }
    
      VStack(spacing: 0) {
        
        DayOfWeekStackView(viewModel: DayOfWeekStackViewModel())
        
        MonthlyGrid
      }
      .background(Color("basicWhite"))
      .cornerRadius(20)
      .padding(.horizontal, 4)
      .padding(.vertical, 25)
    }
    .background(Color("backgroundGray"))
    .onChange(of: viewModel.dateHolder.date) { _ in
      viewModel.fetchEvents()
      viewModel.fetchReminder()
      }
    .onAppear {
      viewModel.getPermission()
      viewModel.fetchEvents()
      viewModel.fetchReminder()
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
            
            MonthlyCellView(viewModel: MonthlyCellViewModel(dateValue: value,
                                                            allEvnets: viewModel.filteredEvent(value.date),
                                                            allReminders:  viewModel.filteredReminder(value.date)))
      
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
            viewModel.dragGestureonEnded()
            withAnimation(.linear(duration: 0.4)) {
              viewModel.resetCurrentOffsetX()
            }
          }
      )
    }
    return body
  }
}