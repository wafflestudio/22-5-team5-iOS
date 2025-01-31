//
//  ArticleView.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//  Modified by mujigae on 1/13/25.
//

import SwiftUI
import RichTextKit

@MainActor
struct ArticleView: View {
    @State private var viewModel = ArticleViewModel()
    @Environment(\.dismiss) private var dismiss
    var editingPost: Post? = nil
    
    @FocusState private var isTitleFocused: Bool
    @FocusState private var isTextFocused: Bool
    @State private var debounceWorkItem: DispatchWorkItem?
    @State private var isPickerSelectorPresent: Bool = false    // ViewModel로 관리할 경우 에러 발생
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    isTitleFocused = false
                    isTextFocused = false
                }
            
            VStack {
                // MARK: Custom Navigation Bar
                HStack(spacing: 12) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .light))
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    
                    if viewModel.editingPost == nil {
                        HStack(spacing: 0) {
                            Button {
                                isTitleFocused = false
                                isTextFocused = false
                                if viewModel.title.isEmpty && viewModel.text.length == 0 {
                                    viewModel.isEmptyDraftEntered = true
                                    viewModel.isEmptyTitleEntered = false
                                    viewModel.isDraftSaved = false
                                    viewModel.isDraftDeleted = false
                                    viewModel.isImageLoadPending = false
                                    debounceWorkItem?.cancel()
                                    let workItem = DispatchWorkItem {
                                        withAnimation {
                                            viewModel.isEmptyDraftEntered = false
                                        }
                                    }
                                    debounceWorkItem = workItem
                                    DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.cautionDuration, execute: workItem)
                                }
                                else {
                                    Task {
                                        viewModel.isEmptyDraftEntered = false
                                        viewModel.isEmptyTitleEntered = false
                                        viewModel.isDraftSaved = true
                                        viewModel.isDraftDeleted = false
                                        viewModel.isImageLoadPending = false
                                        
                                        await viewModel.storeDraft()
                                        await viewModel.resetView()
                                        
                                        debounceWorkItem?.cancel()
                                        let workItem = DispatchWorkItem {
                                            withAnimation {
                                                viewModel.isDraftSaved = false
                                            }
                                        }
                                        debounceWorkItem = workItem
                                        DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.cautionDuration, execute: workItem)
                                    }
                                }
                            } label: {
                                Text("저장")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.black)
                                    .padding(.vertical, 7)
                                    .padding(.leading, 15)
                                    .padding(.trailing, 10)
                            }
                            Rectangle()
                                .frame(width: 1, height: 10)
                                .foregroundStyle(Color.codeRequestButtonGray)
                            Button {
                                isTitleFocused = false
                                isTextFocused = false
                                viewModel.isDraftSheetPresent = true
                            } label: {
                                Text(viewModel.getDraftsCount())
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.black)
                                    .padding(.vertical, 7)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 15)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.codeRequestButtonGray, lineWidth: 1)
                        )
                    }
                    
                    ZStack {
                        Button {
                            isTitleFocused = false
                            isTextFocused = false
                            if viewModel.isEmptyTitleEntered {
                                viewModel.isEmptyDraftEntered = false
                                viewModel.isEmptyTitleEntered = true
                                viewModel.isDraftSaved = false
                                viewModel.isDraftDeleted = false
                                viewModel.isImageLoadPending = false
                                debounceWorkItem?.cancel()
                                let workItem = DispatchWorkItem {
                                    withAnimation {
                                        viewModel.isEmptyTitleEntered = false
                                    }
                                }
                                debounceWorkItem = workItem
                                DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.cautionDuration, execute: workItem)
                            }
                            else {
                                viewModel.isEmptyDraftEntered = false
                                viewModel.isEmptyTitleEntered = false
                                viewModel.isDraftSaved = false
                                viewModel.isDraftDeleted = false
                                viewModel.isImageLoadPending = true
                                print("뭐함?")
                                debounceWorkItem?.cancel()
                                let workItem = DispatchWorkItem {
                                    withAnimation {
                                        viewModel.isImageLoadPending = false
                                    }
                                }
                                debounceWorkItem = workItem
                                DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.cautionDuration, execute: workItem)
                            }
                        } label: {
                            Text("완료")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 15)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.codeRequestButtonGray, lineWidth: 1)
                        )
                        .opacity(viewModel.title.isEmpty || viewModel.isImageLoading ? 1 : 0)
                        
                        NavigationLink(destination: ArticleSettingView(articleViewModel: viewModel, viewModel: ArticleSettingViewModel(title: viewModel.title, text: viewModel.text))) {
                            Text("완료")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 15)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.codeRequestButtonGray, lineWidth: 1)
                        )
                        .opacity(viewModel.title.isEmpty || viewModel.isImageLoading ? 0 : 1)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 6)
                SettingDivider(thickness: 1)
                Spacer()
                    .frame(height: 20)
                
                // MARK: Title TextField
                TextField("제목", text: $viewModel.title)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundStyle(Color.primaryLabelColor)
                    .focused($isTitleFocused)
                    .autocapitalization(.none)
                    .padding(.horizontal, 23)
                
                Spacer()
                    .frame(height: 10)
                
                // MARK: Contents TextField
                ZStack(alignment: .topLeading) {
                    if viewModel.text.string.isEmpty {
                        HStack {
                            Text("내용을 입력해주세요.")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(Color.promptLabelColor)
                                .padding(.horizontal, 26)
                                .padding(.top, 9)
                            Spacer()
                        }
                    }
                    RichTextEditor(text: $viewModel.text, context: viewModel.context)
                        .focusedValue(\.richTextContext, viewModel.context)
                        .focused($isTextFocused)
                        .padding(.horizontal, 18)
                        .id(viewModel.resetEditor || viewModel.isEditingTextLoaded)
                }
                RichTextKeyboardToolbar(
                    context: viewModel.context,
                    leadingButtons: { _ in },
                    trailingButtons: {_ in
                        Button {
                            isPickerSelectorPresent = true
                        } label: {
                            Image(systemName: "photo")
                        }
                    },
                    formatSheet: { $0 }
                )
                Spacer()
            }
            
            if isPickerSelectorPresent {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPickerSelectorPresent = false
                    }
                
                VStack(spacing: 20) {
                    Text("이미지를 불러올 방법을 선택해 주세요.")
                        .font(.system(size: 14, weight: .regular))
                    HStack(spacing: 50) {
                        Button {
                            viewModel.isCameraPickerPresent = true
                            isPickerSelectorPresent = false
                        } label: {
                            Image(systemName: "camera")
                        }
                        Button {
                            viewModel.isGalleryPickerPresent = true
                            isPickerSelectorPresent = false
                        } label: {
                            Image(systemName: "photo.on.rectangle.angled")
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                )
            }
            
            ArticleDraftSheet(viewModel: viewModel)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: viewModel.isDraftSheetPresent)
            
            if viewModel.showDeleteAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showDeleteAlert = false
                    }
                
                VStack(spacing: 0) {
                    Text("해당 글을 삭제하시겠습니까?")
                        .font(.system(size: 16, weight: .light))
                    Spacer()
                        .frame(height: 30)
                    
                    Rectangle()
                        .foregroundStyle(Color.dropCautionBoxEdgeGray)
                        .frame(width: 240, height: 1)
                    HStack(spacing: 40) {
                        Button {
                            viewModel.showDeleteAlert = false
                        } label: {
                            Text("취소")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(.black)
                        }
                        Rectangle()
                            .foregroundStyle(Color.dropCautionBoxEdgeGray)
                            .frame(width: 1, height: 50)
                        Button {
                            Task {
                                await viewModel.deleteDraft()
                                viewModel.showDeleteAlert = false
                                
                                viewModel.isEmptyDraftEntered = false
                                viewModel.isEmptyTitleEntered = false
                                viewModel.isDraftSaved = false
                                viewModel.isDraftDeleted = true
                                viewModel.isImageLoadPending = false
                                debounceWorkItem?.cancel()
                                let workItem = DispatchWorkItem {
                                    withAnimation {
                                        viewModel.isDraftDeleted = false
                                    }
                                }
                                debounceWorkItem = workItem
                                DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.cautionDuration, execute: workItem)
                            }
                        } label: {
                            Text("삭제")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(.red)
                        }
                    }
                }
                .padding(.top, 30)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                }
            }
            
            if viewModel.isEmptyDraftEntered {
                Text("제목 또는 내용을 입력해 주세요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(Color.settingGearGray)
                    )
                    .transition(.opacity)
            }
            
            if viewModel.isEmptyTitleEntered {
                Text("제목을 입력해 주세요.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(Color.settingGearGray)
                    )
                    .transition(.opacity)
            }
            
            if viewModel.isDraftSaved {
                Text("작성 중인 글이 저장되었습니다.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(Color.settingGearGray)
                    )
                    .transition(.opacity)
            }
            
            if viewModel.isDraftDeleted {
                Text("삭제되었습니다.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(Color.settingGearGray)
                    )
                    .transition(.opacity)
            }
            
            if viewModel.isImageLoadPending {
                Text("이미지를 불러오는 중입니다.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(Color.settingGearGray)
                    )
                    .transition(.opacity)
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.easeInOut(duration: 0.3), value: viewModel.isEmptyDraftEntered)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isEmptyTitleEntered)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isDraftSaved)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isDraftDeleted)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isImageLoadPending)
        .fullScreenCover(
            isPresented: $viewModel.isCameraPickerPresent,
            onDismiss: {
                if let inputImage = viewModel.inputImage {
                    viewModel.isImageLoading = true
                    viewModel.insertImage(inputImage: inputImage, context: viewModel.context)
                    viewModel.inputImage = nil
                    viewModel.isImageLoading = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        viewModel.isImageLoading = false
                    }
                }
            },
            content: {
                CameraPicker(selectedImage: $viewModel.inputImage, sourceType: .camera)
            }
        )
        .fullScreenCover(
            isPresented: $viewModel.isGalleryPickerPresent,
            onDismiss: {
                if let inputImage = viewModel.inputImage {
                    viewModel.isImageLoading = true
                    viewModel.insertImage(inputImage: inputImage, context: viewModel.context)
                    viewModel.inputImage = nil
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        viewModel.isImageLoading = false
                    }
                }
            },
            content: {
                ImagePicker(selectedImage: $viewModel.inputImage, sourceType: .photoLibrary)
            }
        )
        .onAppear {
            if editingPost != nil && viewModel.editingPost == nil {
                Task {
                    await viewModel.initEditingPost(post: editingPost!)
                }
            }
            Task {
                await viewModel.resetView()
            }
        }
        .onChange(of: viewModel.isSubmitted) { oldValue, newValue in
            if newValue {
                dismiss()
            }
        }
    }
}
