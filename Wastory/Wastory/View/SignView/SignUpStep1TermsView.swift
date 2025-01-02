//
//  SignUpStep1TermsView.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import SwiftUI

struct SignUpStep1TermsView: View {
    @State private var viewModel = SignUpStep1ViewModel()
    
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
                            .frame(width: 20, height: 5)
                            .cornerRadius(12)
                            .padding(.leading, 20)
                        Spacer()
                    }
                }
                .padding(.top, 20)
                
                HStack {
                    Text("와스토리 계정")
                        .font(.system(size: 18, weight: .regular))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                .padding(.top, 24)
                Spacer()
                    .frame(height: 5)
                HStack {
                    Text("서비스 약관에 동의해 주세요.")
                        .font(.system(size: 18, weight: .regular))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 24)
                
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: viewModel.isEntireTermAgreed() ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(
                            viewModel.isEntireTermAgreed() ? .black : Color.promptLabelColor,
                            viewModel.isEntireTermAgreed() ? Color.kakaoYellow : Color.promptLabelColor
                        )
                        .padding(.leading, 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("모두 동의합니다.")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("전체 동의는 필수 및 선택정보에 대한 동의도 포함되어 있으며, 개별적으로도 동의를 선택하실 수 있습니다.")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundStyle(Color.promptLabelColor)
                                .lineSpacing(3)
                            Text("선택항목에 대한 동의를 거부하시는 경우에도 서비스는 이용이 가능합니다.")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundStyle(Color.promptLabelColor)
                                .lineSpacing(3)
                        }
                    }
                    .padding(.trailing, 20)
                    
                    Spacer()
                }
                .onTapGesture {
                    viewModel.toggleEntireAgreement()
                }
                
                Spacer()
                    .frame(height: 24)
                Divider()
                    .padding(.leading, 48)
                    .padding(.trailing, 20)
                Spacer()
                    .frame(height: 24)
                
                VStack(spacing: 12) {
                    ForEach(viewModel.getTerms()) { cell in
                        TermCell(item: cell, term: viewModel.getTerm(item: cell))
                            .onTapGesture {
                                viewModel.toggleItemAgreement(item: cell)
                            }
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
                NavigationLink(destination: SignUpStep2EmailView()) {
                    Text("동의")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(viewModel.areAllRequiredTermsAgreed() ? .black : Color.incompleteAgreementTextColor)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity, idealHeight: 51)
                        .background(viewModel.areAllRequiredTermsAgreed() ? Color.kakaoYellow : Color.incompleteAgreementBoxColor)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 20)
                .disabled(viewModel.areAllRequiredTermsAgreed() == false)
                
                Spacer()
            }
        }
    }
}
