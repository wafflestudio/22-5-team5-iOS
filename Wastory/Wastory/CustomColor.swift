//
//  CustomColor.swift
//  Wastory
//
//  Created by 중워니 on 12/25/24.
//

import SwiftUI

extension Color {
    static let primaryLabelColor: Color = .black
    
    static let secondaryLabelColor: Color = .gray
    
    static let unreadNotification = Color(red: 255/255, green: 84/255, blue: 68/255)
    
    static let middleDotColor = Color.gray.opacity(0.3)
    
    static let sheetOuterBackgroundColor: Color = .black.opacity(0.3)
    
    static let kakaoYellow: Color = .init(red: 253 / 255, green: 229 / 255, blue: 0 / 255)  // 로그인 버튼에 사용되는 카카오의 상징색
    
    static let promptLabelColor: Color = .init(red: 142 / 255, green: 142 / 255, blue: 142 / 255)   // 텍스트필드 프롬프트 색상
    
    static let autoSaveLabelColor: Color = .init(red: 102 / 255, green: 102 / 255, blue: 102 / 255)   // 간편정보 저장 문구 색상
    
    static let loginFailureBoxColor: Color = .init(red: 250 / 255, green: 250 / 255, blue: 250 / 255)   // 로그인 실패 박스 색상
    
    static let loginFailureTextColor: Color = .init(red: 208 / 255, green: 103 / 255, blue: 79 / 255)   // 로그인 실패 문구 색상
    
    static let progressBarBackgroundColor: Color = .init(red: 235 / 255, green: 235 / 255, blue: 235 / 255)  // 회원가입 진행도 배경 색상
    
    static let progressBarProgressColor: Color = .init(red: 76 / 255, green: 76 / 255, blue: 76 / 255)  // 회원가입 진행도 진행률 색상
    
    static let incompleteAgreementBoxColor: Color = .init(red: 250 / 255, green: 250 / 255, blue: 250 / 255)  // 동의 미완료 박스 색상
    
    static let incompleteAgreementTextColor: Color = .init(red: 179 / 255, green: 179 / 255, blue: 179 / 255)  // 동의 미완료 박스 색상
    
    static let lightClearButtonColor: Color = .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)   // 밝은 클리어 버튼 색상
    
    static let disableUsernameRed: Color = .init(red: 237 / 255, green: 100 / 255, blue: 87 / 255)     // 유저 네임 사용 불가 적색
    
    static let ableUsernameGray: Color = .init(red: 91 / 255, green: 91 / 255, blue: 91 / 255)     // 유저 네임 사용 가능 회색
    
    static let disableButtonGray: Color = .init(red: 187 / 255, green: 187 / 255, blue: 187 / 255)      // 확인 버튼 불가능 회색
    
    static let loadingCoralRed: Color = .init(red: 255 / 255, green: 85 / 255, blue: 68 / 255)  // 앱 실행 시 나타나는 로딩 화면 색상
}
