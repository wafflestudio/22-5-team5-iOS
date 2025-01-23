//
//  MyBlogSettingsView.swift
//  Wastory
//
//  Created by 중워니 on 1/23/25.
//

import SwiftUI
import PhotosUI

struct MyBlogSettingsView: View {
    
    @State private var viewModel = MyBlogSettingsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 30)
            
            // Blog Main Image
            HStack {
                Spacer()
                
                ZStack(alignment: .bottomTrailing) {
                    
                    if let _ = viewModel.mainImage {
                        Image(uiImage: viewModel.mainImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                    } else {
                        Image("defaultImage")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                    }
                        
                    
                    Button(action: {
                        viewModel.toggleImagePickerPresented()
                    }) {
                        Image(systemName: "camera")
                            .font(.system(size: 14, weight: .light))
                            .frame(width: 35, height: 35)
                            .foregroundStyle(Color.primaryLabelColor)
                            .background(
                                Circle()
                                    .foregroundStyle(Color.white)
                                    .frame(width: 35, height: 35)
                                )
                            .overlay(
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundStyle(Color.secondaryLabelColor)
                                    .frame(width: 35, height: 35)
                                )
                    }
                }
                
                Spacer()
                
            }
            
            Spacer()
                .frame(height: 30)
            
            // BlogName, Description, UserName
            VStack(alignment: .leading, spacing: 0) {
                Text("블로그 이름")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                    .frame(height: 10)
                
                TextField("", text: $viewModel.blogName)
                    .font(.system(size: 16, weight: .thin))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                    .frame(height: 5)
                
                Rectangle()
                    .foregroundStyle(Color.primaryLabelColor)
                    .frame(height: 1)
                
                Spacer()
                    .frame(height: 5)
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.blogName.count) / 40")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(viewModel.isBlogNameValid ? Color.secondaryLabelColor : Color.loadingCoralRed)
                }
            }
            
            Spacer()
                .frame(height: 30)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("블로그 설명")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                    .frame(height: 10)
                
                TextField("", text: $viewModel.blogDescription)
                    .font(.system(size: 16, weight: .thin))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                    .frame(height: 5)
                
                Rectangle()
                    .foregroundStyle(Color.primaryLabelColor)
                    .frame(height: 1)
                
                Spacer()
                    .frame(height: 5)
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.blogDescription.count) / 255")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(viewModel.isBlogDescriptionValid ? Color.secondaryLabelColor : Color.loadingCoralRed)
                }
            }
            
            Spacer()
                .frame(height: 30)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("블로그 닉네임")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                    .frame(height: 10)
                
                TextField("", text: $viewModel.username)
                    .font(.system(size: 16, weight: .thin))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                    .frame(height: 5)
                
                Rectangle()
                    .foregroundStyle(Color.primaryLabelColor)
                    .frame(height: 1)
                
                Spacer()
                    .frame(height: 5)
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.username.count) / 32")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(viewModel.isUsernameValid ? Color.secondaryLabelColor : Color.loadingCoralRed)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        // MARK: Network
        .onAppear {
            Task {
                await viewModel.getInitialData()
            }
        }
        // MARK: NavBar
        .navigationTitle("블로그 설정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //patch 내용
                }) {
                    Text("완료")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .frame(width: 60, height: 35)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .foregroundStyle(Color.secondaryLabelColor)
                        )
                }
                .disabled(!viewModel.isSubmitValid)
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
            
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
        .fullScreenCover(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.mainImage, sourceType: .photoLibrary)
        }
    }
}

#Preview {
    MyBlogSettingsView()
}
