//
//  CustomBackButton.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.black)
        }
    }
}
