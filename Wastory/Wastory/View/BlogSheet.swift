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
            // MARK: Background Dimming
            (mainTabViewModel.isBlogSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
                .onTapGesture {
                    mainTabViewModel.toggleIsBlogSheetPresent()
                }

            VStack {
                Spacer()
                if mainTabViewModel.isBlogSheetPresent {
                    ZStack {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: 30)
                            
                            HStack {
                                KFImageWithDefaultIcon(imageURL: UserInfoRepository.shared.getBlogMainImageURL())
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .padding(.leading, 20)
                                Spacer()
                                    .frame(width: 20)
                                Text(UserInfoRepository.shared.getUsername())
                                    .font(.system(size: 17, weight: .semibold))
                                Spacer()
                                
                                NavigationLink(destination: SettingView()) {
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
                                KFImageWithDefaultIcon(imageURL: UserInfoRepository.shared.getBlogMainImageURL())
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
