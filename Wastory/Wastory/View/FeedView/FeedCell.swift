//
//  FeedCell.swift
//  Wastory
//
//  Created by 중워니 on 12/25/24.
//

import SwiftUI

// "피드"의 List에 표시 될 Cell
// [제목, 내용 및 이미지, 좋아요 수, 댓글 수, 업로드 시간, 업로드된 블로그] 정보가 필요.
struct FeedCell: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                
                //MARK: title Text
                Text("제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목")
                    .font(.system(size: 17, weight: .regular))
                    .lineLimit(1)
                
                //MARK: content Text
                Text("내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용")
                    .font(.system(size: 14, weight: .light))
                    .lineLimit(2)
                    .foregroundStyle(Color.secondaryLabelColor)
                
                //MARK: like & comment & timeAgo Text
                HStack(alignment: .center, spacing: 9) {
                    
                    //likeCount Text
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "heart")
                        
                        Text("50")
                    }
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.secondaryLabelColor)
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 3, weight: .light))
                        .foregroundStyle(Color.gray.opacity(0.3))
                    
                    
                    //commentCount Text
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "ellipsis.bubble")
                        
                        Text("5")
                    }
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.secondaryLabelColor)
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 3, weight: .regular))
                        .foregroundStyle(Color.gray.opacity(0.3))
                    
                    //timeAgo Text
                    Text("5분 전") //~초 ~분 ~시간 ~일 ~달 전으로 나눠서 표시
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                }
                
                //MARK: posted blog info
                contentViewModel.openNavigationLinkWithBlogButton {
                    HStack(alignment: .center, spacing: 9) {
                        //blog image
                        Image(systemName: "questionmark.app.dashed")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .background(Color.secondaryLabelColor.opacity(0.3))
                            .clipped()
                            .cornerRadius(5)
                        
                        //blog name
                        Text("Blog name")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                    }
                }
            }
            .padding(.trailing, 20)
            
            //MARK: content Image
            //글 내용에 이미지가 없을 경우 표시하지 않음
            Image(systemName: "questionmark.text.page.fill")
                .resizable()
                .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                .frame(width: 100, height: 100)
                .clipped()
                
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 22)
        .background {
            contentViewModel.openNavigationLinkWithPostButton()
        }
    }
}

#Preview {
    FeedCell()
}
