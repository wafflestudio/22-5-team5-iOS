//
//  SubscribingButton.swift
//  Wastory
//
//  Created by 중워니 on 1/27/25.
//

import SwiftUI

struct SubscribingButton<Content: View>: View {
    let blogID: Int
    let blogAddress: String
    let subscribedContent: Content
    let notSubscribedContent: Content
    @State var isSubscribed: Bool = false

    init(blogID: Int, blogAddress: String, @ViewBuilder subscribedContent: () -> Content, @ViewBuilder notSubscribedContent: () -> Content) {
        self.blogID = blogID
        self.blogAddress = blogAddress
        self.subscribedContent = subscribedContent()
        self.notSubscribedContent = notSubscribedContent()
    }

    var body: some View {
        Button(action: {
            if isSubscribed {
                Task {
                    try await NetworkRepository.shared.deleteSubscription(blogAddress: blogAddress)
                    isSubscribed.toggle()
                }
            } else {
                Task {
                    try await NetworkRepository.shared.postSubscription(blogID: blogID)
                    isSubscribed.toggle()
                }
            }
        }) {
            if isSubscribed {
                subscribedContent
            } else {
                notSubscribedContent
            }
        }
        .onAppear {
            Task {
                isSubscribed = try await NetworkRepository.shared.getIsSubscribing(BlogID: blogID)
            }
        }
    }
}
