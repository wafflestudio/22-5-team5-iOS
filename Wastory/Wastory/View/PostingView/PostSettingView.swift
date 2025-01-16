//
//  PostSettingView.swift
//  Wastory
//
//  Created by mujigae on 1/16/25.
//

import SwiftUI
import RichTextKit
import PhotosUI

import Foundation

struct PostSettingView: View {
    @State private var viewModel: PostSettingViewModel
    @Environment(\.contentViewModel) var contentViewModel
    
    init(viewModel: PostSettingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 30)
            HStack(alignment: .top) {
                Text(viewModel.getTitle())
                    .font(.system(size: 16))
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
                                .frame(width: 100, height: 100)
                                .background(.black)
                            VStack(spacing: 0) {
                                Image(systemName: "camera")
                                Spacer()
                                    .frame(height: 3)
                                Text("대표이미지")
                                    .font(.system(size: 12))
                            }
                            .foregroundStyle(.gray)
                            .padding(30)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
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
                .padding(.trailing, 20)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.mainImage, sourceType: .photoLibrary)
        }
    }
}

#Preview {
    PostSettingView(viewModel: PostSettingViewModel(title: "???", text: NSAttributedString()))
}
