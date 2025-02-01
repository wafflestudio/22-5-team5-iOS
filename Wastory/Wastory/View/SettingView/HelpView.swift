//
//  HelpView.swift
//  Wastory
//
//  Created by mujigae on 1/31/25.
//

import SwiftUI

struct HelpView: View {
    @State private var viewModel = HelpViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                CustomBackButton(size: 24, weight: .regular)
                Text("wastory 고객센터")
                    .font(.system(size: 17, weight: .regular))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 10)
            SettingDivider(thickness: 1)
            Spacer()
                .frame(height: 16)
            
            HStack(spacing: 8) {
                Text("와스토리")
                    .font(.system(size: 26, weight: .semibold))
                Image("myW.logo")
                    .scaledToFill()
                    .frame(width: 26, height: 26)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.emailCautionTextGray, lineWidth: 0.5)
                    )
                Spacer()
            }
            .padding(.horizontal, 20)
            Spacer()
                .frame(height: 5)
            HStack {
                Text("무엇을 도와드릴까요?")
                    .font(.system(size: 26, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal, 20)
            Spacer()
                .frame(height: 20)
            
            HStack {
                TextField("궁금하신 점을 검색해 보세요.", text: $viewModel.searchText)
                    .autocapitalization(.none)
                Button {
                    viewModel.isSearched = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .thin))
                        .foregroundStyle(.black)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.black, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            SettingDivider(thickness: 10)
            Spacer()
                .frame(height: 20)
            
            if viewModel.isSearched {
                HStack {
                    Text("당신은 현재 정글에 오셨습니다.")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                Spacer()
                    .frame(height: 5)
                HStack(spacing: 0) {
                    Text("미")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.red)
                    Text("지")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.orange)
                    Text("의 ")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.yellow)
                    Text("세")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.green)
                    Text("계")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.skyBlue)
                    Text("를 ")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.blue)
                    Text("탐")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.navyBlue)
                    Text("험")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.purple)
                    Text("하는 마음으로")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                    Spacer()
                }
                .padding(.horizontal, 20)
                Spacer()
                    .frame(height: 5)
                HStack {
                    Spacer()
                    Text("다양한 기능들을 알아가 봅시다!")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                }
                .padding(.horizontal, 20)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}
