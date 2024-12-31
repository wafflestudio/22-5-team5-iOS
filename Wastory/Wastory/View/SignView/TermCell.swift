//
//  TermCell.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import SwiftUI

struct TermCell: View {
    let item: TermItem
    let term: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: item.isAgreed ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(
                    item.isAgreed ? .black : Color.promptLabelColor,
                    item.isAgreed ? Color.kakaoYellow : Color.promptLabelColor
                )
            
            if item.details.isEmpty {
                Text(term)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
            }
            else {
                VStack(alignment: .leading, spacing: 6) {
                    Text(term)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.black)
                    Text(item.details)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundStyle(Color.promptLabelColor)
                        .lineSpacing(2)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
