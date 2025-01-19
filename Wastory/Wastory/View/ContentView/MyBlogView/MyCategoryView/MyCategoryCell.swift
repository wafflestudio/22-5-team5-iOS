//
//  MyCategoryCell.swift
//  Wastory
//
//  Created by 중워니 on 1/17/25.
//

import SwiftUI

struct MyCategoryCell: View {
    var category: Category
    @Bindable var viewModel : MyCategoryViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(spacing: 0) {
                    if category.level != 0 {
                        Spacer()
                            .frame(width: 30)
                        
                        Text("ㄴ")
                            .font(.system(size: 18, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                    } else {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 18))
                            .foregroundStyle(Color.secondaryLabelColor)
                    }
                    
                    Spacer()
                        .frame(width: 10)
                    
                    Text(category.categoryName)
                        .font(.system(size: 18, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    
                }//H
                
                //MARK: buttons
                if viewModel.isCategorySelected(category.id) {
                    
                    if viewModel.isCategoryAddingOrEditing {
                        HStack(spacing: 5) {
                            if category.level != 0 {
                                Spacer()
                                    .frame(width: 20)
                            }
                            
                            Spacer()
                                .frame(width: 25)
                            
                            TextField(text: $viewModel.writingCategoryName) {
                                Text((viewModel.isCategoryAdding ? "추가할" : "수정할") + " 카테고리 이름을 입력하세요")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                            }
                            .textFieldStyle(.roundedBorder)
                            
                            Spacer()
                            
                            Button(action: {
                                if viewModel.isCategoryAdding {
                                    // writingCategoryName으로 된 category 현재 카테고리를 부모로 갖게 추가
                                } else if viewModel.isCategoryEditing{
                                    // writingCategoryName으로 현재 카테고리 이름을 수정
                                }
                                viewModel.toggleSelectedCategoryId(with: category.id)
                            }) {
                                Text("완료")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.loadingCoralRed)
                                    .frame(width: 67, height: 30)
                                    .background(
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundStyle(Color.white)
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(style: StrokeStyle(lineWidth: 1))
                                                .foregroundStyle(Color.loadingCoralRed)
                                        }
                                    )
                            }
                        }
                    } else {
                        HStack(spacing: 5) {
                            Spacer()
                            
                            Button(action: {
                                viewModel.isCategoryEditing.toggle()
                            }) {
                                Text("수정")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.loadingCoralRed)
                                    .frame(width: 67, height: 30)
                                    .background(
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundStyle(Color.white)
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(style: StrokeStyle(lineWidth: 1))
                                                .foregroundStyle(Color.loadingCoralRed)
                                        }
                                    )
                            }
                            
                            if category.level == 0 {
                                Button(action: {
                                    viewModel.isCategoryAdding.toggle()
                                }) {
                                    Text("추가")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.loadingCoralRed)
                                        .frame(width: 67, height: 30)
                                        .background(
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .foregroundStyle(Color.white)
                                                
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                                    .foregroundStyle(Color.loadingCoralRed)
                                            }
                                        )
                                }
                            }
                            
                            Button(action: {
                                viewModel.isCategoryDelete.toggle()
                            }) {
                                Text("삭제")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.loadingCoralRed)
                                    .frame(width: 67, height: 30)
                                    .background(
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundStyle(Color.white)
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(style: StrokeStyle(lineWidth: 1))
                                                .foregroundStyle(Color.loadingCoralRed)
                                        }
                                    )
                            }
                            .alert("카테고리 삭제", isPresented: $viewModel.isCategoryDelete) {
                                Button("취소", role: .cancel) {}
                                Button("삭제", role: .destructive) {
                                    viewModel.deleteCategory(category.id)
                                }
                            } message: {
                                Text("\(category.categoryName)(를)을 삭제하시겠습니까?")
                            }
                        }//H
                    }
                } //H
            }//Z
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .frame(height: 60)
            
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
            
            ForEach(category.children) { child in
                MyCategoryCell(category: child, viewModel: viewModel)
            }
        }//V
        .onTapGesture {
            viewModel.toggleSelectedCategoryId(with: category.id)
        }
    }
}
