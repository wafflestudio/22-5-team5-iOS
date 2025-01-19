//
//  License.swift
//  Wastory
//
//  Created by mujigae on 1/19/25.
//

import Foundation

struct License: Identifiable {
    var id: UUID = UUID()
    let licenseName: String
    let licenseDescription: String
}
