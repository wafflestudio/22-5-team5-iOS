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
    @Bindable var mainTabViewModel: MainTabViewModel
    @State private var viewModel = ArticleViewModel()
    
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
                        mainTabViewModel.toggleIsArticleViewPresent()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .light))
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Button {
                            isTitleFocused = false
                            isTextFocused = false
                            if viewModel.title.isEmpty && viewModel.text.length == 0 {
                                viewModel.isEmptyDraftEntered = true
                                viewModel.isEmptyTitleEntered = false
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
                                    await viewModel.storeDraft()
                                    await viewModel.resetView()
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
                    
                    ZStack {
                        Button {
                            isTitleFocused = false
                            isTextFocused = false
                            viewModel.isEmptyDraftEntered = false
                            viewModel.isEmptyTitleEntered = true
                            debounceWorkItem?.cancel()
                            let workItem = DispatchWorkItem {
                                withAnimation {
                                    viewModel.isEmptyTitleEntered = false
                                }
                            }
                            debounceWorkItem = workItem
                            DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.cautionDuration, execute: workItem)
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
                        .opacity(viewModel.title.isEmpty ? 1 : 0)
                        
                        NavigationLink(destination: ArticleSettingView(mainTabViewModel: mainTabViewModel, viewModel: ArticleSettingViewModel(title: viewModel.title, text: viewModel.text))) {
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
                        .opacity(viewModel.title.isEmpty ? 0 : 1)
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
                    RichTextEditor(text: $viewModel.text, context: viewModel.context) {
                        $0.imageConfiguration.maxImageSize = (width: .points(200), height: .points(200))
                    }
                        .focusedValue(\.richTextContext, viewModel.context)
                        .focused($isTextFocused)
                        .padding(.horizontal, 18)
                        .id(viewModel.resetEditor)
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
        }
        .navigationBarBackButtonHidden()
        .animation(.easeInOut(duration: 0.3), value: viewModel.isEmptyDraftEntered)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isEmptyTitleEntered)
        .fullScreenCover(
            isPresented: $viewModel.isCameraPickerPresent,
            onDismiss: {
                if let inputImage = viewModel.inputImage {
                    viewModel.insertImage(inputImage: inputImage, context: viewModel.context)
                    viewModel.inputImage = nil
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
                    viewModel.insertImage(inputImage: inputImage, context: viewModel.context)
                    viewModel.inputImage = nil
                }
            },
            content: {
                ImagePicker(selectedImage: $viewModel.inputImage, sourceType: .photoLibrary)
            }
        )
        .onAppear {
            Task {
                await viewModel.resetView()
            }
        }
    }
}
