//
//  OSSView.swift
//  Wastory
//
//  Created by mujigae on 1/19/25.
//

import SwiftUI

struct OSSView: View {
    @State private var viewModel = OSSViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 20)
                HStack {
                    Text("OSS Notice | Wastory-iOS")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                .background(
                    Rectangle()
                        .frame(height: 60)
                )
                Spacer()
                    .frame(height: 40)
                
                OSSDescriptionText(text: "This application is Copyright ⓒ Waffle Team 5. All rights reserved.")
                OSSDescriptionText(text: "The following sets forth attribution notices for third party software that may be contained in this application")
                OSSDescriptionText(text: "If you have any questions about these notices, please contact the SNU waffle team 5.")
                Spacer()
                    .frame(height: 20)
                
                Rectangle()
                    .fill(Color.dropCautionBoxEdgeGray)
                    .frame(height: 1)
                Spacer()
                    .frame(height: 24)
                
                VStack(spacing: 12) {
                    ForEach(viewModel.OSSs) { cell in
                         OSSCell(OSS: cell)
                     }
                 }
                Spacer()
                    .frame(height: 24)
                Rectangle()
                    .fill(Color.dropCautionBoxEdgeGray)
                    .frame(height: 1)
                Spacer()
                    .frame(height: 24)
                
                VStack(spacing: 12) {
                    ForEach(viewModel.licenses) { cell in
                        LicenseCell(license: cell)
                    }
                }
            }
        }
        .toolbarBackgroundVisibility(.visible)
        .toolbarBackground(Color.white)
        .navigationTitle("Open Source License")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(weight: .regular)
            }
        }
    }
}

struct OSSDescriptionText: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.settingDropGray)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }
}

struct OSSCell: View {
    let OSS: OSS
    @State var isOpenLicense: Bool = false
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(OSS.ossName)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
            }
            HStack {
                Link(destination: OSS.ossURL, label: {
                    Text(OSS.ossURL.absoluteString)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.ossLinkBlue)
                        .underline()
                })
                Spacer()
            }
            .padding(.leading, 20)
            HStack {
                Text(OSS.ossDescription)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.settingDropGray)
                Spacer()
            }
            .padding(.leading, 20)
            HStack {
                Button {
                    isOpenLicense.toggle()
                } label: {
                    Image(systemName: isOpenLicense ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                }
                Text(OSS.ossLicense.licenseName)
                    .font(.system(size: 13))
                Spacer()
            }
            .padding(.leading, 20)
            
            if isOpenLicense {
                ScrollView {
                    Text(OSS.ossLicense.licenseDescription)
                        .font(.system(size: 14, design: .monospaced))
                }
                .frame(height: 180)
                .padding(.leading, 22)
                .overlay {
                    Rectangle()
                        .stroke(Color.settingItemDescGray, lineWidth: 1)
                        .padding(.leading, 20)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct LicenseCell: View {
    let license: License
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(license.licenseName)
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
            }
            Spacer()
                .frame(height: 18)
            HStack {
                Text(license.licenseDescription)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(Color.settingDropGray)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
}
