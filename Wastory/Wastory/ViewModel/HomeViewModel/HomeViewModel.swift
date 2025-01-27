//
//  HomeViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//


import SwiftUI
import Observation

@MainActor
@Observable final class HomeViewModel {
    //NavBar Controller
    private var isScrolled: Bool = false
    
    private var initialScrollPosition: CGFloat = 0
    
    private var isInitialScrollPositionSet: Bool = false
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if !isInitialScrollPositionSet {
            setInitialScrollPosition(oldValue)
            isInitialScrollPositionSet = true
        }
        
        
        if newValue < initialScrollPosition {
            if (!isScrolled) {
                isScrolled = true
            }
        } else {
            if (isScrolled) {
                isScrolled = false
            }
        }
    }
    
    func getIsScrolled() -> Bool {
        isScrolled
    }
    
    
    //TodayWastoryPageTab
    func setDisplayedTodaysWastoryItems() {
        displayedTodaysWastoryItems = [todaysWastoryItems.last!] + todaysWastoryItems + [todaysWastoryItems.first!]
        print(displayedTodaysWastoryItems)
    }
    
    func setNextTodaysWastoryIndex(with newIndex: Int) {
        if newIndex == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.todaysWastoryIndex = self.todaysWastoryItems.count // 마지막 실제 데이터로 이동
            }
        }
        // 마지막에서 첫 번째로 이동해야 할 때
        else if newIndex == todaysWastoryItems.count + 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.todaysWastoryIndex = 1 // 첫 번째 실제 데이터로 이동
            }
        }
    }
    
    func autoScrollToNextPage() {
        withAnimation(.easeInOut) {
            self.todaysWastoryIndex += 1
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
    
    //Network
    //TodaysWastoryPageTab
    var todaysWastoryItems: [Post] = []
    var displayedTodaysWastoryItems: [Post] = []
    var todaysWastoryIndex: Int = 1

    //TodaysWastoryList
    var todaysWastoryListItems: [Post] = []
    
    //Category Popular Post List
    var categoryList: [HomeTopic] = []
    
    let categoryIcons : [Int: String] =
    [2: "airplane.departure", 3: "sofa", 4: "person.2", 5: "cpu", 6: "chart.bar.xaxis", 7: "book", 8: "tv", 9: "figure.indoor.soccer"]
    
    var selectedCategory: HomeTopic = HomeTopic.defaultHomeTopic
    
    var categoryPopularPostItems: [Post] = []
    
    
    //Focus Post List
    var focusPostList1Items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var focusPostList2Items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    
    func getTodaysWastoryItems() async {
        do {
            todaysWastoryItems = try await NetworkRepository.shared.getArticlesTodayWastory()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getTodaysWastoryListItems() async {
        do {
            todaysWastoryListItems = try await NetworkRepository.shared.getArticlesWeeklyWastory()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getHomeTopicList() async {
        do {
            categoryList = Array(try await NetworkRepository.shared.getHomeTopicList()[1...8])
            selectedCategory = categoryList.first!
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getCategoryPopularPostItems() async {
        do {
            categoryPopularPostItems = try await NetworkRepository.shared.getArticlesHomeTopic(highHomeTopicID: selectedCategory.id)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    //TODO: Focus get
}
