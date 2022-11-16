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
  let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: .top), count: 2)
  
  var body: some View {
    VStack {
      header
          GeometryReader { geo in
        ScrollView {
          LazyHStack(alignment: .top, spacing: 10) {
            LazyVStack {
              ForEach(viewModel.categoriesFirstLine, id: \.self) { category in
                ReminderCategoryBlockView(category: category, reminderManager: viewModel.reminderManager)
              }
            }
            
            .frame(width: (geo.size.width/2)-15)
            
            LazyVStack {
              ForEach(viewModel.categoriesSecondLine, id: \.self) { category in
                ReminderCategoryBlockView(category: category, reminderManager: viewModel.reminderManager)
              }
            }
            
            .frame(width: (geo.size.width/2)-15)
          }
          .padding(.horizontal, 10)
        }
      }
    }
    .background(Color.backgroundGray)
  }
}

extension ReminderView {
  var header: some View {
    Text(Date().dateKoreanWithYear)
        .font(.title)
        .bold()
        .foregroundColor(Color.fontBlack)
        .frame(maxWidth: .infinity)
        .background(Color.basicWhite)
  }
}
          
          
