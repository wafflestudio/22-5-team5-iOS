//
//  TermItem.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import Foundation

struct TermItem: Identifiable {
    var id: UUID = UUID()
    let type: TermType
    let term: String
    var details: String = ""
    var isAgreed: Bool = false
}

enum TermType: String {
    case none
    case required
    case optional
}
