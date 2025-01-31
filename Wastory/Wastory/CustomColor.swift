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
    
    static let loginFailureBoxColor: Color = .init(red: 250 / 255, green: 250 / 255, blue: 250 / 255)           // 로그인 실패 박스 색상
    
    static let loginFailureTextColor: Color = .init(red: 208 / 255, green: 103 / 255, blue: 79 / 255)           // 로그인 실패 문구 색상
    
    static let progressBarBackgroundColor: Color = .init(red: 235 / 255, green: 235 / 255, blue: 235 / 255)     // 회원가입 진행도 배경 색상
    
    static let progressBarProgressColor: Color = .init(red: 76 / 255, green: 76 / 255, blue: 76 / 255)          // 회원가입 진행도 진행률 색상
    
    static let incompleteAgreementBoxColor: Color = .init(red: 250 / 255, green: 250 / 255, blue: 250 / 255)    // 동의 미완료 박스 색상
    
    static let incompleteAgreementTextColor: Color = .init(red: 179 / 255, green: 179 / 255, blue: 179 / 255)   // 동의 미완료 박스 색상
    
    static let lightClearButtonColor: Color = .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)          // 밝은 클리어 버튼 색상
    
    static let disableUsernameRed: Color = .init(red: 237 / 255, green: 100 / 255, blue: 87 / 255)              // 유저 네임 사용 불가 적색
    
    static let ableUsernameGray: Color = .init(red: 91 / 255, green: 91 / 255, blue: 91 / 255)                  // 유저 네임 사용 가능 회색
    
    static let disableButtonGray: Color = .init(red: 187 / 255, green: 187 / 255, blue: 187 / 255)              // 확인 버튼 불가능 회색
    
    static let loadingCoralRed: Color = .init(red: 255 / 255, green: 85 / 255, blue: 68 / 255)                  // 앱 실행 시 나타나는 로딩 화면 색상
    
    static let primaryDarkModeLabelColor = Color.white
    
    static let secondaryDarkModeLabelColor = Color.init(red: 0.9, green: 0.9, blue: 0.9).opacity(0.8)
    
    static let blogDetailBackgroundColor: Color = .init(red: 247/255, green: 247/255, blue: 247/255)
    
    static let todaysWastoryTextOutterBoxColor = Color.white.opacity(0.5)
    
    static let todaysWastoryTextColor = Color.white
    
    static let backgourndSpaceColor = Color.init(red: 247/255, green: 247/255, blue: 247/255)
    
    static let codeRequestButtonGray: Color = .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)          // 인증 요청 버튼 테두리 색상
    
    static let disabledNextButtonGray: Color = .init(red: 240 / 255, green: 240 / 255, blue: 240 / 255)         // 다음 버튼 이용 불가능 색상
    
    static let emailCautionTextGray: Color = .init(red: 153 / 255, green: 153 / 255, blue: 153 / 255)           // 이메일 입력 주의사항 색상
    
    static let emptyEmailWarnRed: Color = .init(red: 208 / 255, green: 104 / 255, blue: 79 / 255)               // 이메일 미입력 경고 색상
    
    static let articleImageBackgroundGray: Color = .init(red: 233 / 255, green: 233 / 255, blue: 233 / 255)     // 대표 이미지 설정 배경 회색
    
    static let articleImageTextGray: Color = .init(red: 201 / 255, green: 201 / 255, blue: 201 / 255)           // 대표 이미지 설정 문구 회색
    
    static let articlePasswordGray: Color = .init(red: 120 / 255, green: 120 / 255, blue: 120 / 255)            // 글 비밀번호 회색
    
    static let ossLinkBlue: Color = .init(red: 30 / 255, green: 29 / 255, blue: 176 / 255)                      // OSS 하이퍼링크 색상
    
    static let dropCautionBoxGray: Color = .init(red: 250 / 255, green: 250 / 255, blue: 250 / 255)             // 탈퇴 경고 박스 색상
    
    static let dropCautionBoxEdgeGray: Color = .init(red: 221 / 255, green: 221 / 255, blue: 221 / 255)         // 탈퇴 경고 박스 모서리 색상
    
    static let dropCautionBoxTextGray: Color = .init(red: 100 / 255, green: 100 / 255, blue: 100 / 255)         // 탈퇴 경고 박스 문구 색상
    
    static let settingItemDescGray: Color = .init(red: 187 / 255, green: 187 / 255, blue: 187 / 255)            // 설정 목록 세부 정보 색상
    
    static let settingDivderGray: Color = .init(red: 247 / 255, green: 247 / 255, blue: 247 / 255)              // 설정 분리선 색상
    
    static let settingDropGray: Color = .init(red: 144 / 255, green: 144 / 255, blue: 144 / 255)                // 탈퇴하기 문구 색상
    
    static let settingDisabledBlue: Color = .init(red: 108 / 255, green: 192 / 255, blue: 255 / 255)            // 불가능 항목 알림 색상 (불쾌감을 주지 않기 위해 청색을 채택)
    
    static let settingGearGray: Color = .init(red: 77 / 255, green: 77 / 255, blue: 77 / 255)                   // 블로그 시트 세팅 버튼 회색
}
