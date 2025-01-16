//
//  CommentView.swift
//  Wastory
//
//  Created by 중워니 on 1/16/25.
//

import SwiftUI

struct CommentView: View {
    @State var viewModel = CommentViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
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
                        Text("댓글")
                            .font(.system(size: 34, weight: .medium))
                            .padding(.leading)
                        
                        Spacer()
                        
                        //comment count
                        Text("55")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(Color.secondaryLabelColor)
                            .padding(.leading)
                    }
                    
                    
                }
            }
        }
        // MARK: NavBar
        .navigationTitle(viewModel.getIsNavTitleHidden() ? "" : "댓글")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(viewModel.getIsNavTitleHidden() ? .hidden : .visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
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
    } //Body
}

#Preview {
    CommentView()
}
