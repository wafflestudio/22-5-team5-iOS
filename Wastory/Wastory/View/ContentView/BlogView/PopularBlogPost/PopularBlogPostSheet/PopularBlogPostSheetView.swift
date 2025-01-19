//
//  PopularBlogPostSheetView.swift
//  Wastory
//
//  Created by 중워니 on 1/12/25.
//

import SwiftUI

struct PopularBlogPostSheetView: View {
    @State var viewModel = PopularBlogPostSheetViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // MARK: mainView
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Spacer()
                        .frame(height: 30)
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                // 스크롤 오프셋이 네비게이션 바 아래로 들어가면 텍스트 숨김
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    // MARK: 화면 상단 구성 요소
                    HStack(alignment: .bottom) {
                        //Navbar title
                        Text("인기글")
                            .font(.system(size: 34, weight: .medium))
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleIsCriterionSelectionSheetPresent()
                        }) {
                            HStack(spacing: 0) {
                                Text("\(viewModel.getSortCriterion())  ")
                                
                                Image(systemName: "chevron.down")
                            }
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color.primaryLabelColor)
                        }
                    }
                    .padding(.trailing, 22)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    //MARK: PostList
                    LazyVStack(spacing: 0) {
                        ForEach(Array(viewModel.popularBlogPostItems.enumerated()), id: \.offset) { index, item in
                            PopularBlogPostSheetCell(index: index + 1, viewModel: viewModel)
                            
                            Divider()
                                .foregroundStyle(Color.secondaryLabelColor)
                        }
                    }
                } //VStack
            } //ScrollView
            
            
            // MARK: CriterionSelectionSheet
            ZStack {
                //MARK: Background Dimming
                (viewModel.isCriterionSelectionSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.toggleIsCriterionSelectionSheetPresent()
                    }
                
                //MARK: CriterionSelectionSheet List
                VStack {
                    Spacer()
                    if viewModel.isCriterionSelectionSheetPresent {
                        let sheetTopSpace: CGFloat = 15
                        let sheetRowHeight: CGFloat = 60
                        let sheetBottomSpace: CGFloat = 30
                        let sheetHeight = sheetTopSpace + sheetBottomSpace + 3 * sheetRowHeight
                        
                        ZStack {
                            VStack(spacing: 0) {
                                Spacer()
                                    .frame(height: sheetTopSpace)
                                
                                ForEach(viewModel.sortCriterions.indices, id: \.self) { index in
                                    let type = viewModel.sortCriterions[index]
                                    
                                    CriterionSelectionButton(for: type, isLast: index == 2, rowHeight: sheetRowHeight)
                                }
                                
                                Spacer()
                                    .frame(height: sheetBottomSpace)
                            }
                            .frame(height: sheetHeight)
                            .background(Color.white)
                            .cornerRadius(20)
                            
                        }
                        .background(Color.clear)
                        .transition(.move(edge: .bottom)) // 아래에서 올라오는 애니메이션
                        .animation(.easeInOut, value: viewModel.isCriterionSelectionSheetPresent)
                        
                    }
                }
                
            }// ZStack
            .ignoresSafeArea()
        
        } //VStack
        // MARK: NavBar
        // TODO: rightTabButton - 검색버튼과 본인계정버튼은 4개의 TabView에 공통 적용이므로 추후 제작
        .navigationTitle(Text(viewModel.getIsNavTitleHidden() ? "" : "인기글"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    dismiss()
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(Color.primaryLabelColor)
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
        }
        .navigationBarBackButtonHidden()
        
    }
    
    //MARK: CriterionSelectionSheet Row(Button)
    @ViewBuilder func CriterionSelectionButton(for criterion: String, isLast: Bool, rowHeight: CGFloat) -> some View {
        Button(action: {
            viewModel.setSortCriterion(to: criterion)
            viewModel.toggleIsCriterionSelectionSheetPresent()
        }) {
            HStack(spacing: 0) {
                Text("\(criterion)")
                    .font(.system(size: 17, weight: viewModel.isCurrentSortCriterion(is: criterion) ? .semibold : .light))
                    .foregroundStyle(Color.primaryLabelColor)
                    .padding()
                
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .tint(viewModel.isCurrentSortCriterion(is: criterion) ? Color.primaryLabelColor : Color.clear)
                    .font(.system(size: 20, weight: .regular))
                    .padding(.trailing, 15)
            }
        }
        .frame(height: rowHeight)
        .frame(maxWidth: .infinity)
        
        if !isLast {
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
        }
    }
}
