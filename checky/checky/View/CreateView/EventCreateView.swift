//
//  EventCreateView.swift
//  checky
//
//  Created by RED on 2022/10/11.
//

import SwiftUI
import EventKit

struct EventCreateView: View {
  @State var date: Date = .now
  @State var endDate: Date = .now
  @State var showDatePicker: Bool = false
  @State var showEndDatePicker: Bool = false
  @State var isAllDay: Bool = false
  
  @State var category: EKCalendar
  let categories: [EKCalendar]
  @State var showCategoriesPicker: Bool = false
  
  var eventManager = EventManager()
  
  init() {
    self.categories = eventManager.getEventCategories()
    self._category = State(wrappedValue: categories[0])
  }
    
    var body: some View {
        VStack {
            headerView
            dayAndTimePicker
          categoryView
        }
    }
    
    var headerView: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .padding()
            }

            Text("새로운 이벤트 추가")
                .font(.title2)
                .frame(maxWidth: .infinity)
            
            Button {
                
            } label: {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                    .padding()
            }
        }
    }
    
    var dayAndTimePicker: some View {
      VStack {
        
        HStack(alignment: .center) {
          Image(systemName: "clock.fill")
            .foregroundColor(Color("fontMediumGray"))
          
          if isAllDay {
            Button {
              showDatePicker.toggle()
            } label: {
              Text(date.dateKoreanWithYear)
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
                showDatePicker.toggle()
              } label: {
                VStack {
                  Text(date.dateKorean)
                    .foregroundColor(Color("fontDarkBlack"))
                  Text(date.time)
                    .foregroundColor(Color("fontDarkBlack"))
                    .font(.title3)
                }
                .padding(4)
                .background(Color("backgroundGray"))
                .cornerRadius(4)
              }
              
              Text("~")
              
              Button {
                showEndDatePicker.toggle()
              } label: {
                VStack {
                  Text(endDate.dateKorean)
                    .foregroundColor(Color("fontDarkBlack"))
                  Text(date.time)
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
            isAllDay.toggle()
          } label: {
            HStack {
              Image(systemName: isAllDay ? "checkmark.square.fill" : "square")
              Text("하루종일")
            }
            .foregroundColor(Color("fontDarkBlack"))
          }
        }
        
        if showDatePicker {
          
          DatePicker("", selection: $date,
                     displayedComponents: isAllDay ? [.date] : [.date, .hourAndMinute])
            .datePickerStyle(.wheel)
        }
        if showEndDatePicker {
          DatePicker("", selection: $endDate)
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
          showCategoriesPicker.toggle()
        } label: {
          HStack {
            Circle()
              .fill(Color(cgColor: category.cgColor))
              .frame(width: 10, height: 10)
            Text(category.title)
              .foregroundColor(Color("fontDarkBlack"))
              .font(.title3)
          }
          .padding(4)
          .frame(maxWidth: .infinity)
          .background(Color("backgroundGray"))
          .cornerRadius(4)
        }
      }
      
      if showCategoriesPicker {
        Picker("", selection: $category) {
          ForEach(categories) { cate in
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
    
}

struct EventCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EventCreateView()
    }
}
