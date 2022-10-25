//
//  CustomTabBarView.swift
//  CustomTabView
//
//  Created by RED, Taeangel on 2022/10/10.
//

import SwiftUI

struct CustomTabBarView: View {
  
  let tabs: [TabBarItem]
  @Binding var selection: TabBarItem
  @Namespace private var namespace
  
  var body: some View {
    tabBarVersion
  }
}

extension CustomTabBarView {
  private func tabView(tab: TabBarItem) -> some View {
    VStack {
      Image(systemName: selection == tab ? tab.selectedName : tab.iconName)
        .padding(.horizontal, 30)
    }
    .foregroundColor(selection == tab ? tab.color : Color.gray)
    .padding(.vertical, 8)
  }
  
  private var tabBarVersion: some View {
    HStack {
      HStack {
        ForEach(tabs, id: \.self) { tab in
          HStack {
            tabView(tab: tab)
            Spacer()
          }
          .onTapGesture {
            switchTabBar(tab: tab)
          }
        }
      }
      
      Button {
        //
      } label: {
        Image(systemName: "plus.circle.fill")
          .resizable()
          .frame(width: 30, height: 30)
          .padding(.horizontal, 30)
          .foregroundColor(Color.fontMediumGray)
      }

    }
    .padding(6)
    .background(Color.white.ignoresSafeArea(edges: .bottom))
    .cornerRadius(10)
  }
  
  private func switchTabBar(tab: TabBarItem) {
    withAnimation(.easeInOut) {
      selection = tab
    }
  }
}
