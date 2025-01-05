//
//  HomeViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//


import SwiftUI
import Observation

@Observable final class HomeViewModel {
    
    //TodaysWastoryPageTab
    var todaysWastoryItems = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    var displayedTodaysWastoryItems: [String] = []
    var todaysWastoryIndex: Int = 1

    //TodaysWastoryList
    var todaysWastoryListItems = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    //Category Popular Post
    let categoryList = ["여행·맛집", "리빙·스타일", "가족·연애", "직장·자기계발", "시사·지식", "도서·창작", "엔터테인먼트", "취미·건강"]
    
    let categoryIcons : [String: String] =
    ["여행·맛집": "airplane.departure", "리빙·스타일": "sofa", "가족·연애": "person.2", "직장·자기계발": "cpu", "시사·지식": "chart.bar.xaxis", "도서·창작": "book", "엔터테인먼트": "tv", "취미·건강": "figure.indoor.soccer"]
    
    var selectedCategory: String = "여행·맛집"
    
    var categoryPopularPostItems: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7"]
    
    
    init() {
        setDisplayedTodaysWastoryItems()
    }
    
    //TodayWastoryPageTab
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
