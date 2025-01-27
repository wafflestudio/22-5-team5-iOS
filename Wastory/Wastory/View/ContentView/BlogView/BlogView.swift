//
//  BlogView.swift
//  Wastory
//
//  Created by 중워니 on 1/7/25.
//

import SwiftUI

struct BlogView: View {
    let blogID: Int
    var categoryID: Int = -1
    var isMainTab: Bool = false
    @State var viewModel = BlogViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    
    @State var isPopularPresent: Bool = false
    
    var body: some View {
        ZStack() {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    BlogHeaderView(blog: viewModel.blog)
                    
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
                    PopularBlogPostListView(blog: viewModel.blog)
                    
                    // 카테고리 별 글 TODO: 카테고리 선택 sheet 및 카테고리 별로 분류
                    BlogPostListView()
                    
                } //VStack
            } //ScrollView
            // MARK: refreshing
            .refreshable {
                print("refresh")
                viewModel.resetPage()
                Task {
                    await viewModel.getPostsInCategory()
                }
                Task {
                    await viewModel.getPopularBlogPosts()
                }
            }
            
            
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
                        let sheetTopSpace: CGFloat = 30
                        let sheetRowHeight: CGFloat = 60
                        let sheetBottomSpace: CGFloat = 30 + (isMainTab ? 100 : 0)
                        let sheetTitleHeight: CGFloat = 50
                        let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.6
                        
                        
                        ZStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Spacer()
                                    .frame(height: sheetTopSpace)
                                
                                Text("카테고리")
                                    .font(.system(size: 30, weight: .medium))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .frame(height: sheetTitleHeight)
                                    .padding(.leading, 20)
                                ScrollView {
                                    VStack(spacing: 0) {
                                        ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { index, category in
                                            
                                            CategoryButton(for: category, isLast: index == viewModel.getCategoriesCount() - 1, rowHeight: sheetRowHeight)
                                        }
                                    }
                                    
                                    Spacer()
                                        .frame(height: sheetBottomSpace)
                                }
                                
                            }
                            .frame(height: sheetHeight)
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
        .onAppear {
            Task {
                await viewModel.initBlog(blogID)
                viewModel.resetPage()
                Task {
                    await viewModel.getPopularBlogPosts()
                }
                Task {
                    await viewModel.getCategories()
                    for category in viewModel.categories {
                        if category.id == categoryID {
                            viewModel.selectedCategory = category
                            break
                        } else {
                            for child in category.children ?? [] {
                                if child.id == categoryID {
                                    viewModel.selectedCategory = child
                                    break
                                }
                            }
                        }
                    }
                    await viewModel.getPostsInCategory()
                }
            }
        }
        .environment(\.blogViewModel, viewModel)
        .ignoresSafeArea(edges: .all)
        // MARK: NavBar
        .navigationTitle(viewModel.getIsNavTitleHidden() ? "" : viewModel.blog.blogName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(viewModel.getIsNavTitleHidden() ? .hidden : .visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarVisibility(isMainTab ? .hidden : .visible, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 20) {
                    contentViewModel.navigateToSearchViewButton(blogID: 0) {
                        Text(Image(systemName: "magnifyingglass"))
                            .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                    }
                    
                    Button(action: {
                        //차단하기 신고하기 sheet present
                        //if myBlog -> blogSheet present
                    }) {
                        KFImageWithDefaultIcon(imageURL: viewModel.blog.mainImageURL)
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 30, height: 30)
                    }
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    dismiss()
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
    }
    
    //MARK: CategorySheet Row(Button)
    @ViewBuilder func CategoryButton(for category: Category, isLast: Bool, rowHeight: CGFloat) -> some View {
        Button(action: {
            viewModel.setCategory(to: category)
            viewModel.resetPage()
            Task {
                await viewModel.getPostsInCategory()
            }
            viewModel.toggleIsCategorySheetPresent()
        }) {
            HStack(spacing: 0) {
                Text("\(category.categoryName)")
                    .font(.system(size: 17, weight: .light))
                    .padding()
                
                Spacer()
                
                if category.id != -1 {
                    Text("\(category.articleCount ?? 0)") // 카테고리 글 개수
                        .font(.system(size: 17, weight: .light))
                        .padding()
                }
            }
            .foregroundStyle(viewModel.isCurrentCategory(is: category) ? Color.loadingCoralRed : Color.primaryLabelColor)
        }
        .frame(height: rowHeight)
        .frame(maxWidth: .infinity)
        
        
        //TODO: Children 추가기능 구현
        ForEach(Array((category.children ?? []).enumerated()), id: \.offset) { index, child in
            
            Button(action: {
                viewModel.setCategory(to: child)
                viewModel.resetPage()
                Task {
                    await viewModel.getPostsInCategory()
                }
                viewModel.toggleIsCategorySheetPresent()
            }) {
                HStack(spacing: 0) {
                    Text("ㄴ \(child.categoryName)")
                        .font(.system(size: 15, weight: .light))
                        .padding()
                    
                    Spacer()
                    
                    Text("\(child.articleCount ?? 0)") // 카테고리 글 개수
                        .font(.system(size: 15, weight: .light))
                        .padding()
                }
                .foregroundStyle(viewModel.isCurrentCategory(is: child) ? Color.loadingCoralRed : Color.primaryLabelColor)
            }
            .frame(height: rowHeight)
            .frame(maxWidth: .infinity)
        }
        
        
        if !isLast {
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
        }
    }
    
}

