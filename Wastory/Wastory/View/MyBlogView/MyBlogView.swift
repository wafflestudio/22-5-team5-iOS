//
//  MyBlogView.swift
//  Wastory
//
//  Created by 중워니 on 1/17/25.
//

import SwiftUI

struct MyBlogView: View {
    var body: some View {
        NavigationLink(destination: MyCategoryView()) {
            Text("카테고리 관리")
        }
    }
}

#Preview {
    MyBlogView()
}
