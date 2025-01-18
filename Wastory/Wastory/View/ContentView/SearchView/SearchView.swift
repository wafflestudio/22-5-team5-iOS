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
                
            } else {
                
            }//if viewModel.isSearched
        }//V1
        .onAppear {
            viewModel.setIsSearchingInBlog(blogID)
            viewModel.setPrevSearchKeyword(prevSearchKeyword)
        }
        // MARK: NavBar
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    contentViewModel.backButtonAction {
                        dismiss()
                    }
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
                                    //Do Search
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
                    Button (action: {
                        contentViewModel.navigateToSearch(with: viewModel.searchKeyword)
                    }) {
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
