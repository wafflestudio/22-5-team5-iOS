//
//  ArticleSettingView.swift
//  Wastory
//
//  Created by mujigae on 1/16/25.
//

import SwiftUI
import RichTextKit
import PhotosUI

import Foundation

@MainActor
struct ArticleSettingView: View {
    @Bindable private var articleViewModel: ArticleViewModel
    @State private var viewModel: ArticleSettingViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(articleViewModel: ArticleViewModel, viewModel: ArticleSettingViewModel) {
        self.articleViewModel = articleViewModel
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: Custom Navigation Bar
                ZStack {
                    HStack {
                        CustomBackButton(size: 24, weight: .light)
                        Spacer()
                        Button {
                            Task {
                                viewModel.callAPIRequest()
                                if articleViewModel.editingPost == nil {
                                    await viewModel.postArticle()
                                } else {
                                    await viewModel.patchArticle(postID: articleViewModel.editingPost!.id)
                                }
                                dismiss()
                                articleViewModel.isSubmitted.toggle()
                            }
                        } label: {
                            Text("발행")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.white)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 15)
                        }
                        .background(.black)
                        .cornerRadius(40)
                        .padding(.trailing, 7)
                        .disabled(viewModel.isWaitingResponse)
                    }
                    Text("발행 설정")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
                SettingDivider(thickness: 1)
                Spacer()
                    .frame(height: 30)
                
                HStack(alignment: .top) {
                    Text(viewModel.getTitle())
                        .font(.system(size: 17, weight: .light))
                        .padding(.top, 10)
                    Spacer()
                    Button {
                        viewModel.toggleImagePickerPresented()
                    } label: {
                        if let mainImage = viewModel.mainImage {
                            Image(uiImage: mainImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .id(mainImage)
                        }
                        else {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color.articleImageBackgroundGray)
                                    .frame(width: 100, height: 100)
                                VStack(spacing: 0) {
                                    Image(systemName: "camera")
                                    Spacer()
                                        .frame(height: 3)
                                    Text("대표이미지")
                                        .font(.system(size: 12))
                                }
                                .foregroundStyle(Color.articleImageTextGray)
                                .padding(30)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
                    .frame(height: 20)
                SettingDivider(thickness: 1)
                
                Button {
                    viewModel.toggleIsCategorySheetPresent()
                } label: {
                    HStack {
                        Text("카테고리")
                            .font(.system(size: 17, weight: .light))
                            .foregroundStyle(.black)
                        Spacer()
                        Text(viewModel.category.id == -1 ? "선택 안 함" : viewModel.category.categoryName)
                            .font(.system(size: 14, weight: .ultraLight))
                            .foregroundStyle(Color.black)
                        Spacer()
                            .frame(width: 10)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .light))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                SettingDivider(thickness: 10)
                
                HStack(spacing: 32) {
                    Text("공개 설정")
                        .font(.system(size: 17, weight: .light))
                    Spacer()
                    
                    Button {
                        viewModel.isSecret = false
                        viewModel.isProtected = false
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: (viewModel.isSecret == false && viewModel.isProtected == false)
                                  ? "globe.asia.australia.fill"
                                  : "globe.asia.australia")
                                .font(.system(size: 17, weight: (viewModel.isSecret == false && viewModel.isProtected == false) ? .regular : .light))
                                .foregroundStyle((viewModel.isSecret == false && viewModel.isProtected == false) ? .black : Color.emailCautionTextGray)
                            Spacer()
                                .frame(height: 4)
                            Text("공개")
                                .font(.system(size: 13, weight: (viewModel.isSecret == false && viewModel.isProtected == false) ? .semibold : .light))
                                .foregroundStyle((viewModel.isSecret == false && viewModel.isProtected == false) ? .black : Color.emailCautionTextGray)
                        }
                    }
                    
                    Button {
                        viewModel.isSecret = false
                        viewModel.isProtected = true
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: viewModel.isProtected ? "lock.fill" : "lock")
                                .font(.system(size: 17, weight: viewModel.isProtected ? .regular : .light))
                                .foregroundStyle(viewModel.isProtected ? .black : Color.emailCautionTextGray)
                            Spacer()
                                .frame(height: 4)
                            Text("보호")
                                .font(.system(size: 13, weight: viewModel.isProtected ? .semibold : .light))
                                .foregroundStyle(viewModel.isProtected ? .black : Color.emailCautionTextGray)
                        }
                    }
                    
                    Button {
                        viewModel.isSecret = true
                        viewModel.isProtected = false
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: viewModel.isSecret ? "eye.slash.fill" : "eye.slash")
                                .font(.system(size: 17, weight: viewModel.isSecret ? .regular : .light))
                                .foregroundStyle(viewModel.isSecret ? .black : Color.emailCautionTextGray)
                            Spacer()
                                .frame(height: 4)
                            Text("비공개")
                                .font(.system(size: 13, weight: viewModel.isSecret ? .semibold : .light))
                                .foregroundStyle(viewModel.isSecret ? .black : Color.emailCautionTextGray)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                SettingDivider(thickness: 1)
                
                if viewModel.isSecret == false {
                    if viewModel.isProtected {
                        HStack(spacing: 10) {
                            Text("비밀번호")
                                .font(.system(size: 17, weight: .light))
                                .foregroundStyle(.black)
                            Spacer()
                            Button {
                                viewModel.showPasswordSettingBox = true
                            } label: {
                                Text(viewModel.clippedPassword())
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(Color.articlePasswordGray)
                            }
                            Button {
                                UIPasteboard.general.string = viewModel.articlePassword
                            } label: {
                                Text("복사")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                    }
                    else {
                        Button {
                            viewModel.toggleIsHomeTopicSheetPresent()
                        } label: {
                            HStack {
                                Text("홈주제")
                                    .font(.system(size: 17, weight: .light))
                                    .foregroundStyle(.black)
                                Spacer()
                                Text(viewModel.homeTopic.id == 0 ? "선택 안 함" : viewModel.homeTopic.name)
                                    .font(.system(size: 14, weight: .ultraLight))
                                    .foregroundStyle(Color.black)
                                    .lineLimit(1)
                                Spacer()
                                    .frame(width: 10)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                    }
                    SettingDivider(thickness: 1)
                }
                
                HStack {
                    Text("댓글 허용")
                        .font(.system(size: 17, weight: .light))
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(viewModel.isCommentEnabled ? Color.articleImageTextGray : Color.articleImageBackgroundGray)
                            .frame(width: 30, height: 20)
                        
                        Circle()
                            .fill(viewModel.isCommentEnabled ? .black : .white)
                            .frame(width: 24, height: 24)
                            .offset(x: viewModel.isCommentEnabled ? 15 : -15)
                            .animation(.easeInOut, value: viewModel.isCommentEnabled)
                            .shadow(radius: 3)
                    }
                    .onTapGesture {
                        viewModel.isCommentEnabled.toggle()
                    }
                    .padding(.trailing, 24)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                SettingDivider(thickness: 1)
                
                Spacer()
            }
            .onAppear {
                Task {
                    await viewModel.getCategories()
                }
            }
            
            // MARK: Category Selection Sheet
            ArticleCategorySheet(viewModel: viewModel)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: viewModel.isCategorySheetPresent)
            
            // MARK: HomeTopic Selection Sheet
            ArticleHomeTopicSheet(viewModel: viewModel)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: viewModel.isHomeTopicSheetPresent)
            
            if viewModel.showPasswordSettingBox {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Text("보호글 비밀번호")
                        .font(.system(size: 16, weight: .regular))
                    Spacer()
                        .frame(height: 30)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "lock")
                            .font(.system(size: 16, weight: .light))
                        TextField("", text: $viewModel.articlePasswordText)
                            .font(.system(size: 15, weight: .regular))
                            .frame(width: 120)
                            .autocapitalization(.none)
                        Button {
                            viewModel.clearArticlePasswordTextField()
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.articlePasswordGray)
                        }
                    }
                    Spacer()
                        .frame(height: 5)
                    
                    Rectangle()
                        .foregroundStyle(.black)
                        .frame(width: 176, height: 2)
                    Spacer()
                        .frame(height: 20)
                    
                    Rectangle()
                        .foregroundStyle(Color.dropCautionBoxEdgeGray)
                        .frame(width: 240, height: 1)
                    HStack(spacing: 45) {
                        Button {
                            viewModel.articlePasswordText = viewModel.articlePassword
                            viewModel.showPasswordSettingBox = false
                        } label: {
                            Text("취소")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(.black)
                        }
                        Rectangle()
                            .foregroundStyle(Color.dropCautionBoxEdgeGray)
                            .frame(width: 1, height: 50)
                        Button {
                            viewModel.articlePassword = viewModel.articlePasswordText
                            viewModel.showPasswordSettingBox = false
                        } label: {
                            Text("확인")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(viewModel.articlePasswordText.isEmpty ? .black : .blue)
                                .disabled(viewModel.articlePasswordText.isEmpty)
                        }
                    }
                }
                .padding(.top, 30)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.mainImage, sourceType: .photoLibrary)
        }
        .onAppear {
            viewModel.extractMainImage()
            viewModel.articlePassword = viewModel.generateRandomPassword(length: 8)
            viewModel.articlePasswordText = viewModel.articlePassword
            
            if articleViewModel.editingPost != nil {
                Task {
                    await viewModel.initEditingPost(post: articleViewModel.editingPost!)
                }
            }
        }
    }
}
