//
//  PostView.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI
import RichTextKit

struct PostView: View {
    let postID: Int
    let blogID: Int
    @State var toComment: Bool = false
    @State private var viewModel = PostViewModel()
    @Environment(\.dismiss) private var dismiss
//    @Environment(\.contentViewModel) var contentViewModel
    
    @FocusState private var isTextFocused: Bool
    
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
                    Spacer()
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                            .frame(height: 100)
                        
                        // MARK: 카테고리 버튼
                        NavigateToBlogViewButton(blogID, viewModel.post.categoryID) {
                            Text(viewModel.post.categoryID == 0 ? "카테고리 없음" : viewModel.categoryName)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.primaryLabelColor)
                                .lineLimit(1)
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
                        Text(viewModel.post.title)
                            .font(.system(size: 34, weight: .medium))
                            .foregroundStyle(Color.primaryLabelColor)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // MARK: 블로그 이름 . 작성일자
                        HStack(spacing: 5) {
                            Text(viewModel.blog.blogName)
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(Color.secondaryLabelColor)
                                .lineLimit(1)
                            
                            Image(systemName: "circle.fill")
                                .font(.system(size: 3, weight: .regular))
                                .foregroundStyle(Color.middleDotColor)
                            
                            Text("\(timeFormatter(from: viewModel.post.createdAt))")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.secondaryLabelColor)
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer()
                            .frame(height: 60)
                        
                        // MARK: Content
                        RichTextViewer(viewModel.text)
                            .frame(height: viewModel.textHeight)
                            .padding(.horizontal, 20)
                            .id(viewModel.isTextLoaded)
                            .disabled(true)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Divider()
                            .foregroundStyle(Color.secondaryLabelColor)
                        Spacer()
                    }
                    .background(Color.white)
                    // TODO: 태그 버튼 추가하기
                    
                    Spacer()
                    
                    
                    //Blog 세부설명 및 구독버튼
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading, spacing: 0) {
                            NavigateToBlogViewButton(blogID) {
                                Text(viewModel.blog.blogName)
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                                .frame(height: 5)
                            
                            NavigateToBlogViewButton(blogID) {
                                Text(viewModel.blog.description)
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            Spacer()
                                .frame(height: 15)
                            
                            if viewModel.blog.id != UserInfoRepository.shared.getBlogID() && viewModel.blog.id != Blog.defaultBlog.id {
                                SubscribingButton(
                                    blogID: viewModel.blog.id,
                                    blogAddress: viewModel.blog.addressName,
                                    subscribedContent: {
                                        AnyView(
                                            HStack(spacing: 0) {
                                                Text("구독중 ")
                                                
                                                Image(systemName: "checkmark")
                                            }
                                            .font(.system(size: 14, weight: .light))
                                            .foregroundStyle(Color.primaryLabelColor)
                                            .frame(width: 87, height: 35)
                                            .background(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                                    .foregroundStyle(Color.secondaryLabelColor)
                                            )
                                        )
                                    },
                                    notSubscribedContent: {
                                        AnyView(
                                            Text("구독하기 +") // 구독중 V
                                                .font(.system(size: 14, weight: .light))
                                                .foregroundStyle(Color.primaryLabelColor)
                                                .frame(width: 100, height: 35)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(style: StrokeStyle(lineWidth: 1))
                                                        .foregroundStyle(Color.primaryLabelColor)
                                                )
                                        )
                                    }
                                )
                            }
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        NavigateToBlogViewButton(blogID) {
                            KFImageWithDefault(imageURL: viewModel.blog.mainImageURL)
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
                    
                    if !viewModel.categoryBlogPosts.isEmpty {
                        CategoryPostListView(viewModel: viewModel)
                    }
                    
                    if !viewModel.popularBlogPosts.isEmpty {
                        BlogPopularPostGridView(viewModel: viewModel)
                    }
                    
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
        //MARK: Networking
        .onAppear {
            viewModel.showManageMode = false
            if viewModel.post == Post.defaultPost {
                Task {
                    await viewModel.initContent(postID, blogID)
                    Task {
                        await viewModel.getPostsInBlogInCategory()
                    }
                    Task {
                        await viewModel.getPopularBlogPosts()
                    }
                    Task {
                        await viewModel.getIsLiked()
                    }
                    Task {
                        await viewModel.loadText()
                    }
                    if toComment {
                        viewModel.showComments.toggle()
                        toComment = false
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .all)
        // MARK: NavBar
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(viewModel.getIsNavTitleHidden() ? .hidden : .visible, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigateToBlogViewButton(blogID) {
                    KFImageWithDefaultIcon(imageURL: viewModel.blog.mainImageURL)
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
                    
                    if !viewModel.showManageMode {
                        //좋아요 버튼
                        Button(action: {
                            Task {
                                await viewModel.likeButtonAction()
                            }
                        }) {
                            HStack(spacing: 3) {
                                Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundStyle(viewModel.isLiked ? Color.loadingCoralRed : Color.primaryLabelColor)
                                
                                Text("\(viewModel.post.likeCount)")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(Color.bottomBarLabelColor)
                            }
                        }
                    }
                    
                    if !viewModel.showManageMode {
                        Spacer()
                            .frame(width: 25)
                    }
                    
                    if !viewModel.showManageMode {
                        //댓글 버튼
                        Button(action: {
                            viewModel.showComments.toggle()
                        }) {
                            HStack(spacing: 3) {
                                Image(systemName: "text.bubble")
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundStyle(Color.primaryLabelColor)
                                
                                Text("\(viewModel.post.commentCount)")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(Color.bottomBarLabelColor)
                            }
                        }
                    }
                    
                    if viewModel.showManageMode {
                        //수정 버튼
                        Button(action: {
                            viewModel.navToEdit.toggle()
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 20, weight: .light))
                                .foregroundStyle(Color.primaryLabelColor)
                        }
                    }
                    
                    if viewModel.showManageMode {
                        Spacer()
                            .frame(width: 25)
                    }
                    
                    if viewModel.showManageMode {
                        //삭제 버튼
                        Button(action: {
                            viewModel.isDeleteAlertPresent.toggle()
                        }) {
                            Image(systemName: "trash")
                                .font(.system(size: 20, weight: .light))
                                .foregroundStyle(Color.loadingCoralRed)
                        }
                        .alert("글 삭제", isPresented: $viewModel.isDeleteAlertPresent) {
                            Button("취소", role: .cancel) {}
                            
                            Button("삭제", role: .destructive) {
                                Task {
                                    await viewModel.deletePost()
                                    viewModel.isPostDeleted = true
                                }
                            }
                        } message: {
                            Text("글을 삭제하시겠습니까?")
                        }
                    }
                    
                    Spacer()
                    
                    
                    //글 관리(수정, 삭제) on/off 버튼
                    if viewModel.isMyPost {
                        Button(action: {
                            viewModel.showManageMode.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20, weight: .light))
                                .foregroundStyle(Color.primaryLabelColor)
                                .rotationEffect(.degrees(viewModel.showManageMode ? -90 : 0))
                        }
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 20)
                .background(Color.white)
                .fullScreenCover(isPresented: $viewModel.showComments) {
                    NavigationStack {
                        CommentView(postID: viewModel.post.id, blogID: viewModel.blog.id, postViewModel: viewModel)
                    }
                }
                .fullScreenCover(isPresented: $viewModel.navToEdit) {
                    NavigationStack {
                        ArticleView(editingPost: viewModel.post)
                    }
                }
            }
        }
        .onChange(of: viewModel.isPostDeleted) { oldValue, newValue in
            if newValue {
                dismiss()
            }
        }
    }
}


extension Color {
    static let bottomBarLabelColor = Color(.init(red: 85/255, green: 85/255, blue: 85/255))
}
