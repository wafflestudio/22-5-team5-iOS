//
//  BlogSheet.swift
//  Wastory
//
//  Created by mujigae on 1/18/25.
//

import SwiftUI

struct BlogSheet: View {
    @Bindable var mainTabViewModel: MainTabViewModel
    
    var body: some View {
        ZStack {
            //MARK: Background Dimming
            (mainTabViewModel.isBlogSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
                .onTapGesture {
                    mainTabViewModel.toggleIsBlogSheetPresent()
                }
            
            //MARK: NotificationTypeSheet List
            VStack {
                Spacer()
                if mainTabViewModel.isBlogSheetPresent {
                    ZStack {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: 30)
                            
                            HStack {
                                Image(systemName: "questionmark.text.page.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .padding(.leading, 20)
                                Spacer()
                                    .frame(width: 20)
                                //Text(UserInfoRepository.shared.getUserName())
                                Text(UserInfoRepository.shared.getBlogName())   // 아직 username API가 없어 임시로 대체
                                    .font(.system(size: 17, weight: .semibold))
                                Spacer()
                                Button {
                                    // TODO: 설정 화면 진입 버튼
                                } label: {
                                    Image(systemName: "gearshape")
                                        .font(.system(size: 26))
                                        .foregroundStyle(Color.settingGearGray)
                                }
                                .padding(.trailing, 20)
                            }
                            Spacer()
                                .frame(height: 20)
                            
                            Divider()
                                .foregroundStyle(Color.secondaryLabelColor)
                            Spacer()
                                .frame(height: 20)
                            
                            HStack {
                                Image(systemName: "questionmark.text.page.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12)
                                    )
                                    .padding(.leading, 25)
                                Spacer()
                                    .frame(width: 20)
                                Text(UserInfoRepository.shared.getBlogName())
                                    .font(.system(size: 15, weight: .regular))
                                Spacer()
                            }
                            
                            Spacer()
                                .frame(height: 50)
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                        
                    }
                    .background(Color.clear)
                    .transition(.move(edge: .bottom)) // 아래에서 올라오는 애니메이션
                    .animation(.easeInOut, value: mainTabViewModel.isBlogSheetPresent)
                }
            }
        }
        .ignoresSafeArea()
    }
}

extension Color {
    static let settingGearGray: Color = .init(red: 77 / 255, green: 77 / 255, blue: 77 / 255)  // 블로그 시트 세팅 버튼 회색
}
