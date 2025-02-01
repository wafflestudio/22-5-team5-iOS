//
//  PolicyView.swift
//  Wastory
//
//  Created by mujigae on 2/1/25.
//

import SwiftUI

struct PolicyView: View {
    @State private var viewModel = PolicyViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                CustomBackButton(size: 24, weight: .regular)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            ScrollView() {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 30)
                    HStack {
                        Text("Policy")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 10)
                    HStack {
                        Text("와스토리와 회원과의 약속입니다.")
                            .font(.system(size: 24, weight: .light))
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 5)
                    HStack {
                        Text("꼭 읽어주세요.")
                            .font(.system(size: 24, weight: .light))
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 30)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.black)
                    Spacer()
                        .frame(height: 30)
                    
                    HStack {
                        Text("운영정책")
                            .font(.system(size: 16, weight: .light))
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 10)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("본 운영정책은 team5(이하 \"회사\"라 합니다)가 와스토리 서비스(이하 \"서비스\")를 운영함에 있어, 서비스 내에 발생할 수 있는 문제 상황에 대하여 일관성 있게 대처하기 위하여 서비스 운영의 기준과 회원 여러분이 지켜주셔야 할 세부적인 사항이 규정되어 있습니다. 본 운영정책을 지키지 않을 경우 불이익을 당할 수 있으니 주의 깊게 읽어 주시기 바랍니다.")
                                .font(.system(size: 13, weight: .ultraLight))
                                .foregroundStyle(Color.black)
                                .lineSpacing(3)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 16)
                        
                        HStack {
                            Text("회사는 서비스와 관련하여 합리적인 운영정책을 세울 수 있도록 노력하고 있으며, 본 운영정책의 변경이 있을 경우 7일 전에 서비스 내에 공지하도록 하겠습니다.")
                                .font(.system(size: 13, weight: .ultraLight))
                                .foregroundStyle(Color.black)
                                .lineSpacing(3)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 16)
                        
                        HStack {
                            Text("서비스 이용과 관련하여 본 운영정책에 명시되지 않은 내용은 카카오 통합서비스약관 및 운영정책, 카카오 유료서비스 이용약관에서 정한 바에 따릅니다.")
                                .font(.system(size: 13, weight: .ultraLight))
                                .foregroundStyle(Color.black)
                                .lineSpacing(3)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 16)
                        
                        VStack(spacing: 24) {
                            ForEach(viewModel.policies) { policy in
                                PolicyCell(viewModel: $viewModel, policy: policy)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(
                        Rectangle()
                            .stroke(Color.emailCautionTextGray, lineWidth: 0.5)
                    )
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 30)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct PolicyCell: View {
    @Binding var viewModel: PolicyViewModel
    let policy: Policy
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(policy.title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.black)
                Spacer()
            }
            Spacer()
                .frame(height: 10)
            VStack(spacing: 10) {
                ForEach(policy.terms.indices, id: \.self) { index in
                    HStack(alignment: .top, spacing: 5) {
                        viewModel.indexSymbols[index]
                            .font(.system(size: 11, weight: .ultraLight))
                            .padding(.top, 1)       // Symbol 위치 조정
                        Text(policy.terms[index])
                            .font(.system(size: 13, weight: .ultraLight))
                            .foregroundStyle(Color.black)
                            .lineSpacing(3)
                        Spacer()
                    }
                }
            }
        }
    }
}
