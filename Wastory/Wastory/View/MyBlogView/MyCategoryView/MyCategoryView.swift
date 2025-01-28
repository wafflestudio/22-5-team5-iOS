//
//  MyCategoryView.swift
//  Wastory
//
//  Created by 중워니 on 1/17/25.
//

import SwiftUI

struct MyCategoryView: View {
    @State var viewModel = MyCategoryViewModel()
    @Environment(\.dismiss) private var dismiss
//    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 20)
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                if abs(newValue - oldValue) > 100 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    HStack {
                        Text("내 카테고리")
                            .font(.system(size: 34, weight: .medium))
                            .foregroundStyle(Color.primaryLabelColor)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        if viewModel.isCategoryAddButtonActivated {
                            TextField(text: $viewModel.writingCategoryName) {
                                Text("카테고리 이름을 입력하세요")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.secondaryLabelColor)
                            }
                            .textFieldStyle(.roundedBorder)
                        }
                        
                        Spacer()
                        Spacer()
                            .frame(width: 20)
                        
                        if viewModel.isCategoryAddButtonActivated {
                            if viewModel.writingCategoryName.isEmpty {
                                Button(action: {
                                    viewModel.isCategoryAddButtonActivated.toggle()
                                }) {
                                    Text("취소")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.primaryLabelColor)
                                        .frame(width: 67, height: 35)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(style: StrokeStyle(lineWidth: 1))
                                                .foregroundStyle(Color.secondaryLabelColor)
                                        )
                                }
                            } else {
                                Button(action: {
                                    viewModel.isCategoryAddButtonActivated.toggle()
                                    Task {
                                        await viewModel.postCategory()
                                        await viewModel.getCategories()
                                    }
                                }) {
                                    Text("완료")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.loadingCoralRed)
                                        .frame(width: 67, height: 35)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(style: StrokeStyle(lineWidth: 1))
                                                .foregroundStyle(Color.loadingCoralRed)
                                        )
                                }
                            }
                        } else {
                            Button(action: {
                                viewModel.unselectCategoryId()
                                viewModel.clearWritingCategoryName()
                                viewModel.isCategoryAddButtonActivated.toggle()
                            }) {
                                Text("추가")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .frame(width: 67, height: 35)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundStyle(Color.secondaryLabelColor)
                                    )
                            }
                        }
                            
                    }
                    .padding(.horizontal, 20)
                    
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Divider()
                        .foregroundStyle(Color.secondaryLabelColor)
                    
                    ForEach(viewModel.categories) { category in
                        MyCategoryCell(category: category, viewModel: viewModel)
                    }
                    
                    
                    
                }//VStack
            } //ScrollView
        }//VStack
        // MARK: Networking
        .onAppear {
            Task {
                await viewModel.getCategories()
            }
        }
        // MARK: NavBar
        .navigationTitle(viewModel.getIsNavTitleHidden() ? "" : "카테고리")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    dismiss()
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(Color.black)
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MyCategoryView()
}
