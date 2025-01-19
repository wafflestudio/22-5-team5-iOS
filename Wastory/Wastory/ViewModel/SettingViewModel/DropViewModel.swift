//
//  DropViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/19/25.
//

import SwiftUI
import Observation

@Observable final class DropViewModel {
    var isDropAgreed: Bool = false

    func toggleDropAgreed() {
        isDropAgreed.toggle()
    }
}
