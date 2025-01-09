//
//  SignUpStep5UsernameView.swift
//  Wastory
//
//  Created by mujigae on 12/27/24.
//

import SwiftUI

struct SignUpStep5UsernameView: View {
    @State private var viewModel = SignUpStep5ViewModel()
    @FocusState private var isAddressFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isAddressFocused = false
                    }
                
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
                        HStack(spacing: 0) {
                            Text("wastory.store/api/blogs/")
                                .foregroundStyle(Color.promptLabelColor)
                                .padding(.leading, 20)
                            TextField("", text: $viewModel.addressName)
                                .focused($isAddressFocused)
                                .padding(.vertical, 5)
                                .padding(.trailing, 50)
                                .autocapitalization(.none)
                                .onChange(of: viewModel.addressName) { newValue, oldValue in
                                    viewModel.setBlogAddress()
                                    viewModel.checkAddressNameAvailability()
                                }
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
                        Text(viewModel.addressNameAvailability)
                            .padding(.leading, 20)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(viewModel.addressNameAvailability.last == "." ? Color.disableUsernameRed : Color.ableUsernameGray)
                        Spacer()
                        Text(String(viewModel.addressName.count) + " / 20")
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
                            .background(viewModel.addressNameAvailability.last == "." ? Color.disableButtonGray : .black)
                            .cornerRadius(6)
                    }
                    .padding(.horizontal, 20)
                    .disabled(viewModel.addressNameAvailability.last == ".")
                    
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
}

#Preview {
    SignUpStep5UsernameView()
}

// wastory.store/api/blogs/
