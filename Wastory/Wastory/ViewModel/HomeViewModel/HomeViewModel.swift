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
        displayedTodaysWastoryItems = [todaysWastoryItems.last ?? Post.defaultPost] + todaysWastoryItems + [todaysWastoryItems.first ?? Post.defaultPost]
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
    var categoryList: [HomeTopic] = [
        HomeTopic(id: 2, name: "여행·맛집", highCategory: 0),
        HomeTopic(id: 3, name: "리빙·스타일", highCategory: 0),
        HomeTopic(id: 4, name: "가족·연애", highCategory: 0),
        HomeTopic(id: 5, name: "직장·자기계발", highCategory: 0),
        HomeTopic(id: 6, name: "시사·지식", highCategory: 0),
        HomeTopic(id: 7, name: "도서·창작", highCategory: 0),
        HomeTopic(id: 8, name: "엔터테인먼트", highCategory: 0),
        HomeTopic(id: 9, name: "취미·건강", highCategory: 0)
    ]
    
    let categoryIcons : [Int: String] =
    [2: "airplane.departure", 3: "sofa", 4: "person.2", 5: "cpu", 6: "chart.bar.xaxis", 7: "book", 8: "tv", 9: "figure.indoor.soccer"]
    
    var selectedCategory: HomeTopic = HomeTopic(id: 2, name: "여행·맛집", highCategory: 0)
    
    var categoryPopularPostItems: [Post] = []
    
    
    //Focus Post List
    var focusPostList1Items: [Post] = []
    
    var focusPostList2Items: [Post] = []
    
    
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
    
    func getCategoryPopularPostItems() async {
        do {
            categoryPopularPostItems = try await NetworkRepository.shared.getArticlesHomeTopic(highHomeTopicID: selectedCategory.id)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    //TODO: Focus get
    func getFocusPostList1Items() async {
        do {
            focusPostList1Items = try await NetworkRepository.shared.getFocusArticles1()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getFocusPostList2Items() async {
        do {
            focusPostList2Items = try await NetworkRepository.shared.getFocusArticles2()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
