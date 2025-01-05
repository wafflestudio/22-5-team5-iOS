//
//  HomeView.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct HomeView: View {
    
    var todaysWastoryItems = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 오늘의 티스토리
            TabView {
                ForEach(todaysWastoryItems, id: \.self) { item in
                    TodaysWastoryCell()
                }
            }
        }
    }
}
