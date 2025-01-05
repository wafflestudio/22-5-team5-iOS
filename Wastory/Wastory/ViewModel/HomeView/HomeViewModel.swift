//
//  HomeViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//


import SwiftUI
import Observation

@Observable final class HomeViewModel {
    
    var todaysWastoryItems = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    var displayedTodaysWastoryItems: [String] = []
    
    var todaysWastoryIndex: Int = 1

    
    
    init() {
        setDisplayedTodaysWastoryItems()
    }
    
    func setDisplayedTodaysWastoryItems() {
        displayedTodaysWastoryItems = [todaysWastoryItems.last!] + todaysWastoryItems + [todaysWastoryItems.first!]
    }
    
    func setNextTodaysWastoryIndex(with newIndex: Int) {
        if newIndex == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.todaysWastoryIndex = self.todaysWastoryItems.count // 마지막 실제 데이터로 이동
            }
        }
        // 마지막에서 첫 번째로 이동해야 할 때
        else if newIndex == todaysWastoryItems.count + 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.todaysWastoryIndex = 1 // 첫 번째 실제 데이터로 이동
            }
        }
    }
    
    func indexIndicator(for index: Int) -> some View {
        let radius: CGFloat = (index == todaysWastoryIndex ? 6 : 3)
        if index == 0 || index == displayedTodaysWastoryItems.count - 1 {
            return Circle()
                .foregroundStyle(Color.clear)
                .frame(width: radius, height: radius)
        } else {
            return Circle()
                .foregroundStyle(index == todaysWastoryIndex ? Color.black : Color.middleDotColor)
                .frame(width: radius, height: radius)
        }
    }
}
