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
    var body: some View {
        
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                
                //MARK: title Text
                Text("TitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitle")
                    .font(.system(size: 18, weight: .regular))
                    .lineLimit(1)
                
                //MARK: content Text
                Text("Content Content Content Content Content Content Content Content Content Content Content")
                    .font(.system(size: 16, weight: .regular))
                    .lineLimit(2)
                    .foregroundStyle(Color.gray)
                
                //MARK: like & comment & timeAgo Text
                HStack(alignment: .center, spacing: 9) {
                    
                    //likeCount Text
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "heart")
                        
                        Text("50")
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray)
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 3, weight: .regular))
                        .foregroundStyle(Color.gray.opacity(0.3))
                    
                    
                    //commentCount Text
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "ellipsis.bubble")
                        
                        Text("5")
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray)
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 3, weight: .regular))
                        .foregroundStyle(Color.gray.opacity(0.3))
                    
                    //timeAgo Text
                    Text("5분 전") //~초 ~분 ~시간 ~일 ~달 전으로 나눠서 표시
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.gray)
                }
                
                //MARK: posted blog info
                HStack(alignment: .center, spacing: 9) {
                    //blog image
                    Image(systemName: "questionmark.app.dashed")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .background(Color.gray.opacity(0.3))
                        .clipped()
                        .cornerRadius(7)
                    
                    //blog name
                    Text("Blog name")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.gray)
                }
                
            }
            .padding(.trailing, 28)
            
            //MARK: content Image
            //글 내용에 이미지가 없을 경우 표시하지 않음
            Image(systemName: "questionmark.text.page.fill")
                .resizable()
                .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                .frame(width: 100, height: 100)
                .clipped()
                
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .onTapGesture {
            //TODO: 해당 글 View로 이동
        }
    }
}

#Preview {
    FeedCell()
}
