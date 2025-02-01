//
//  ContactView.swift
//  Wastory
//
//  Created by mujigae on 1/31/25.
//

import SwiftUI

struct ContactView: View {
    @State private var viewModel = ContactViewModel()
    
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
                .frame(height: 30)
            
            HStack(spacing: 12) {
                Text("waffle studio team5가 열심히 준비 중입니다.")
                    .font(.system(size: 17, weight: .regular))
                Spacer()
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}
