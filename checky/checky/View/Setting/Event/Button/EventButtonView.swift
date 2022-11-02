//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct EventButtonView: View {
  @ObservedObject var viewModel: EventButtonViewModel
  @State var Imoji: String?
  
  var body: some View {
    HStack {
      Text("이모지")
      Spacer()
      Text(viewModel.imoji ?? "🐲")
    }
    .onAppear {
      viewModel.imoji = UserDefaults.standard.string(forKey: viewModel.category.calendarIdentifier)
    }
  }
}

//struct ContentView: View {
//
//  @State var currentUserName: String?
//
//  var body: some View {
//    VStack(spacing: 20) {
//      Text(currentUserName ?? "Add Name Here")
//
//      if let name = currentUserName {
//        Text(name)
//      }
//
//      Button("Save".uppercased()) {
//        let name = "Song"
//        currentUserName = name
//        UserDefaults.standard.set(name, forKey: viewModel.category.calendarIdentifier)
//      }
//    }
//    .onAppear {
//      currentUserName = UserDefaults.standard.string(forKey: viewModel.category.calendarIdentifier)
//    }
//  }
//}
