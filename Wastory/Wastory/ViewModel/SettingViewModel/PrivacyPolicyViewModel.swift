//
//  PrivacyPolicyViewModel.swift
//  Wastory
//
//  Created by mujigae on 2/1/25.
//

import SwiftUI
import Observation

@Observable final class PrivacyPolicyViewModel {
    var languageType: language = .kor
}

enum language: String {
    case kor
    case eng
}
