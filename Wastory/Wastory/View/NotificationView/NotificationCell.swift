//
//  NotificationCell.swift
//  Wastory
//
//  Created by 중워니 on 12/31/24.
//



import SwiftUI

// "피드"의 List에 표시 될 Cell
// [제목, 내용 및 이미지, 좋아요 수, 댓글 수, 업로드 시간, 업로드된 블로그] 정보가 필요.
struct NotificationCell: View {
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            HStack(spacing: 0) {
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(Color.unreadNotification) //TODO: 읽은 상태라면 .clear
                    .padding(.trailing, 7)
                
                Image(systemName: "questionmark.text.page.fill.rtl")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .clipShape(Circle())
            }
            .padding(.leading, 10)
            .padding(.trailing, 18)
            .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("중워니")
                        .font(.system(size: 15, weight: .semibold))
                    
                    Text("님이 새 글을 발행했습니다.") // 알림 종류에 따라 변화
                        .font(.system(size: 15, weight: .light))
                }
                .padding(.bottom, 8)
                
                Text("\"" + "알림종류에 따라 달라짐 예: 새글 알림 경우에는 새글의 제목이 표시가 됨. 댓글의 경우에는 댓글의 내용이 표시가 됨\"") // 알림 종류에 따라 변화
                    .font(.system(size: 15, weight: .light))
                    .lineLimit(2)
                    .padding(.bottom, 8)
                
                HStack(spacing: 6) {
                    Text("블로그 이름")
                        .font(.system(size: 13, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 3, weight: .regular))
                        .foregroundStyle(Color.middleDotColor)
                    
                    Text("1시간 전")
                        .font(.system(size: 13, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                }
                
            }
            .padding(.trailing, 40)
            
        }
        .padding(.vertical, 22)
    }
}

extension Color {
    static let unreadNotification = Color(red: 255/255, green: 84/255, blue: 68/255)
    static let middleDotColor = Color.gray.opacity(0.3)
}


#Preview {
    NotificationCell()
}
