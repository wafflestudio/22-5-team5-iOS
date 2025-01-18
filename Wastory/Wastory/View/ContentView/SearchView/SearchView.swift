//
//  SearchView.swift
//  Wastory
//
//  Created by 중워니 on 1/18/25.
//

import SwiftUI

struct SearchView: View {
    let blogID: Int?
    
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
        }
        // MARK: NavBar
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 0) {
                    Button{
                        contentViewModel.backButtonAction {
                            dismiss()
                        }
                    } label: {
                        Text(Image(systemName: "chevron.backward"))
                            .foregroundStyle(Color.black)
                    }
                    
                    Spacer()
                        .frame(width: 10)
                    
                    HStack(spacing: 0) {
                        ZStack {
                            if viewModel.isSearchKeywordEmpty(){
                                Text(viewModel.isSearchingInBlog ? "이 블로그에서 검색" : "티스토리 전체에서 검색")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                            }
                        
                            TextField("", text: $viewModel.searchKeyword)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color.primaryLabelColor)
                                .textFieldStyle(.plain)
                        }
                        
                        
                    }
                    
                    
                    
                    if viewModel.isSearchingInBlog {
                        Button{
                            //SearchView() 로 네비게이션
                        } label: {
                            Text(Image(systemName: "chevron.backward"))
                                .foregroundStyle(Color.black)
                        }
                    }
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
    }
}
