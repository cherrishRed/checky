//
//  ReminderMenuView.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import SwiftUI

struct ReminderMenuView: View {
  @ObservedObject var viewModel = ReminderMenuViewModel()
  var body: some View {
    ScrollView {
      VStack(spacing: 10) {
        titleView
        categoryView
        priorityView
        memoView
        dayPicker
        timePicker
      }
      .padding(.horizontal, 10)
    }
  }
  
  var titleView: some View {
    TextField("제목", text: $viewModel.title)
      .foregroundColor(Color("fontDarkBlack"))
      .font(.title3)
      .fontWeight(.bold)
      .padding(6)
      .frame(maxWidth: .infinity)
      .background(Color("backgroundGray"))
      .cornerRadius(4)
  }
  
  var categoryView: some View {
    VStack {
      HStack {
        Image(systemName: "tag.fill")
          .foregroundColor(Color("fontMediumGray"))
        Button {
          viewModel.toggleCategoriesPicker()
          hideKeyboard()
        } label: {
          HStack {
            Circle()
              .fill(Color(cgColor: viewModel.category.cgColor))
              .frame(width: 10, height: 10)
            Text(viewModel.category.title)
              .foregroundColor(Color("fontDarkBlack"))
              .font(.title3)
          }
          .padding(4)
          .frame(maxWidth: .infinity)
          .background(Color("backgroundGray"))
          .cornerRadius(4)
        }
      }
      
      if viewModel.isShowCategoriesPicker {
        Picker("", selection: $viewModel.category) {
          ForEach(viewModel.categories) { cate in
            HStack {
              Circle()
                .fill(Color(cgColor: cate.cgColor))
                .frame(width: 10, height: 10)
              Text(cate.title)
            }.tag(cate)
          }
        }
        .pickerStyle(WheelPickerStyle())
      }
    }
  }
  
  var priorityView: some View {
    VStack {
      HStack {
        Image(systemName: "sparkles")
          .foregroundColor(Color("fontMediumGray"))
          .padding(.trailing, 4)
        Picker("", selection: $viewModel.priority) {
          Text("없음").tag(0)
          Text("상").tag(1)
          Text("중").tag(2)
          Text("하").tag(3)
        }
        .pickerStyle(.segmented)
      }
      Text("우선순위 상을 체크하면 캘린더 화면에 나타납니다")
        .font(.subheadline)
    }
  }
  
  var memoView: some View {
    HStack(alignment: .top) {
      Image(systemName: "magazine.fill")
        .foregroundColor(Color("fontMediumGray"))
        .padding(.top, 10)
        .padding(.trailing, 4)
      TextField("메모", text: $viewModel.memo, axis: .vertical)
        .foregroundColor(Color("fontDarkBlack"))
        .font(.title3)
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color("backgroundGray"))
        .cornerRadius(4)
    }
  }
  
  var dayPicker: some View {
    VStack(alignment: .leading) {
      HStack() {
        Image(systemName: "calendar")
          .foregroundColor(Color("fontMediumGray"))
          .padding(.trailing, 2)
        if viewModel.isSetDate {
          Button {
            viewModel.toggleDatePicker()
            hideKeyboard()
          } label: {
            Text(viewModel.date.dateKoreanWithYear)
              .foregroundColor(Color("fontDarkBlack"))
              .font(.title3)
              .padding(6)
              .frame(maxWidth: .infinity)
              .background(Color("backgroundGray"))
              .cornerRadius(4)
          }
        }
        
        Button {
          viewModel.isSetDate.toggle()
          hideKeyboard()
        } label: {
          HStack {
            Image(systemName: viewModel.isSetDate ? "checkmark.square.fill" : "square")
          }
          .foregroundColor(Color("fontDarkBlack"))
        }
        
        if viewModel.isSetDate == false {
          Spacer()
        }
      }
      
      if viewModel.isShowDatePicker {
        DatePicker("", selection: $viewModel.date,
                   displayedComponents: [.date])
        .datePickerStyle(.wheel)
      }
    }
  }
  
  var timePicker: some View {
    VStack(alignment: .leading) {
      HStack() {
        Image(systemName: "clock.fill")
          .foregroundColor(Color("fontMediumGray"))
          .padding(.trailing, 3)
        if viewModel.isSetTime {
          Button {
            viewModel.toggleTimePicker()
            hideKeyboard()
          } label: {
            Text(viewModel.date.time)
              .foregroundColor(Color("fontDarkBlack"))
              .font(.title3)
              .padding(6)
              .frame(maxWidth: .infinity)
              .background(Color("backgroundGray"))
              .cornerRadius(4)
          }
        }
        
        Button {
          viewModel.isSetTime.toggle()
          hideKeyboard()
        } label: {
          HStack {
            Image(systemName: viewModel.isSetTime ? "checkmark.square.fill" : "square")
          }
          .foregroundColor(Color("fontDarkBlack"))
        }
        
        if viewModel.isSetTime == false {
          Spacer()
        }
      }
      
      if viewModel.isShowTimePicker {
        DatePicker("", selection: $viewModel.date,
                   displayedComponents: [.hourAndMinute])
        .datePickerStyle(.wheel)
      }
    }
  }
}