//
//  Subscription.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct SubscriptionDto: Codable {
    let isSubscribing: Bool
    
    private enum CodingKeys: String, CodingKey {
        case isSubscribing = "is_subscribing"
    }
}
