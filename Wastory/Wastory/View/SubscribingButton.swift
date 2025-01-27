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
    @State private var didAppear: Bool = false
    @State private var isSubscribed: Bool = false

    init(blogID: Int, blogAddress: String, @ViewBuilder subscribedContent: () -> Content, @ViewBuilder notSubscribedContent: () -> Content) {
        self.blogID = blogID
        self.blogAddress = blogAddress
        self.subscribedContent = subscribedContent()
        self.notSubscribedContent = notSubscribedContent()
    }

    var body: some View {
        Button(action: {
            if isSubscribed {
                Task{
                    do {
                        try await NetworkRepository.shared.deleteSubscription(blogAddress: blogAddress)
                        isSubscribed = false
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            } else {
                Task {
                    do {
                        try await NetworkRepository.shared.postSubscription(blogID: blogID)
                        isSubscribed = true
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
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
            if !didAppear {
                Task {
                    do {
                        isSubscribed = try await NetworkRepository.shared.getIsSubscribing(BlogID: blogID)
                        didAppear = true
                    } catch {
                        print("getissubbed")
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
