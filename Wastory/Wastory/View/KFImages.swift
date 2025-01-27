//
//  KFImages.swift
//  Wastory
//
//  Created by 중워니 on 1/27/25.
//

import SwiftUI
import Kingfisher

struct KFImageWithDefault: View {
    var imageURL: String?
    
    var body: some View {
        VStack(spacing: 0) {
            if imageURL ?? "" == "" {
                Image("defaultImage")
                    .resizable()
            } else {
                KFImage(URL(string: imageURL!))
                    .resizable()
            }
        }
    }
}

struct KFImageWithDefaultIcon: View {
    var imageURL: String?
    
    var body: some View {
        VStack(spacing: 0) {
            if imageURL ?? "" == "" {
                Image("myW")
                    .resizable()
            } else {
                KFImage(URL(string: imageURL!))
                    .resizable()
            }
        }
    }
}

struct KFImageWithoutDefault: View {
    var imageURL: String?
    
    var body: some View {
        VStack(spacing: 0) {
            if imageURL ?? "" == "" {
            } else {
                KFImage(URL(string: imageURL!))
                    .resizable()
            }
        }
    }
}
