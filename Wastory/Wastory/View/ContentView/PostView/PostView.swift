//
//  PostView.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI

struct PostView: View {
    let post: Post
    @State private var viewModel = PostViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    
    @State var isLiked: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Color.white
                        .frame(height: 500)
                        .padding(.top, -500)
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                            .frame(height: 100)
                        
                        // MARK: 카테고리 버튼
                        contentViewModel.navigateToBlogViewButton(tempBlog()) {
                            Text("카테고리 없음")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.primaryLabelColor)
                                .background(
                                    VStack(spacing: 0) {
                                        Spacer()
                                        
                                        Rectangle()
                                            .fill(Color.middleDotColor)
                                            .frame(height: 6)
                                            .padding(.top, -8)
                                        
                                    }
                                )
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // MARK: Title
                        Text("제목을 그냥 대충 길게 무한히 길게 아무렇게나 길게 몇 줄이든 상관없이!")
                            .font(.system(size: 34, weight: .medium))
                            .foregroundStyle(Color.primaryLabelColor)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // MARK: 블로그 이름 . 작성일자
                        HStack(spacing: 5) {
                            Text("블로그 이름")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(Color.secondaryLabelColor)
                            
                            Image(systemName: "circle.fill")
                                .font(.system(size: 3, weight: .regular))
                                .foregroundStyle(Color.middleDotColor)
                            
                            Text("2025. 1. 10. 00:05")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.secondaryLabelColor)
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer()
                            .frame(height: 60)
                        
                        // MARK: Content
                        Text("대\n충\n긴\n내\n용\n과\n사\n진\n과\n동\n영\n상\n과\n글\n들")
                            .font(.system(size: 20, weight: .light))
                            .foregroundStyle(Color.primaryLabelColor)
                            .padding(.horizontal, 20)
                        
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Divider()
                            .foregroundStyle(Color.secondaryLabelColor)
                    }
                    .background(Color.white)
                    // TODO: 태그 버튼 추가하기
                    
                    
                    
                    
                    //Blog 세부설명 및 구독버튼
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading, spacing: 0) {
                            contentViewModel.navigateToBlogViewButton(tempBlog()) {
                                Text("제목제목제목제목제목제목제목제목제목제목제목제목제목제목")
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                                .frame(height: 5)
                            
                            contentViewModel.navigateToBlogViewButton(tempBlog()) {
                                Text("설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            Spacer()
                                .frame(height: 15)
                            
                            Button(action: {
                                //구독추가
                            }) {
                                Text("구독하기 +") // 구독중 V
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .frame(width: 87, height: 35)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundStyle(Color.primaryLabelColor) //secondaryLabelColor
                                    )
                            }
                        }
                        .padding(.leading, 20)
                        
                        contentViewModel.navigateToBlogViewButton(tempBlog()) {
                            Image(systemName: "questionmark.text.page.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                                .frame(width: 60, height: 60)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                                .padding(.trailing, 20)
                        }
                    } // HStack
                    .padding(.top, 25)
                    .padding(.bottom, 30)
                    .background(Color.blogDetailBackgroundColor)
                    
                    
                    CategoryPostListView()
                    
                    BlogPopularPostGridView()
                    
                    VStack(spacing: 10) {
                        HStack {
                            Spacer()
                            Text("와스토리는 team5에서")
                            Image(systemName: "clock")
                            Text("을 넣어 만듭니다.")
                                .padding(.leading, -5)
                            Spacer()
                        }
                        
                        Text("Waffle Studio")
                    }
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.secondaryLabelColor)
                    .padding(.top, 50)
                    .padding(.bottom, 150)
                    
                }// VStack
            }// ScrollView
            .background(Color.backgourndSpaceColor)
        }// VStack
        .environment(\.postViewModel, viewModel)
        .ignoresSafeArea(edges: .all)
        // MARK: NavBar
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(viewModel.getIsNavTitleHidden() ? .hidden : .visible, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                contentViewModel.navigateToBlogViewButton(tempBlog()) {
                    Image(systemName: "questionmark.text.page.fill")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    dismiss()
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
        //MARK: bottomBar
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                    .foregroundStyle(Color.secondaryLabelColor)
                    .frame(maxWidth: .infinity)
                
                HStack(spacing: 0) {
                    
                    //좋아요 버튼
                    Button(action: {
                        isLiked.toggle()
                    }) {
                        HStack(spacing: 3) {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .font(.system(size: 20, weight: .light))
                                .foregroundStyle(isLiked ? Color.loadingCoralRed : Color.primaryLabelColor)
                            
                            Text("5")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(Color.bottomBarLabelColor)
                        }
                    }
                    
                    Spacer()
                        .frame(width: 25)
                    
                    //댓글 버튼
                    NavigationLink(destination: CommentView(postID: tempPost().id)) {
                        HStack(spacing: 3) {
                            Image(systemName: "text.bubble")
                                .font(.system(size: 20, weight: .light))
                                .foregroundStyle(Color.primaryLabelColor)
                            
                            Text("5")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(Color.bottomBarLabelColor)
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(height: 50)
                .padding(.horizontal, 20)
                .background(Color.white)
            }
        }

    }
}


extension Color {
    static let bottomBarLabelColor = Color(.init(red: 85/255, green: 85/255, blue: 85/255))
}
