//
//  CustomTabBarContainerView.swift
//  CustomTabView
//
//  Created by RED, Taeangel on 2022/10/10.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
  
  @Binding var selection: TabBarItem
  let content: Content
  @State private var tabs: [TabBarItem] = []
  
  init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
    self._selection = selection
    self.content = content()
  }
    var body: some View {
       
      VStack {
        ZStack {
          content
        }
        CustomTabBarView(tabs: tabs, selection: $selection)
      }
      .onPreferenceChange(TabBarItemsPreferenceKey.self ,perform: { value in
        self.tabs = value
      })
    }
}
