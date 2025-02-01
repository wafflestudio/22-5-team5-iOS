//
//  VersionViewModel.swift
//  Wastory
//
//  Created by mujigae on 2/1/25.
//

import SwiftUI
import Observation

@Observable final class VersionViewModel {
    var currentVersion: String = "1.0.0"
    var recentVersion: String = "1.0.0"
    
    func getAppVersion() {
        // TODO: 앱 정보를 관리하는 싱글톤이 필요하지만 프로젝트를 마무리하면서 구현하지 않게 될 예정
    }
}
