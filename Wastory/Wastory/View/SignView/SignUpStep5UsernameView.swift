//
//  SignUpStep5UsernameView.swift
//  Wastory
//
//  Created by mujigae on 12/27/24.
//

import SwiftUI

struct SignUpStep5UsernameView: View {
    @State private var viewModel = SignUpStep5ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Text("와스토리")
                            .font(.system(size: 32, weight: .bold))
                            .padding(.leading, 20)
                        Spacer()
                    }
                    HStack {
                        Text("가입을 환영합니다.")
                            .font(.system(size: 32, weight: .regular))
                            .padding(.leading, 20)
                        Spacer()
                    }
                }
                .padding(.top, 40)
                
                Spacer()
                    .frame(height: 32)
                
                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        Text("\(UserInfoRepository.shared.getUserID())")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.leading, 20)
                        Text("님,")
                            .font(.system(size: 14, weight: .light))
                        Spacer()
                    }
                    HStack {
                        Text("사용하실 블로그 주소를 완성해 주세요.")
                            .font(.system(size: 14, weight: .light))
                            .padding(.leading, 20)
                        Spacer()
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                
                ZStack {
                    TextField("", text: $viewModel.blogAddress)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .foregroundStyle(Color.promptLabelColor)
                    
                    TextField("", text: $viewModel.username)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .onChange(of: viewModel.username) { newValue, oldValue in
                            viewModel.setBlogAddress()
                            viewModel.checkUsernameAvailability()
                        }
                    
                    HStack {
                        Spacer()
                        Button {
                            viewModel.clearIdTextField()
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .font(.system(size: 15))
                                .foregroundStyle(Color.lightClearButtonColor)
                        }
                        .frame(width: 10, height: 10)
                        .padding(.trailing, 30)
                        .disabled(viewModel.isClearButtonInactive())
                        .opacity(viewModel.isClearButtonInactive() ? 0 : 1)
                    }
                }
                
                Spacer()
                    .frame(height: 8)
                
                Rectangle()
                    .foregroundStyle(.black)
                    .frame(height: 2)
                    .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 8)
                
                HStack {
                    Text(viewModel.usernameAvailability)
                        .padding(.leading, 20)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(viewModel.usernameAvailability.last == "." ? Color.disableUsernameRed : Color.ableUsernameGray)
                    Spacer()
                    Text(String(viewModel.username.count) + " / 32")
                        .padding(.trailing, 20)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.promptLabelColor)
                        .opacity(viewModel.isClearButtonInactive() ? 0 : 1)
                }
                
                Spacer()
                    .frame(height: 120)
                
                Button {
                    viewModel.setUsername()
                    viewModel.setUserInfo()
                } label: {
                    Text("확인")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, idealHeight: 51)
                        .background(viewModel.usernameAvailability.last == "." ? Color.disableButtonGray : .black)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 20)
                .disabled(viewModel.usernameAvailability.last == ".")
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
    }
}

