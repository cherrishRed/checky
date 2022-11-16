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
    VStack(spacing: 0) {
      Text("설정")
          .font(.title)
          .bold()
          .foregroundColor(Color.fontBlack)
          .frame(maxWidth: .infinity)
          .background(Color.basicWhite)
      
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
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.top, 20)
              .padding(.leading, 10)
          }
          
          Section {
            ForEach(viewModel.reminderCategories) { category in
              CategoriListCellView(category: category, mode: .reminder) {
                coordinator.show(.reminderSettingButton(category: category))
              }
            }
          } header: {
            Text("리마인더카테고리 설정")
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 10)
              .padding(.top, 10)
          }
          
          Text("카테고리의 색과 이모지를 설정하지 않으면 아이폰 기본 캘린더의 기본 색상으로 표시 됩니다. \n색과 이모지를 설정해 주세요😉")
            .padding()
            .font(.caption)
            .foregroundColor(.fontMediumGray)
            .lineLimit(10)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
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
}

