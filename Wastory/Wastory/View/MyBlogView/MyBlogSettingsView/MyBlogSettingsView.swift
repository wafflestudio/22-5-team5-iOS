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
                    Image(systemName: "questionmark.text.page.fill")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                    
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
            
            
            
        }
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
