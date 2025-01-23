//
//  MyBlogSettingsViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/23/25.
//

import SwiftUI
import Observation

@Observable final class MyBlogSettingsViewModel {
    var mainImage: UIImage? = nil
    var isImagePickerPresented: Bool = false
    
    func toggleImagePickerPresented() {
        isImagePickerPresented.toggle()
    }
    
    
    var blogMainImageURL: String = ""
    var blogName: String = ""
    var blogDescription: String = ""
    var username: String = ""
    
    
    func getInitialData() async {
        do {
            let blog = try await NetworkRepository.shared.getMyBlog()
            blogMainImageURL = blog.mainImageURL ?? ""
            blogName = blog.blogName
            blogDescription = blog.description
            username = UserInfoRepository.shared.getUsername()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
