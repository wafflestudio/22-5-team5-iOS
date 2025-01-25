//
//  SignTypeView.swift
//  Wastory
//
//  Created by mujigae on 1/22/25.
//

import SwiftUI

struct SignTypeView: View {
    //@State private var viewModel = SignTypeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 100)
                    
                    Rectangle()
                        .frame(width: 80, height: 3)
                        .offset(x: 22)
                        .offset(y: 8)
                    Text("wastory")
                        .font(.system(size: 36, weight: .semibold))
                    Spacer()
                        .frame(height: 10)
                    Text("당신의 이야기에 특별함을 더합니다.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.dropCautionBoxTextGray)
                    Spacer()
                        .frame(height: 40)
                    
                    Image("initW")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 250)
                    Spacer()
                    
                    Link(destination: URL(string: "https://wastory.store/api/users/auth/kakao")!, label: {
                        HStack(spacing: 2) {
                            Image("kakao.bubble")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                            Text("카카오톡으로 로그인")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 16)
                        }
                        .frame(maxWidth: .infinity, idealHeight: 51)
                        .background(Color.kakaoYellow)
                        .cornerRadius(6)
                    })
                    .padding(.horizontal, 20)
                    Spacer()
                        .frame(height: 12)
                    NavigationLink(destination: SignInView()) {
                        Text("직접 입력해서 로그인")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity, idealHeight: 51)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.dropCautionBoxEdgeGray)
                            )
                        
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                        .frame(height: 150)
                }
            }
        }
        .onOpenURL { url in
            Task {
                print(url)
                await DeepLinkHandler.shared.authHandler(url: url)
            }
        }
    }
}
