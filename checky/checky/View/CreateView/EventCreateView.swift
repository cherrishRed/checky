//
//  EventCreateView.swift
//  checky
//
//  Created by RED on 2022/10/11.
//

import SwiftUI
import EventKit

struct EventCreateView: View {
  @ObservedObject var viewModel = EventCreateViewModel()
  
  var body: some View {
    VStack {
      headerView
      VStack {
        ScrollView(.vertical, showsIndicators: false) {
          titleView
          dayAndTimePicker
          categoryView
          memoView
        }
      }
      .padding(.horizontal, 10)
    }
    .onChange(of: viewModel.date) { newValue in
      viewModel.changeMinimumEndDate()
    }
    .onTapGesture {
      hideKeyboard()
      viewModel.closeAllPickers()
    }
  }
  
    var headerView: some View {
        HStack {
            Button {
              viewModel.reset()
              hideKeyboard()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .padding()
            }

            Text("새로운 이벤트 추가")
                .font(.title2)
                .frame(maxWidth: .infinity)
            
            Button {
              viewModel.createEvent()
              hideKeyboard()
            } label: {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                    .padding()
            }
        }
    }
    var titleView: some View {
      TextField("제목", text: $viewModel.title)
        .foregroundColor(Color("fontDarkBlack"))
        .font(.title3)
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color("backgroundGray"))
        .cornerRadius(4)
    }
    
    var dayAndTimePicker: some View {
      VStack {
        
        HStack(alignment: .center) {
          Image(systemName: "clock.fill")
            .foregroundColor(Color("fontMediumGray"))
          
          if viewModel.isAllDay {
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
            
          } else {
            HStack {
              
              Button {
                viewModel.toggleDatePicker()
                hideKeyboard()
              } label: {
                VStack {
                  Text(viewModel.date.dateKorean)
                    .foregroundColor(Color("fontDarkBlack"))
                  Text(viewModel.date.time)
                    .foregroundColor(Color("fontDarkBlack"))
                    .font(.title3)
                }
                .padding(4)
                .background(Color("backgroundGray"))
                .cornerRadius(4)
              }
              
              Text("~")
              
              Button {
                viewModel.toggleEndDatePicker()
                hideKeyboard()
              } label: {
                VStack {
                  Text(viewModel.endDate.dateKorean)
                    .foregroundColor(Color("fontDarkBlack"))
                  Text(viewModel.endDate.time)
                    .foregroundColor(Color("fontDarkBlack"))
                    .font(.title3)
                }
                .padding(4)
                .background(Color("backgroundGray"))
                .cornerRadius(4)
              }
              
            }
          }
          Button {
            viewModel.toggleIsAllDay()
            hideKeyboard()
          } label: {
            HStack {
              Image(systemName: viewModel.isAllDay ? "checkmark.square.fill" : "square")
              Text("하루종일")
            }
            .foregroundColor(Color("fontDarkBlack"))
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
  
  var memoView: some View {
    HStack(alignment: .top) {
      Image(systemName: "note.text")
        .foregroundColor(Color("fontMediumGray"))
      TextField("메모", text: $viewModel.memo, axis: .vertical)
        .foregroundColor(Color("fontDarkBlack"))
        .font(.title3)
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color("backgroundGray"))
        .cornerRadius(4)
    }
  }
    
}

struct EventCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreateView()
    }
}

