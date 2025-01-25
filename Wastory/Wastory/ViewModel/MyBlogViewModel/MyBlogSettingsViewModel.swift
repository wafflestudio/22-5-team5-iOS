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
    
    var isBlogNameValid: Bool {
        !blogName.isEmpty && blogName.count <= 40
    }
    
    var isBlogDescriptionValid: Bool {
        blogDescription.count <= 255
    }
    
    var isUsernameValid: Bool {
        !username.isEmpty && username.count <= 32
    }
    
    var isSubmitValid: Bool {
        isBlogNameValid && isBlogDescriptionValid //&& isUsernameValid
    }
    
    var isBlogMainImageURLEmpty: Bool {
        blogMainImageURL.isEmpty
    }
    
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
    
    //Network
    func patchBlog() async {
        do {
            try await NetworkRepository.shared.patchBlog(blogName: blogName, description: blogDescription)
            // UserName update
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func postImage() async {
        do {
            if let _ = mainImage {
                let blogMainImageURL = try await NetworkRepository.shared.postImage(mainImage!)
                print("Uploaded file URL: \(blogMainImageURL)")
            }
        } catch {
            print("Error uploading image: \(error.localizedDescription)")
        }
    }
}
