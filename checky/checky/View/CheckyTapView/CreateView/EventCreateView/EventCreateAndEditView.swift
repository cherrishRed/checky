//
//  EventCreateAndEditView.swift
//  checky
//
//  Created by RED on 2022/10/11.
//

import SwiftUI
import EventKit

struct EventCreateAndEditView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @ObservedObject var viewModel: EventCreateAndEditViewModel
  
  init(viewModel: EventCreateAndEditViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      headerView
      bodyView
      
      if viewModel.mode == .edit {
        deleteButtonView
      }
    }
    .onTapGesture {
      hideKeyboard()
      viewModel.action(.tappedOutOfRange)
    }
    .alert(isPresented: $viewModel.isShowAlert) {
      getAlert(alertDescription: viewModel.alertDescription) {
        coordinator.dismiss()
      }
    }
  }
  
  var headerView: some View {
    HStack {
      Button {
        viewModel.action(.tappedCloseButton)
        hideKeyboard()
        coordinator.dismiss()
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(.red)
          .padding()
      }
      
      Text(viewModel.mode.title)
        .font(.title2)
        .frame(maxWidth: .infinity)
      
      Button {
        viewModel.action(.tappedCheckButton)
        hideKeyboard()
      } label: {
        Image(systemName: "checkmark")
          .foregroundColor(.green)
          .padding()
      }
    }
  }
  
  var bodyView: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 10) {
        titleView
        dayAndTimePicker
        categoryView
        alramView
        memoView
      }
    }
    .padding(.horizontal, 10)
    .onChange(of: viewModel.date) { newValue in
      viewModel.action(.changeMinimumEndDate)
    }
  }
  
  var deleteButtonView: some View {
    Button {
      viewModel.action(.tappedDeleteButton)
    } label: {
      HStack {
        Image(systemName: "trash.fill")
        Text("이벤트 삭제")
          .fontWeight(.heavy)
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.pointRed)
      .cornerRadius(4)
      .foregroundColor(Color.basicWhite)
    }
    .padding(.horizontal)
    .alert(isPresented: $viewModel.isShowAlert) {
      getAlert(alertDescription: viewModel.alertDescription) {
        coordinator.dismiss()
      }
    }
  }
  
  //MARK: BodyView 안의 세부 View 들
  var titleView: some View {
    TextField("제목", text: $viewModel.title)
      .foregroundColor(Color.fontBlack)
      .font(.title3.weight(.bold))
      .padding(6)
      .frame(maxWidth: .infinity)
      .background(Color.backgroundGray)
      .cornerRadius(4)
  }
  
  var dayAndTimePicker: some View {
    VStack {
      HStack(alignment: .center) {
        Image(systemName: "clock.fill")
          .foregroundColor(Color.fontMediumGray)
          .padding(.trailing, 3)
        if viewModel.isAllDay {
          Button {
            viewModel.togglePicker(selectedPicker: .datePicker)
            hideKeyboard()
          } label: {
            Text(viewModel.date.dateKoreanWithYear)
              .foregroundColor(Color.fontDarkBlack)
              .font(.title3)
              .padding(6)
              .frame(maxWidth: .infinity)
              .background(Color.backgroundGray)
              .cornerRadius(4)
          }
          
        } else {
          HStack {
            Button {
              viewModel.togglePicker(selectedPicker: .datePicker)
              hideKeyboard()
            } label: {
              VStack {
                Text(viewModel.date.dateKorean)
                  .foregroundColor(Color.fontBlack)
                Text(viewModel.date.time)
                  .foregroundColor(Color.fontBlack)
                  .font(.title3)
              }
              .padding(4)
              .background(Color.backgroundGray)
              .cornerRadius(4)
            }
            
            Text("~")
            
            Button {
              viewModel.togglePicker(selectedPicker: .endDatePicker)
              hideKeyboard()
            } label: {
              VStack {
                Text(viewModel.endDate.dateKorean)
                  .foregroundColor(Color.fontBlack)
                Text(viewModel.endDate.time)
                  .foregroundColor(Color.fontBlack)
                  .font(.title3)
              }
              .padding(4)
              .background(Color.backgroundGray)
              .cornerRadius(4)
            }
            
          }
        }
        Button {
          viewModel.action(.toggleIsAllDay)
          hideKeyboard()
        } label: {
          HStack {
            Image(systemName: viewModel.isAllDay ? "checkmark.square.fill" : "square")
            Text("하루종일")
          }
          .foregroundColor(Color.fontBlack)
        }
      }
      
      if viewModel.isShowDatePicker {
        DatePicker("", selection: $viewModel.date,
                   displayedComponents: viewModel.isAllDay ? [.date] : [.date, .hourAndMinute])
        .datePickerStyle(.wheel)
      }
      if viewModel.isShowEndDatePicker {
        DatePicker("", selection: $viewModel.endDate, in: viewModel.dateRange)
          .datePickerStyle(.wheel)
      }
    }
  }
  
  var categoryView: some View {
    VStack {
      HStack {
        Image(systemName: "tag.fill")
          .foregroundColor(Color.fontMediumGray)
        Button {
          viewModel.togglePicker(selectedPicker: .categoriesPicker)
          hideKeyboard()
        } label: {
          HStack {
            Circle()
              .fill(fetchUserDefaultColor(calendarIdentifier: viewModel.category?.calendarIdentifier ?? "none"))
              .frame(width: 10, height: 10)
            Text(viewModel.category?.title ?? "카테고리 없음")
              .foregroundColor(Color.fontBlack)
              .font(.title3)
          }
          .padding(4)
          .frame(maxWidth: .infinity)
          .background(Color.backgroundGray)
          .cornerRadius(4)
        }
      }
      
      if viewModel.isShowCategoriesPicker {
        Picker("", selection: $viewModel.category) {
          ForEach(viewModel.categories) { cate in
            HStack {
              Circle()
                .fill(fetchUserDefaultColor(calendarIdentifier: cate.calendarIdentifier))
                .frame(width: 10, height: 10)
              Text(cate.title)
            }.tag(cate)
          }
        }
        .pickerStyle(WheelPickerStyle())
      }
    }
  }
  
  var alramView: some View {
    VStack {
      HStack() {
        Image(systemName: "alarm.fill")
          .foregroundColor(Color.fontMediumGray)
          .padding(.trailing, 4)
        Button {
          viewModel.togglePicker(selectedPicker: .alramPicker)
          hideKeyboard()
        } label: {
          Text(viewModel.alram.korean)
            .foregroundColor(Color.fontBlack)
            .font(.title3)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(Color.backgroundGray)
            .cornerRadius(4)
        }
      }
      if viewModel.isShowAlramPicker {
        Picker("", selection: $viewModel.alram) {
          ForEach(AlramTime.allCases, id: \.self) { alram in
            Text(alram.korean).tag(alram)
          }
        }
        .pickerStyle(WheelPickerStyle())
      }
    }
  }
  
  var memoView: some View {
    HStack(alignment: .top) {
      Image(systemName: "note.text")
        .foregroundColor(Color.fontMediumGray)
        .padding(.top, 10)
        .padding(.trailing, 2)
      TextField("메모", text: $viewModel.memo)
        .foregroundColor(Color.fontBlack)
        .font(.title3)
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color.backgroundGray)
        .cornerRadius(4)
    }
  }
  
  func getAlert(alertDescription: String, ButtonAction: @escaping () -> ()) -> Alert {
    Alert(title: Text(alertDescription), dismissButton: .default(Text("확인"), action: {
      ButtonAction()
    }))
  }
}

