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
    @State var notification: Noti
    @Bindable var viewModel: NotificationViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            HStack(spacing: 0) {
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(notification.checked ? Color.clear : Color.unreadNotification)
                    .padding(.trailing, 7)
                
                KFImageWithDefaultIcon(imageURL: notification.blogMainImageURL)
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            .padding(.leading, 10)
            .padding(.trailing, 18)
            .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text(notification.username.prefix(7) + ((notification.username.count > 7) ? "..." : ""))
                        .font(.system(size: 15, weight: .semibold))
                    
                    switch notification.type {
                    case 1:
                        Text("님이 새 글을 발행했습니다.")
                            .font(.system(size: 15, weight: .light))
                    case 2:
                        Text("님이 내 블로그를 구독합니다.")
                            .font(.system(size: 15, weight: .light))
                    case 3:
                        HStack(spacing: 0) {
                            Text("님이 ")
                                .font(.system(size: 15, weight: .light))
                            Text((notification.postTitle ?? "").prefix(7) + ((notification.postTitle ?? "").count > 7 ? "..." : ""))
                                .font(.system(size: 15, weight: .semibold))
                            Text("에 댓글을 남겼습니다.")
                                .font(.system(size: 15, weight: .light))
                        }
                    case 4:
                        Text("님이 방명록을 남겼습니다.")
                            .font(.system(size: 15, weight: .light))
                    case 5:
                        Text("님이 쪽지를 보냈습니다.")
                            .font(.system(size: 15, weight: .light))
                    default:
                        Text("")
                    }
                }
                .padding(.bottom, 8)
                
                switch notification.type {
                case 1:
                    Text("\"" + (notification.postTitle ?? "") + "\"") // 알림 종류에 따라 변화
                        .font(.system(size: 15, weight: .light))
                        .lineLimit(2)
                        .padding(.bottom, 8)
                case 2:
                    Color.clear
                        .frame(height: 5)
                case 3:
                    Text("\"" + (notification.commentContent ?? "") + "\"") // 알림 종류에 따라 변화
                        .font(.system(size: 15, weight: .light))
                        .lineLimit(2)
                        .padding(.bottom, 8)
                case 4:
                    Text("\"" + (notification.commentContent ?? "") + "\"") // 알림 종류에 따라 변화
                        .font(.system(size: 15, weight: .light))
                        .lineLimit(2)
                        .padding(.bottom, 8)
                case 5:
                    Text("\"" + (notification.commentContent ?? "") + "\"") // 알림 종류에 따라 변화
                        .font(.system(size: 15, weight: .light))
                        .lineLimit(2)
                        .padding(.bottom, 8)
                default:
                    Text("")
                }
                
                
                HStack(spacing: 6) {
                    Text(notification.blogname)
                        .font(.system(size: 13, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 3, weight: .regular))
                        .foregroundStyle(Color.middleDotColor)
                    
                    Text(timeAgo(from: notification.createdAt))
                        .font(.system(size: 13, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                }
                
            }
            .padding(.trailing, 20)
            
            Spacer()
        }
        .padding(.vertical, 22)
        .background(Color.white)
        .onTapGesture {
            viewModel.setTargetNotification(notification)
            viewModel.toggleIsNavigationActive(notification.type)
            if !notification.checked {
                Task {
                    await viewModel.patchNotificationRead()
                    notification.checked = true
                }
            }
        }
        .onLongPressGesture {
            viewModel.setTargetNotification(notification)
            viewModel.toggleIsAlertPresent()
        }
    }
}

