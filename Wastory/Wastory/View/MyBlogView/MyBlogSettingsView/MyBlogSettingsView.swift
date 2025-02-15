//
//  MyBlogSettingsView.swift
//  Wastory
//
//  Created by 중워니 on 1/23/25.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct MyBlogSettingsView: View {
    
    @State private var viewModel = MyBlogSettingsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isBlogNameFocused: Bool
    @FocusState private var isBlogDescriptionFocused: Bool
    @FocusState private var isUserNameFocused: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    isBlogNameFocused = false
                    isBlogDescriptionFocused = false
                    isUserNameFocused = false
                }
            
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
                            KFImageWithDefault(imageURL: viewModel.blogMainImageURL)
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
                        .foregroundStyle(viewModel.isBlogNameValid ? (isBlogNameFocused ? Color.primaryLabelColor : Color.secondaryLabelColor) : Color.loadingCoralRed)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    TextField("", text: $viewModel.blogName)
                        .font(.system(size: 16, weight: .thin))
                        .focused($isBlogNameFocused)
                        .foregroundStyle(Color.primaryLabelColor)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(viewModel.isBlogNameValid ? (isBlogNameFocused ? Color.primaryLabelColor : Color.secondaryLabelColor) : Color.loadingCoralRed)
                    
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
                        .foregroundStyle(isBlogDescriptionFocused ? Color.primaryLabelColor : Color.secondaryLabelColor)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    TextField("", text: $viewModel.blogDescription)
                        .font(.system(size: 16, weight: .thin))
                        .focused($isBlogDescriptionFocused)
                        .foregroundStyle(Color.primaryLabelColor)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(isBlogDescriptionFocused ? Color.primaryLabelColor : Color.secondaryLabelColor)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    HStack {
                        Spacer()
                        
                        Text("\(viewModel.blogDescription.count) / 255")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("블로그 닉네임")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(viewModel.isUsernameValid ? (isUserNameFocused ? Color.primaryLabelColor : Color.secondaryLabelColor) : Color.loadingCoralRed)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    TextField("", text: $viewModel.username)
                        .font(.system(size: 16, weight: .thin))
                        .focused($isUserNameFocused)
                        .foregroundStyle(Color.primaryLabelColor)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(viewModel.isUsernameValid ? (isUserNameFocused ? Color.primaryLabelColor : Color.secondaryLabelColor) : Color.loadingCoralRed)
                    
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
            }//VStack
            .padding(.horizontal, 20)
        }//ZStack
        // MARK: Network
        .onAppear {
            Task {
                await viewModel.getInitialData()
                await viewModel.deletePreviousImage() //MARK: 나중에 지워야함 디버깅용
            }
        }
        // MARK: NavBar
        .navigationTitle("블로그 설정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await viewModel.postImage()
                        Task {
                            await viewModel.patchBlog()
                            await viewModel.patchUser()
                            dismiss()
                        }
                    }
                }) {
                    Text("완료")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(viewModel.isSubmitValid ? Color.primaryLabelColor : Color.backgourndSpaceColor)
                        .frame(width: 60, height: 35)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .foregroundStyle(viewModel.isSubmitValid ? Color.secondaryLabelColor : Color.backgourndSpaceColor)
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
