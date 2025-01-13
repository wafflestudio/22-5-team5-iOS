//
//  LoadingView.swift
//  Wastory
//
//  Created by mujigae on 12/26/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack() {
            Color.loadingCoralRed
                .ignoresSafeArea()
            
            VStack(spacing: 6) {
                HStack(spacing: 12) {
                    LoadingCircleUnit()
                    LoadingCircleUnit()
                    LoadingCircleUnit()
                }
                HStack(spacing: 12) {
                    LoadingCircleUnit()
                    LoadingCircleUnit()
                    LoadingCircleUnit()
                }
                HStack(spacing: 12) {
                    LoadingCircleUnit()
                    LoadingCircleUnit()
                }
                Spacer()
                    .frame(height: 1)
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 5)
            }
            
            VStack {
                Spacer()
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 2)
                    .offset(x: 12)
                Spacer()
                    .frame(height: 0)
                Text("wastory")
                    .foregroundStyle(.white)
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.bottom, 30)
            }
        }
    }
}

struct LoadingCircleUnit: View {
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 10, height: 10)
    }
}


#Preview {
    LoadingView()
}
