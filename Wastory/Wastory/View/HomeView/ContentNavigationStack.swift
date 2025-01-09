//
//  ContentNavigationStack.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI

struct ContentNavigationStack: View {
    @Environment(\.contentViewModel) var contentViewModel
    @State var contentNavigationPath = NavigationPath()
    
    var body: some View {
        if !contentViewModel.isMainTabViewPresented {
            NavigationStack(path: $contentNavigationPath) {
                if contentViewModel.isBlogViewPresented {
                    BlogView()
                } else if contentViewModel.isPostViewPresented {
                    //                NavigationStack {
                    //                    PostView()
                    //                }
                }
            }
            .transition(.move(edge: .trailing))
            .zIndex(1)
        }
    }
}
