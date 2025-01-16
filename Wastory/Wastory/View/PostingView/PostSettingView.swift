//
//  PostSettingView.swift
//  Wastory
//
//  Created by mujigae on 1/16/25.
//

import SwiftUI
import RichTextKit

struct PostSettingView: View {
    @State private var viewModel = PostSettingViewModel()
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack {
            
        }
        .navigationBarBackButtonHidden()
        .toolbarBackgroundVisibility(.visible)
        .toolbarBackground(Color.white)
        .navigationTitle("발행 설정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButtonLight()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: 발행하고 발행한 아티클로 넘어가능 기능
                } label: {
                    Text("발행")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                        .cornerRadius(40)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 7)
                        .padding(.trailing, 7)
                }
                .background(.black)
                .cornerRadius(40)
                .padding(.trailing, 20)
            }
        }
    }
}
