//
//  SignUpStep2EmailView.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import SwiftUI

struct SignUpStep2EmailView: View {
    @State private var viewModel = SignUpStep2ViewModel()
    @State private var showRerequestEmailBox = false
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isCodeFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isEmailFocused = false
                        isCodeFocused = false
                    }
                
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
                            .focused($isCodeFocused)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                            .autocapitalization(.none)
                            .onChange(of: viewModel.code) { newValue, oldValue in
                                if oldValue.count >= 8 {
                                    viewModel.code = String(viewModel.code.prefix(8))
                                }
                                viewModel.checkCodeValidty(oldValue)
                            }
                            
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
                            .focused($isEmailFocused)
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
                        .foregroundStyle(viewModel.isEmptyEmailRequested() || viewModel.isInvalidEmailRequested() || viewModel.isEmptyCodeEntered() || viewModel.isInvalidCodeEntered() ? Color.emptyEmailWarnRed : .black)
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                    
                    if viewModel.isEmptyEmailRequested() || viewModel.isInvalidEmailRequested() || viewModel.isEmptyCodeEntered() || viewModel.isInvalidCodeEntered() {
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            Text(viewModel.isEmptyEmailRequested() ? "와스토리 계정 이메일을 입력해 주세요." : viewModel.isInvalidEmailRequested() ?  "와스토리 계정 이메일 형식이 올바르지 않습니다." : viewModel.isEmptyCodeEntered() ? "이메일로 발송된 인증번호를 입력해 주세요." : "인증번호 형식이 올바르지 않습니다.")
                                .font(.system(size: 11, weight: .light))
                                .foregroundStyle(Color.emptyEmailWarnRed)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                        .frame(height: 24)
                    
                    if viewModel.isCodeRequired() == false {
                        SignUpStep2CautionText(text: "입력한 이메일로 인증번호가 발송됩니다.")
                        SignUpStep2CautionText(text: "인증메일을 받을 수 있도록 자주 쓰는 이메일을 입력해 주세요.")
                        Spacer()
                            .frame(height: 24)
                    }
                    else {
                        Button {
                            showRerequestEmailBox = true
                        } label: {
                            HStack {
                                Text("인증메일을 받지 못하셨나요?")
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundStyle(.black)
                                    .underline()
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                            .frame(height: 24)
                    }
                    
                    ZStack {
                        NavigationLink(destination: SignUpStep3PasswordView()) {
                            Text("다음")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 51)
                                .background(Color.kakaoYellow)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 20)
                        .disabled(!viewModel.isVerificationSuccessful())
                        .opacity(viewModel.isVerificationSuccessful() ? 1 : 0)
                        
                        Button {
                            if viewModel.isVerificationSuccessful() {
                                UserInfoRepository.shared.setUserID(userID: viewModel.email)    // UserID (email) 결정
                            }
                        } label: {
                            Text("다음")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 51)
                                .background(viewModel.code.isEmpty || viewModel.isInvalidCodeEntered() ? Color.disabledNextButtonGray : Color.kakaoYellow)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 20)
                        .opacity(viewModel.isVerificationSuccessful() ? 0 : 1)
                    }
                    
                    Spacer()
                }
                
                if showRerequestEmailBox {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            // 편의 기능: 버튼 대신 배경을 터치하여도 박스 닫힘
                            showRerequestEmailBox = false
                        }
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 300)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("인증메일을 받지 못하셨나요?")
                                .font(.system(size: 15, weight: .semibold))
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        HStack {
                            Text("이메일이 정확한지 확인해 주세요.")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.emailCautionTextGray)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        HStack {
                            Text("메일 서비스에 따라 인증번호 발송이 늦어질 수 있습니다.")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.emailCautionTextGray)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        
                        Button {
                            viewModel.requestEmailReentry()
                            showRerequestEmailBox = false
                        } label: {
                            HStack {
                                Text("다른 이메일로 인증")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.black)
                                    .underline()
                                Spacer()
                            }
                            .padding(.horizontal, 40)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                            .frame(height: 2)
                        
                        Button {
                            showRerequestEmailBox = false
                        } label: {
                            Text("인증번호 재발송")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 45)
                                .background(Color.kakaoYellow)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 40)
                        Button {
                            showRerequestEmailBox = false
                        } label: {
                            Text("확인")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, idealHeight: 45)
                                .background(Color.disabledNextButtonGray)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 40)
                    }
                }
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
                .font(.system(size: 10, weight: .light))
            Spacer()
        }
        .foregroundStyle(Color.emailCautionTextGray)
        .padding(.horizontal, 20)
    }
}

extension Color {
    static let codeRequestButtonGray: Color = .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)  // 인증 요청 버튼 테두리 색상
    static let disabledNextButtonGray: Color = .init(red: 240 / 255, green: 240 / 255, blue: 240 / 255)  // 다음 버튼 이용 불가능 색상
    static let emailCautionTextGray: Color = .init(red: 153 / 255, green: 153 / 255, blue: 153 / 255)  // 이메일 입력 주의사항 색상
    static let emptyEmailWarnRed: Color = .init(red: 208 / 255, green: 104 / 255, blue: 79 / 255)  // 이메일 미입력 경고 색상
}
