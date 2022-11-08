//
//  SettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct SettingListView: View {
  @ObservedObject var viewModel: SettingViewModel
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        Section {
          ForEach(viewModel.eventCategories) { category in
            CategoriListCellView(category: category, mode: .calendar) {
              coordinator.show(.eventSettingButton(category: category))
            }
          }
        } header: {
          Text("이벤트카테고리 설정")
            .frame(alignment: .leading)
        }
        
        Section {
          ForEach(viewModel.reminderCategories) { category in
            CategoriListCellView(category: category, mode: .reminder) {
              coordinator.show(.reminderSettingButton(category: category))
            }
          }
        } header: {
          Text("리마인더카테고리 설정")
            .frame(alignment: .leading)
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 10)
    }
    .onAppear{
      coordinator.navigationController.navigationBar.isHidden = true
    }
    .background(Color.backgroundGray)
  }
}

