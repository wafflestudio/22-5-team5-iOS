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

struct ArticleSettingView: View {
    @State private var viewModel: ArticleSettingViewModel
    @Environment(\.contentViewModel) var contentViewModel

    init(viewModel: ArticleSettingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
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
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .clipped()
                    }
                    else {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.postingImageBackgroundGray)
                                .frame(width: 100, height: 100)
                            VStack(spacing: 0) {
                                Image(systemName: "camera")
                                Spacer()
                                    .frame(height: 3)
                                Text("대표이미지")
                                    .font(.system(size: 12))
                            }
                            .foregroundStyle(Color.postingImageTextGray)
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
                // TODO: 카테고리 선택 시트
            } label: {
                HStack {
                    Text("카테고리")
                        .font(.system(size: 17, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Text(viewModel.category.categoryName)
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
                    // TODO: 공개 버튼
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: "globe.asia.australia.fill")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.black)
                        Spacer()
                            .frame(height: 4)
                        Text("공개")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                }
                
                Button {
                    // TODO: 보호 버튼
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: "lock")
                            .font(.system(size: 17, weight: .light))
                            .foregroundStyle(Color.emailCautionTextGray)
                        Spacer()
                            .frame(height: 4)
                        Text("보호")
                            .font(.system(size: 13, weight: .light))
                            .foregroundStyle(Color.emailCautionTextGray)
                    }
                }
                
                Button {
                    // TODO: 비공개 버튼
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: "eye.slash")
                            .font(.system(size: 17, weight: .light))
                            .foregroundStyle(Color.emailCautionTextGray)
                        Spacer()
                            .frame(height: 4)
                        Text("비공개")
                            .font(.system(size: 13, weight: .light))
                            .foregroundStyle(Color.emailCautionTextGray)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            SettingDivider(thickness: 1)
            
            Button {
                // TODO: 홈주제 선택 시트
            } label: {
                HStack {
                    Text("홈주제")
                        .font(.system(size: 17, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Text(viewModel.homeTopic.id == 0 ? "선택 안 함" : viewModel.homeTopic.name)
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
            SettingDivider(thickness: 1)
            
            HStack {
                Text("댓글 허용")
                    .font(.system(size: 17, weight: .light))
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(viewModel.isCommentEnabled ? Color.postingImageTextGray : Color.postingImageBackgroundGray)
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
        .navigationBarBackButtonHidden()
        .toolbarBackgroundVisibility(.visible)
        .toolbarBackground(Color.white)
        .navigationTitle("발행 설정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButtonLight()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: 발행하고 발행한 아티클로 넘어가는 기능
                } label: {
                    Text("발행")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                        .cornerRadius(40)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 7)
                        .padding(.trailing, 7)
                }
                .background(.black)
                .cornerRadius(40)
                .padding(.trailing, 10)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.mainImage, sourceType: .photoLibrary)
        }
    }
}

extension Color {
    static let postingImageBackgroundGray: Color = .init(red: 233 / 255, green: 233 / 255, blue: 233 / 255)     // 대표 이미지 설정 배경 회색
    static let postingImageTextGray: Color = .init(red: 201 / 255, green: 201 / 255, blue: 201 / 255)     // 대표 이미지 설정 문구 회색
}

#Preview {
    ArticleSettingView(viewModel: ArticleSettingViewModel(title: "???", text: NSAttributedString()))
}
