//
//  Policy.swift
//  Wastory
//
//  Created by mujigae on 2/1/25.
//

import Foundation

struct ServicePolicy: Identifiable {
    let id: UUID = UUID()
    let title: String
    let terms: [String]
}
