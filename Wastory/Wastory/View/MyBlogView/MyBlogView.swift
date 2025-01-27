//
//  MyBlogView.swift
//  Wastory
//
//  Created by 중워니 on 1/27/25.
//

import SwiftUI
//
//struct MyBlogView: View {
//    @Bindable var mainTabViewModel: MainTabViewModel
//    @Environment(\.contentViewModel) var contentViewModel
//    
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            BlogView(blogID: UserInfoRepository.shared.getBlogID())
////                .toolbarVisibility(.hidden, for: .navigationBar)
//        }
//        .toolbar{
//            ToolbarItem(placement: .navigationBarTrailing) {
//                HStack(spacing: 20) {
//                    contentViewModel.navigateToSearchViewButton(blogID: UserInfoRepository.shared.getBlogID()) {
//                        Text(Image(systemName: "magnifyingglass"))
//                            .foregroundStyle(Color.black)
//                    }
//                    
//                    Button {
//                        mainTabViewModel.toggleIsBlogSheetPresent()
//                    } label: {
//                        ZStack {
//                            Circle()
//                                .fill(Color.mainWBackgroundGray)
//                                .frame(width: 32, height: 32)
//                            VStack(spacing: 2) {
//                                HStack(spacing: 4) {
//                                    MainWCircleUnit()
//                                    MainWCircleUnit()
//                                    MainWCircleUnit()
//                                }
//                                HStack(spacing: 4) {
//                                    MainWCircleUnit()
//                                    MainWCircleUnit()
//                                    MainWCircleUnit()
//                                }
//                                HStack(spacing: 4) {
//                                    MainWCircleUnit()
//                                    MainWCircleUnit()
//                                }
//                            }
//                        }
//                    }
//                    
//                }
//            }
//        }
//        .toolbarVisibility(.visible, for: .navigationBar)
//    }
//        
//}
