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
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 20)
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                print("\(newValue), \(oldValue)")
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
                    
                    HStack {
                        TextField(text: $viewModel.writingCategoryName) {
                            Text("카테고리 이름을 입력하세요")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.secondaryLabelColor)
                        }
                        .textFieldStyle(.roundedBorder)
                        
                        Spacer()
                        
                        Button(action: {
                            // 카테고리 추가
                        }) {
                            Text("추가")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.primaryDarkModeLabelColor)
                                .frame(width: 67, height: 35)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(style: StrokeStyle(lineWidth: 1))
                                        .foregroundStyle(Color.secondaryDarkModeLabelColor)
                                )
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    
                    
                }//VStack
            } //ScrollView
        }//VStack
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
