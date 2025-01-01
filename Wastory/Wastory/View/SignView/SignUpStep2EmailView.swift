//
//  SignUpStep2EmailView.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import SwiftUI

struct SignUpStep2EmailView: View {
    @State private var viewModel = SignUpStep2ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    HStack {
                        Rectangle()
                            .foregroundStyle(Color.progressBarBackgroundColor)
                            .frame(width: 60, height: 5)
                            .cornerRadius(12)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    HStack {
                        Rectangle()
                            .foregroundStyle(Color.progressBarProgressColor)
                            .frame(width: 40, height: 5)
                            .cornerRadius(12)
                            .padding(.leading, 20)
                        Spacer()
                    }
                }
                .padding(.top, 20)
                
                HStack {
                    Text(viewModel.isCodeRequired() ? "이메일로 발송된" : "와스토리 계정으로 사용할")
                        .font(.system(size: 18, weight: .regular))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                .padding(.top, 24)
                Spacer()
                    .frame(height: 5)
                HStack {
                    Text(viewModel.isCodeRequired() ? "인증번호를 입력해 주세요." : "이메일을 입력해 주세요.")
                        .font(.system(size: 18, weight: .regular))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 30)
                
                if viewModel.isCodeRequired() {
                    HStack {
                        Text(viewModel.email)
                            .foregroundStyle(Color.promptLabelColor)
                            .padding(.vertical, 5)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                        .frame(height: 5)
                    Rectangle()
                        .foregroundStyle(Color.promptLabelColor)
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                }
                
                ZStack {
                    if viewModel.isCodeRequired() {
                        TextField("", text: $viewModel.code, prompt: Text("인증번호 8자 입력")
                            .foregroundStyle(Color.promptLabelColor))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.clearCodeTextField()
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.promptLabelColor)
                            }
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 24)
                            .disabled(viewModel.isClearCodeButtonInactive())
                            .opacity(viewModel.isClearCodeButtonInactive() ? 0 : 1)
                        }
                    }
                    else {
                        TextField("", text: $viewModel.email, prompt: Text("이메일 입력")
                            .foregroundStyle(Color.promptLabelColor))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.clearEmailTextField()
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.promptLabelColor)
                            }
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 10)
                            .disabled(viewModel.isClearEmailButtonInactive())
                            .opacity(viewModel.isClearEmailButtonInactive() ? 0 : 1)
                            
                            Button {
                                viewModel.requestCode()
                            } label: {
                                Text("인증요청")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.black)
                                    .padding(.vertical, 7)
                                    .padding(.horizontal, 14)
                            }
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.codeRequestButtonGray, lineWidth: 1)
                            )
                            .padding(.trailing, 20)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 5)
                
                Rectangle()
                    .foregroundStyle(.black)
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 24)
                
                if viewModel.isCodeRequired() == false {
                    SignUpStep2CautionText(text: "입력한 이메일로 인증번호가 발송됩니다.")
                    SignUpStep2CautionText(text: "인증메일을 받을 수 있도록 자주 쓰는 이메일을 입력해 주세요.")
                    Spacer()
                        .frame(height: 24)
                }
                
                NavigationLink(destination: EmptyView()) {
                    Text("다음")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, idealHeight: 51)
                        .background(viewModel.isCodeEntered() ? Color.kakaoYellow : Color.disabledNextButtonGray)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 20)
                .disabled(viewModel.isCodeEntered() == false)
                
                Spacer()
            }
        }
    }
}

struct SignUpStep2CautionText: View {
    let text: String
    var body: some View {
        HStack(spacing: 7) {
            Circle()
                .frame(width: 2, height: 2)
            Text(text)
                .font(.system(size: 11, weight: .light))
            Spacer()
        }
        .foregroundStyle(Color.emailCautionTextGray)
        .padding(.horizontal, 20)
    }
}

extension Color {
    static let codeRequestButtonGray: Color = .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)  // 인증 요청 버튼 테두리 색상
    static let disabledNextButtonGray: Color = .init(red: 240 / 255, green: 240 / 255, blue: 240 / 255)  // 다음 버튼 이용 불가능 색상
    static let emailCautionTextGray: Color = .init(red: 153 / 255, green: 153 / 255, blue: 153 / 255)  // 다음 버튼 이용 불가능 색상
}

#Preview {
    SignUpStep2EmailView()
}
