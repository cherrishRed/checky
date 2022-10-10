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
      Image(systemName: tab.iconName)
        .font(.subheadline)
    }
    .foregroundColor(selection == tab ? tab.color : Color.gray)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(
      ZStack {
        if selection == tab {
          RoundedRectangle(cornerRadius: 10)
            .fill(tab.color.opacity(0.2))
            .matchedGeometryEffect(id: "background_rectangle", in: namespace)
        }
      }
    )
    .cornerRadius(10)
  }
  
  private var tabBarVersion: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        tabView(tab: tab)
          .onTapGesture {
            switchTabBar(tab: tab)
          }
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
