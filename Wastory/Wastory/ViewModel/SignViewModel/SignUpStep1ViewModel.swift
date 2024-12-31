//
//  SignUpStep1ViewModel.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import SwiftUI
import Observation

@Observable final class SignUpStep1ViewModel {
    private var terms: [TermItem] = [
        TermItem(type: .required, term: "와스토리 계정 약관"),
        TermItem(type: .required, term: "왠지 모르게 필수적인 약관"),
        TermItem(type: .required, term: "세부 사항이 있는 약관",
                 details: "자세하지 않은 듯 자세한 세부 사항이며 한 줄을 넘어 줄바꿈 간격을 확인하기 위해 매우 길게 설계되었습니다."),
        TermItem(type: .optional, term: "위치정보 수집 및 이용 동의"),
        TermItem(type: .optional, term: "알 수 없지만 무언가 선택적인 약관")
    ]
    
    private var agreedCount: Int = 0
    private var requiredCount: Int = 0
    private var totalRequiredCount: Int = 0
    
    init() {
        for index in 0..<terms.count {
            if terms[index].type == .required {
                totalRequiredCount += 1
            }
        }
    }
    
    func getTerms() -> [TermItem] {
        return terms
    }
    
    func getTerm(item: TermItem) -> String {
        switch item.type {
        case .none:
            return item.term
        case .required:
            return "[필수] \(item.term)"
        case .optional:
            return "[선택] \(item.term)"
        }
    }
    
    func toggleItemAgreement(item: TermItem) {
        if let index = terms.firstIndex(where: { $0.id == item.id }) {
            terms[index].isAgreed.toggle()
            if terms[index].isAgreed {
                agreedCount += 1
                if terms[index].type == .required {
                    requiredCount += 1
                }
            }
            else {
                agreedCount -= 1
                if terms[index].type == .required {
                    requiredCount -= 1
                }
            }
        }
    }
    
    func toggleEntireAgreement() {
        if agreedCount == terms.count {
            for index in 0..<terms.count {
                terms[index].isAgreed = false
            }
            agreedCount = 0
            requiredCount = 0
        }
        else {
            requiredCount = 0
            for index in 0..<terms.count {
                terms[index].isAgreed = true
                if terms[index].type == .required {
                    requiredCount += 1
                }
            }
            agreedCount = terms.count
        }
    }
    
    func isEntireTermAgreed() -> Bool {
        return agreedCount == terms.count
    }
    
    func areAllRequiredTermsAgreed() -> Bool {
        return requiredCount == totalRequiredCount
    }
}
