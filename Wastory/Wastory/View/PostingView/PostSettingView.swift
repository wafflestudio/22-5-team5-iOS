//
//  PostSettingView.swift
//  Wastory
//
//  Created by mujigae on 1/16/25.
//

import SwiftUI
import RichTextKit
import PhotosUI

import Foundation

struct PostSettingView: View {
    @State private var viewModel: PostSettingViewModel
    @Environment(\.contentViewModel) var contentViewModel
    
    @State private var isConfirmationDialogPresented: Bool = false
    @State private var isShowingImagePicker: Bool = false
    @State private var imageSourceType: ImageSourceType = .photoLibrary
    @State private var inputImage: UIImage?
    
    @State var text: NSAttributedString = NSMutableAttributedString(string: "")
    @StateObject private var context = RichTextContext()
    @FocusState private var isFocused: Bool
    
    init(viewModel: PostSettingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
                    RichTextEditor(text: $text, context: context)
                        .focusedValue(\.richTextContext, context)
                        .focused($isFocused)
                        .onAppear(){
                            isFocused = true
                        }
                    RichTextKeyboardToolbar(
                        context: context,
                        leadingButtons: {_ in },
                        trailingButtons: {_ in
                            Button(action: {
                                isConfirmationDialogPresented = true
                            }, label: {
                                Image(systemName: "photo")
                            })
                        },
                        formatSheet: {$0}
                    )
                    
                }
        /*
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 30)
            HStack {
                Text(viewModel.getTitle())
                    .font(.system(size: 16))
                Spacer()
                Button {
                    //
                } label: {
                    Text("버버버버버튼튼튼튼튼")
                        .confirmationDialog("Select source", isPresented: $isConfirmationDialogPresented, actions: {
                                Button("Camera") {
                                    self.imageSourceType = .camera
                                    self.isShowingImagePicker = true
                                }
                                Button("Photo Library") {
                                    self.imageSourceType = .photoLibrary
                                    self.isShowingImagePicker = true
                                }
                            })
                            .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                                if let inputImage = inputImage {
                                    self.inputImage = nil
                                }
                            }, content: {
                                switch imageSourceType {
                                case .camera:
                                    CameraImagePicker(image: $inputImage, sourceType: .camera)
                                case .photoLibrary:
                                    PhotoLibraryPicker(selectedImage: $inputImage)
                                }
                            })
                }
            }
            Spacer()
        }*/
        .padding(.horizontal, 20)
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

enum ImageSourceType {
    case camera
    case photoLibrary
}
