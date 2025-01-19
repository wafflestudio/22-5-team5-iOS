//
//  SearchView.swift
//  Wastory
//
//  Created by 중워니 on 1/18/25.
//

import SwiftUI

struct SearchView: View {
    let blogID: Int?
    let prevSearchKeyword: String?
    
    @State var viewModel = SearchViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isSearched {
                //MARK: 검색결과
                //전체 글 검색
                //MARK: 글 or 블로그 검색 선택 Button
                HStack(spacing: 0) {
                    Button(action: {
                        viewModel.setSearchType(to: .post)
                        viewModel.doSearch()
                    }) {
                        VStack(alignment: .center, spacing: 0) {
                            Text("글")
                                .font(.system(size: 16, weight: viewModel.isSearchType(is: .post) ? .semibold : .light))
                                .frame(height: 50)
                                .foregroundStyle(viewModel.isSearchType(is: .post) ? Color.primaryLabelColor : Color.secondaryLabelColor)
                            
                            Rectangle()
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(viewModel.isSearchType(is: .post) ? Color.primaryLabelColor : Color.secondaryLabelColor)
                        }
                    }
                    
                    if viewModel.isSearchingInBlog {
                        
                    } else {
                        Button(action: {
                            viewModel.setSearchType(to: .blog)
                            viewModel.doSearch()
                        }) {
                            VStack(alignment: .center, spacing: 0) {
                                Text("블로그")
                                    .font(.system(size: 16, weight: viewModel.isSearchType(is: .blog) ? .semibold : .light))
                                    .frame(height: 50)
                                    .foregroundStyle(viewModel.isSearchType(is: .blog) ? Color.primaryLabelColor : Color.secondaryLabelColor)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(viewModel.isSearchType(is: .blog) ? Color.primaryLabelColor : Color.secondaryLabelColor)
                            }
                        }
                    }
                }
                
                //MARK: 검색결과 List
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Text("\(viewModel.resultCount) 개")
                                .font(.system(size: 16, weight: .light))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        
                        
                        if viewModel.isSearchType(is: .post) {
                            ForEach(Array(viewModel.searchPostResult.enumerated()), id: \.offset) { index, post in
                                FeedCell(post: post)
                                Divider()
                                    .foregroundStyle(Color.secondaryLabelColor)
                            }
                        } else if viewModel.isSearchType(is: .blog) {
                            ForEach(Array(viewModel.searchBlogResult.enumerated()), id: \.offset) { index, blog in
                                SearchedBlogCell(blog: blog)
                                Divider()
                                    .foregroundStyle(Color.secondaryLabelColor)
                            }
                        }
                        
                    }
                } //ScrollView
            } else {
                //MARK: 최근검색 기록
                
            }//if viewModel.isSearched
        }//V1
        .onAppear {
            viewModel.setIsSearchingInBlog(blogID)
            viewModel.setPrevSearchKeyword(prevSearchKeyword)
            viewModel.doOnAppear()
            viewModel.doSearch()
        }
        // MARK: NavBar
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    dismiss()
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(Color.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ZStack {
                            if viewModel.isSearchKeywordEmpty() {
                                HStack {
                                    Text(viewModel.isSearchingInBlog ? "이 블로그에서 검색" : "티스토리 전체에서 검색")
                                        .font(.system(size: 18, weight: .light))
                                        .foregroundStyle(Color.secondaryLabelColor)
                                        .padding(.leading, 15)
                                    Spacer()
                                }
                            }
                            
                            HStack(spacing: 0) {
                                TextField("", text: $viewModel.searchKeyword)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .textFieldStyle(.plain)
                                    .padding(.horizontal, 15)
                                    .onSubmit {
                                        viewModel.setSearchType(to: .post)
                                        viewModel.doSearch()
                                    }
                                    .onChange(of: viewModel.searchKeyword) { newValue, oldValue in
                                        viewModel.setIsSearched(to: false)
                                    }
                                
                                if !viewModel.isSearchKeywordEmpty() {
                                    Button(action: {
                                        viewModel.clearSearchKeyword()
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .font(.system(size: 13))
                                            .foregroundStyle(Color.secondaryLabelColor)
                                    }
                                    .frame(width: 10, height: 10)
                                    .padding(.trailing, 10)
                                }
                                
                                Button (action: {
                                    viewModel.setSearchType(to: .post)
                                    viewModel.doSearch()
                                }) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 15))
                                        .foregroundStyle(viewModel.isSearchKeywordEmpty() ? Color.promptLabelColor : Color.primaryLabelColor)
                                }
                                .padding(.trailing, 10)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - (viewModel.isSearchingInBlog ? 180 : 80))
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color.backgourndSpaceColor)
                                .frame(height: 45)
                        }
                    }
                }
            }
                    
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.isSearchingInBlog {
                    contentViewModel.navigateToSearchViewButton(prevSearchKeyword: viewModel.searchKeyword) {
                        Text("전체검색")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.primaryLabelColor)
                            .frame(width: 85, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundStyle(Color.secondaryLabelColor)
                            )
                    }
                    .disabled(viewModel.isSearchKeywordEmpty())
                }
            }
        }//ToolBar
        .navigationBarBackButtonHidden()
    }
}
