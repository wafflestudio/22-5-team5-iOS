//
//  ContentViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI
import Observation

@Observable final class ContentViewModel {
    
    var isMainTabViewPresented: Bool = true
    
    var isBlogViewPresented: Bool = false
    
    var isPostViewPresented: Bool = false
    
    var isAnyViewPresented: Bool = false
    
    var navigationStackCount: Int = 0
    
    func updateIsAnyViewPresented() {
        isAnyViewPresented = isBlogViewPresented || isPostViewPresented
    }
    
    func updateisMainTabViewPresented() {
        withAnimation {
            isMainTabViewPresented = !isAnyViewPresented
        }
    }
    
    func toggleIsBlogViewPresented() {
        isBlogViewPresented.toggle()
        updateIsAnyViewPresented()
        updateisMainTabViewPresented()
    }
    
    func toggleIsPostViewPresented() {
        isPostViewPresented.toggle()
        updateIsAnyViewPresented()
        updateisMainTabViewPresented()
    }
    
    func addNavigationStackCount() {
        navigationStackCount += 1
    }
    
    func removeNavigationStackCount() {
        navigationStackCount -= 1
    }
    
    // Button 동작
    // Back Button
    func backButtonAction(dismiss: @escaping () -> Void) {
        removeNavigationStackCount()
        if navigationStackCount == 0 {
            withAnimation {
                isBlogViewPresented = false
                isPostViewPresented = false
                updateIsAnyViewPresented()
                updateisMainTabViewPresented()
            }
        } else {
            dismiss()
        }
    }
    
    func pushNavigationStack(isNavigationToNext: inout Bool) {
        addNavigationStackCount()
        isNavigationToNext.toggle()
    }
    
    // Blog Button
    func openNavigationStackWithBlog() {
        toggleIsBlogViewPresented()
        addNavigationStackCount()
    }
    
    // Post Button
    func openNavigationStackWithPost() {
        toggleIsPostViewPresented()
        addNavigationStackCount()
    }
}

// Environment Key 정의
private struct ContentViewModelKey: EnvironmentKey {
    static let defaultValue = ContentViewModel()
}

// Environment Values 확장
extension EnvironmentValues {
    var contentViewModel: ContentViewModel {
        get { self[ContentViewModelKey.self] }
        set { self[ContentViewModelKey.self] = newValue }
    }
}