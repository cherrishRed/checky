//
//  DateScrollerView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import SwiftUI

struct HeaderView: View {
    @StateObject var viewModel: HeaderViewModel
    
    var body: some View {
        Text(viewModel.displayMonth)
            .font(.title)
            .bold()
            .foregroundColor(Color.fontBlack)
            .animation(.none)
            .frame(maxWidth: .infinity)
            .background(Color.basicWhite)
    }
}
