//
//  BlogView.swift
//  Wastory
//
//  Created by 중워니 on 1/7/25.
//

import SwiftUI

struct BlogView: View {
    let blog: Blog
    @State var viewModel = BlogViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    
    @State var isPopularPresent: Bool = false
    
    var body: some View {
        ZStack() {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    BlogHeaderView()
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    
                    // 인기글 TODO: 인기글 모두보기 View
                    PopularBlogPostListView()
                    
                    // 카테고리 별 글 TODO: 카테고리 선택 sheet 및 카테고리 별로 분류
                    BlogPostListView()
                    
                } //VStack
            } //ScrollView
            
            
            //MARK: CategorySheet
            ZStack {
                //MARK: Background Dimming
                (viewModel.isCategorySheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.toggleIsCategorySheetPresent()
                    }
                
                //MARK: categorySheet List
                VStack {
                    Spacer()
                    if viewModel.isCategorySheetPresent {
                        let typeSheetTopSpace = viewModel.sheetTopSpace
                        let typeSheetRowHeight = viewModel.sheetRowHeight
                        let typeSheetBottomSpace = viewModel.sheetBottomSpace
                        let typeSheetTitleHeight: CGFloat = 50
                        let typeSheetHeight = typeSheetTopSpace + typeSheetBottomSpace + CGFloat(viewModel.getCategoryItemsCount()) * typeSheetRowHeight + typeSheetTitleHeight
                        
                        ZStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Spacer()
                                    .frame(height: typeSheetTopSpace)
                                
                                Text("카테고리")
                                    .font(.system(size: 30, weight: .medium))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .frame(height: typeSheetTitleHeight)
                                    .padding(.leading, 20)
                                
                                ForEach(Array(viewModel.categoryItems.enumerated()), id: \.offset) { index, category in
                                    
                                    CategoryButton(for: category, isLast: index == viewModel.getCategoryItemsCount() - 1, rowHeight: typeSheetRowHeight)
                                }
                                
                                Spacer()
                                    .frame(height: typeSheetBottomSpace)
                            }
                            .frame(height: typeSheetHeight)
                            .background(Color.white)
                            .cornerRadius(20)
                            
                        }
                        .background(Color.clear)
                        .transition(.move(edge: .bottom)) // 아래에서 올라오는 애니메이션
                        .animation(.easeInOut, value: viewModel.isCategorySheetPresent)
                        
                    }
                }
                
            }// ZStack
            .ignoresSafeArea()
            
        } //ZStack
        .environment(\.contentViewModel, contentViewModel)
        .environment(\.blogViewModel, viewModel)
        .ignoresSafeArea(edges: .all)
        // MARK: NavBar
        .navigationTitle(viewModel.getIsNavTitleHidden() ? "" : "블로그 이름")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(viewModel.getIsNavTitleHidden() ? .hidden : .visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 20) {
                    Button{
                        
                    } label: {
                        Text(Image(systemName: "magnifyingglass"))
                            .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                    }
                    
                    Button(action: {
                        //차단하기 신고하기 sheet present
                    }) {
                        Image(systemName: "questionmark.text.page.fill")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 30, height: 30)
                    }
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    contentViewModel.backButtonAction {
                        dismiss()
                    }
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
    }
    
    //MARK: CategorySheet Row(Button)
    @ViewBuilder func CategoryButton(for category: String, isLast: Bool, rowHeight: CGFloat) -> some View {
        Button(action: {
            viewModel.setCategory(to: category)
            viewModel.toggleIsCategorySheetPresent()
        }) {
            HStack(spacing: 0) {
                Text("\(category)")
                    .font(.system(size: 17, weight: .light))
                    .padding()
                
                Spacer()
                
                Text("555") // 카테고리 글 갯수
                    .font(.system(size: 17, weight: .light))
                    .padding()
            }
            .foregroundStyle(viewModel.isCurrentCategory(is: category) ? Color.loadingCoralRed : Color.primaryLabelColor)
        }
        .frame(height: rowHeight)
        .frame(maxWidth: .infinity)
        
        
        //TODO: Children 추가기능 구현
//        ForEach(Array(category.children.enumerated()), id: \.offset) { index, child in
//            
//            Button(action: {
//                viewModel.setCategory(to: child)
//                viewModel.toggleIsCategorySheetPresent()
//            }) {
//                HStack(spacing: 0) {
//                    Text("ㄴ \(child)")
//                        .font(.system(size: 15, weight: .light))
//                        .padding()
//                    
//                    Spacer()
//                    
//                    Text("555") // 카테고리 글 갯수
//                        .font(.system(size: 15, weight: .light))
//                        .padding()
//                }
//                .foregroundStyle(viewModel.isCurrentCategory(is: category) ? Color.loadingCoralRed : Color.primaryLabelColor)
//            }
//            .frame(height: rowHeight)
//            .frame(maxWidth: .infinity)
//        }
        
        
        if !isLast {
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
        }
    }
    
}


extension Color {
    static let primaryDarkModeLabelColor = Color.white
    static let secondaryDarkModeLabelColor = Color.init(red: 0.9, green: 0.9, blue: 0.9).opacity(0.8)
}
