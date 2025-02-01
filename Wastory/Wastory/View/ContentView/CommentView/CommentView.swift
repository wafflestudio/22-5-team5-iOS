//
//  CommentView.swift
//  Wastory
//
//  Created by 중워니 on 1/16/25.
//

import SwiftUI

struct CommentView: View {
    var postID: Int? = nil
    var blogID: Int? = nil
    @State var viewModel = CommentViewModel()
    @Environment(\.dismiss) private var dismiss
    @Bindable var postViewModel: PostViewModel = PostViewModel()
//    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: 20)
                        
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
                        
                        // MARK: 화면 상단 구성 요소
                        HStack(alignment: .top) {
                            //Navbar title
                            Text(viewModel.commentType == .post ? "댓글" : "방명록")
                                .font(.system(size: 34, weight: .medium))
                            
                            Spacer()
                                .frame(width: 4)
                            
                            //comment count
                            Text("\(viewModel.totalCommentsCount)")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(Color.secondaryLabelColor)
                            
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        
                        // MARK: 댓글List
                        LazyVStack {
                            ForEach(Array(viewModel.comments.enumerated()), id: \.offset) { index, comment in
                                CommentCell(comment: comment, isChild: false, rootComment: comment, viewModel: viewModel)
                                    .onAppear {
                                        if index == viewModel.comments.count - 1 {
                                            Task {
                                                await viewModel.getComments()
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                .onTapGesture {
                    viewModel.unfocusTextField()
                }
            }
            .refreshable {
                viewModel.resetPage()
                viewModel.resetTargetComment()
                viewModel.resetWritingCommentText()
                Task {
                    await viewModel.getComments()
                }
            }
            
            
            CommentSheet(viewModel: viewModel)
        }
        // MARK: Network
        .onAppear {
            viewModel.setCommentType(postID, blogID)
            Task {
                await viewModel.getComments()
            }
        }
        // MARK: NavBar
        .navigationTitle(viewModel.getIsNavTitleHidden() ? "" : (viewModel.commentType == .post ? "댓글" : "방명록"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    postViewModel.setCommentCount(viewModel.totalCommentsCount)
                    dismiss()
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(Color.black)
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
        //MARK: bottomBar
        .safeAreaInset(edge: .bottom) {
            if !viewModel.isCommentSheetPresent {
                VStack(spacing: 0) {
                    Divider()
                        .foregroundStyle(Color.secondaryLabelColor)
                        .frame(maxWidth: .infinity)
                    
                    if viewModel.isTargetToComment {
                        HStack(spacing: 0) {
                            Text(viewModel.targetComment!.userName)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(Color.primaryLabelColor)
                            
                            Text("님에게 답글을 씁니다.")
                                .font(.system(size: 13, weight: .thin))
                                .foregroundStyle(Color.primaryLabelColor)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.resetTargetComment()
                            }) {
                                Image(systemName:"xmark")
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundStyle(Color.primaryLabelColor)
                            }
                        }
                        .frame(height: 37)
                        .padding(.horizontal, 20)
                        .background(Color.backgourndSpaceColor)
                    }
                    
                    ZStack {
                        if postViewModel.post.commentsEnabled == 1 || postID == nil {
                            HStack(spacing: 0) {
                                if viewModel.isWritingCommentEmpty() {
                                    Text("내용을 입력하세요")
                                        .font(.system(size: 16, weight: .light))
                                        .foregroundStyle(Color.secondaryLabelColor)
                                }
                                Spacer()
                            }
                            
                            HStack(spacing: 0) {
                                FocusableTextView(
                                    text: $viewModel.writingCommentText,
                                    isFirstResponder: $viewModel.isTextFieldFocused,
                                    font: UIFont.systemFont(ofSize: 16, weight: .light) // 원하는 폰트 설정
                                )
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                
                                Spacer()
                                    .frame(width: 10)
                                
                                Button(action : {
                                    viewModel.isWritingCommentSecret.toggle()
                                }) {
                                    Image(systemName: viewModel.isWritingCommentSecret ? "lock" : "lock.open")
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundStyle(viewModel.isWritingCommentSecret ? Color.primaryLabelColor : Color.secondaryLabelColor)
                                }
                                
                                Spacer()
                                    .frame(width: 10)
                                
                                Button(action: {
                                    Task {
                                        viewModel.callAPIRequest()
                                        await viewModel.postComment()
                                        viewModel.resetPage()
                                        viewModel.resetTargetComment()
                                        viewModel.resetWritingCommentText()
                                        await viewModel.getComments()
                                        viewModel.unfocusTextField()
                                    }
                                }) {
                                    Text("등록")
                                        .font(.system(size: 16, weight: viewModel.isWritingCommentEmpty() ? .light : .semibold))
                                        .foregroundStyle(viewModel.isWritingCommentEmpty() ? Color.secondaryLabelColor : Color.white)
                                        .frame(width: 65, height: 35)
                                        .background(
                                            VStack(spacing: 0) {
                                                if viewModel.isWritingCommentEmpty() {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(style: StrokeStyle(lineWidth: 0.5))
                                                        .foregroundStyle(Color.secondaryLabelColor)
                                                } else {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .foregroundStyle(Color.primaryLabelColor)
                                                }
                                            }
                                        )
                                }
                                .disabled(viewModel.isWritingCommentEmpty() || viewModel.isWaitingResponse)
                                
                            }
                        } else {
                            HStack {
                                Text("댓글 추가 작성이 허용되지 않은 글입니다.")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                                
                                Spacer()
                            }
                        }
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    
                }//VStack
            }
        }
    } //Body
}

struct FocusableTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var font: UIFont
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: FocusableTextView
        
        init(parent: FocusableTextView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isFirstResponder = true
            }
            centerTextIfNeeded(textView)
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isFirstResponder = false
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            centerTextIfNeeded(textView)
        }
        
        func centerTextIfNeeded(_ textView: UITextView) {
            DispatchQueue.main.async {
                let contentSize = textView.layoutManager.usedRect(for: textView.textContainer).height
                let lineHeight = textView.font?.lineHeight ?? 0
                let numberOfLines = ceil(contentSize / lineHeight)
                
                if numberOfLines <= 1 {
                    let topInset = (textView.bounds.height - contentSize) / 2
                    textView.contentInset = UIEdgeInsets(top: max(0, topInset), left: 0, bottom: 0, right: 0)
                } else {
                    textView.contentInset = .zero
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = font
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.autocapitalizationType = .none
        
        // 레이아웃 우선순위 설정
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        // 초기 상태 설정
        DispatchQueue.main.async {
            context.coordinator.centerTextIfNeeded(textView)
        }
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
            context.coordinator.centerTextIfNeeded(uiView)
        }
        
        if isFirstResponder {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
}
