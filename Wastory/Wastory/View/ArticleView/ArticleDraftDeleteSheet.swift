//
//  ArticleDraftDeleteSheet.swift
//  Wastory
//
//  Created by mujigae on 1/29/25.
//

import SwiftUI

struct ArticleDraftDeleteSheet: View {
    @Bindable var viewModel: ArticleViewModel
    
    var body: some View {
        ZStack {
            // MARK: Background Dimming
            (viewModel.isDraftDeleteSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.toggleIsDraftDeleteSheetPresent()
                }

            VStack {
                Spacer()
                if viewModel.isDraftDeleteSheetPresent {
                    let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.12
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                                .frame(height: 30)
                            Button {
                                viewModel.isDraftDeleteSheetPresent = false
                                viewModel.showDeleteAlert = true
                            } label: {
                                HStack {
                                    Text("삭제하기")
                                        .font(.system(size: 15, weight: .light))
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                            }
                            Spacer()
                        }
                        .frame(height: sheetHeight)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    .background(Color.clear)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: viewModel.isDraftDeleteSheetPresent)
                }
            }
        }
        .ignoresSafeArea()
    }
}
