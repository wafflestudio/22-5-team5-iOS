//
//  PostingView.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct PostingView: View {
    
    @Bindable var mainTabViewModel: MainTabViewModel
    
    var body: some View {
        Button(action: {
            mainTabViewModel.toggleIsPostingViewPresent()
        }) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear() {print("Asdf")}
    }
}

