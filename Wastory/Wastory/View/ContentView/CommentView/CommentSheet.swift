//
//  CommentSheet.swift
//  Wastory
//
//  Created by 중워니 on 1/28/25.
//



import SwiftUI

struct CommentSheet: View {
    @Bindable var viewModel: CommentViewModel
    
    var body: some View {
        ZStack {
            // MARK: Background Dimming
            (viewModel.isCommentSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.resetEditingComment()
                    viewModel.toggleIsCommentSheetPresent()
                }
            
            VStack {
                Spacer()
                if viewModel.isCommentSheetPresent {
                    let sheetTopSpace: CGFloat = 30
                    let sheetRowHeight: CGFloat = 60
                    let sheetBottomSpace: CGFloat = 30
                    let sheetHeight: CGFloat = sheetTopSpace + sheetRowHeight * 2 + sheetBottomSpace
                    
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: sheetTopSpace)
                        
                        Button(action: {
                            viewModel.toggleIsCommentEditSheetPresent()
                        }) {
                            HStack(alignment: .center) {
                                Text("수정")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .padding(.horizontal, 20)
                                
                                Spacer()
                            }
                        }
                        .frame(height: sheetRowHeight)
                        .fullScreenCover(isPresented: $viewModel.isCommentEditSheetPresent) {
                            
                            //MARK: Editing fullscreen sheet
                            VStack(alignment: .leading, spacing: 0) {
                                ZStack(alignment: .center) {
                                    HStack(spacing: 0) {
                                        Button {
                                            viewModel.resetEditingComment()
                                            viewModel.resetEditingCommentText()
                                            viewModel.toggleIsCommentSheetPresent()
                                            viewModel.toggleIsCommentEditSheetPresent()
                                        } label: {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 24, weight: .light))
                                                .foregroundStyle(Color.primaryLabelColor)
                                        }
                                        Spacer()
                                    }
                                    
                                    Text("댓글 수정")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundStyle(Color.primaryLabelColor)
                                    
                                }
                                .padding()
                                
                                Divider()
                                    .foregroundStyle(Color.secondaryLabelColor)
                                
                                ScrollView {
                                    VStack(spacing: 0) {
                                        TextEditor(text: $viewModel.editingCommentText)
                                            .font(.system(size: 16, weight: .light))
                                            .foregroundStyle(Color.primaryLabelColor)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 300)
                                            .background(Color.secondaryLabelColor.opacity(0.1))
                                            .textInputAutocapitalization(.never)
                                    }
                                    .padding()
                                }
                                
                                HStack(spacing: 0) {
                                    Spacer()
                                    
                                    Button(action: {
                                        Task {
                                            print("patch comment")
                                            await viewModel.patchComment()
                                            print("patch comment2")
                                            viewModel.resetPage()
                                            viewModel.resetEditingComment()
                                            viewModel.resetEditingCommentText()
                                            await viewModel.getComments()
                                            viewModel.toggleIsCommentSheetPresent()
                                            viewModel.toggleIsCommentEditSheetPresent()
                                        }
                                    }) {
                                        Text("등록")
                                            .font(.system(size: 16, weight: viewModel.isEditingCommentEmpty() ? .light : .semibold))
                                            .foregroundStyle(viewModel.isEditingCommentEmpty() ? Color.secondaryLabelColor : Color.white)
                                            .frame(width: 65, height: 35)
                                            .background (
                                                VStack(spacing: 0) {
                                                    if viewModel.isEditingCommentEmpty() {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(style: StrokeStyle(lineWidth: 0.5))
                                                            .foregroundStyle(Color.secondaryLabelColor)
                                                    } else {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .foregroundStyle(Color.primaryLabelColor)
                                                    }
                                                }
                                            )
                                    }
                                    .disabled(viewModel.isEditingCommentEmpty())
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 10)
                                }
                            }
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: viewModel.isCommentEditSheetPresent)
                        }
                        
                        Divider()
                            .foregroundStyle(Color.secondaryLabelColor)
                        
                        Button(action: {
                            viewModel.toggleIsCommentDeleteAlertPresent()
                        }) {
                            HStack(alignment: .center) {
                                Text("삭제")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .padding(.horizontal, 20)
                                
                                Spacer()
                            }
                        }
                        .frame(height: sheetRowHeight)
                        .alert("댓글 삭제", isPresented: $viewModel.isCommentDeleteAlertPresent) {
                            
                            if (viewModel.editingComment?.children ?? []).isEmpty {
                                Button("취소", role: .cancel) {}
                                
                                Button("삭제", role: .destructive) {
                                    Task {
                                        await viewModel.deleteComment()
                                        viewModel.resetPage()
                                        viewModel.resetEditingComment()
                                        viewModel.resetEditingCommentText()
                                        await viewModel.getComments()
                                        viewModel.toggleIsCommentSheetPresent()
                                    }
                                }
                            } else {
                                Button("확인", role: .cancel) {}
                            }
                        } message: {
                            if (viewModel.editingComment?.children ?? []).isEmpty {
                                Text("해당 댓글을 삭제하시겠습니까?")
                            } else {
                                Text("답글이 달린 경우에는 삭제가 불가합니다")
                            }
                        }
                        
                        Spacer()
                            .frame(height: sheetBottomSpace)

                    }
                    .frame(height: sheetHeight)
                    .background(Color.white)
                    .cornerRadius(20)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: viewModel.isCommentSheetPresent)
                }
            }
        }
        .ignoresSafeArea()
    }
    
}


