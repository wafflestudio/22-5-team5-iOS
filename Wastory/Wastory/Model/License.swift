//
//  License.swift
//  Wastory
//
//  Created by mujigae on 1/19/25.
//

import Foundation

struct OSS: Identifiable {
    var id: UUID = UUID()
    let ossName: String
    let ossURL: URL
    let ossDescription: String
    let ossLicense: License
}

struct License: Identifiable {
    var id: UUID = UUID()
    let licenseName: String
    let licenseDescription: String
}
