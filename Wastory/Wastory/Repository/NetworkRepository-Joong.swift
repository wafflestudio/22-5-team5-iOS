//
//  NetworkRepository.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import SwiftUI
import Foundation
import Alamofire

extension NetworkRepository {
    // MARK: - Debugging Helpers
    private func logRequest(_ urlRequest: URLRequest, body: Any? = nil) {
        print("\n🌐 ━━━ Network Request ━━━")
        print("📍 URL: \(urlRequest.url?.absoluteString ?? "nil")")
        print("📝 Method: \(urlRequest.method?.rawValue ?? "nil")")
        print("📋 Headers: \(urlRequest.headers)")
        if let body = body {
            print("📦 Body: \(body)")
        }
        print("━━━━━━━━━━━━━━━━━━━━━")
    }
    
    private func logResponse<T>(_ response: T, url: String) {
        print("\n✨ ━━━ Network Response ━━━")
        print("📍 URL: \(url)")
        print("📦 Response: \(response)")
        print("━━━━━━━━━━━━━━━━━━━━━\n")
    }
    
//    func createCategroy(categoryName: String, categoryLevel: Int, parentId: Int?) {
//        let requestBody = [
//            "categoryname": categoryName,
//            "categorylevel": categoryLevel,
//            "parent_id": parentId ??
//        ] as [String : Any]
//        var urlRequest = try URLRequest(
//            url: NetworkRouter.postSignUp.url,
//            method: NetworkRouter.postSignUp.method,
//            headers: NetworkRouter.postSignUp.headers
//        )
//        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
//
//        _ = try await AF.request(urlRequest)
//            .validate()
//            .serializingString().value
//    }
    
    // MARK: - Blog
    func getBlogByID(blogID: Int) async throws -> Blog {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getBlogByID(blogID: blogID).url,
            method: NetworkRouter.getBlogByID(blogID: blogID).method,
            headers: NetworkRouter.getBlogByID(blogID: blogID).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(Blog.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }

    func patchBlog(blogName: String, description: String) async throws {
        let requestBody = [
            "blog_name": blogName,
            "description": description,
        ]
        
        let myBlogAddress = UserInfoRepository.shared.getAddressName()
        print(myBlogAddress)
        var urlRequest = try URLRequest(
            url: NetworkRouter.patchBlog(blogAddress: myBlogAddress).url,
            method: NetworkRouter.patchBlog(blogAddress: myBlogAddress).method,
            headers: NetworkRouter.patchBlog(blogAddress: myBlogAddress).headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    // MARK: - Article
    func getTopArticlesInBlog(blogID: Int, sortBy: String) async throws -> [Post] {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getTopArticlesInBlog(blogID: blogID, sortBy: sortBy).url,
            method: NetworkRouter.getTopArticlesInBlog(blogID: blogID, sortBy: sortBy).method,
            headers: NetworkRouter.getTopArticlesInBlog(blogID: blogID, sortBy: sortBy).headers
        )
        
        logRequest(urlRequest)
        
        // ISO8601DateFormatter로 날짜 처리
        let decoder = JSONDecoder()
        
        // DateFormatter를 사용하여 ISO8601 형식을 맞추기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(PostListDto.self, decoder: decoder)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response.articles
    }
    
    func getArticlesInBlogInCategory(blogID: Int, categoryID: Int, page: Int) async throws -> [Post] {
        var urlRequest = try URLRequest(
            url: NetworkRouter.getArticlesInBlogInCategory(blogID: blogID, categoryID: categoryID, page: page).url,
            method: NetworkRouter.getArticlesInBlogInCategory(blogID: blogID, categoryID: categoryID, page: page).method,
            headers: NetworkRouter.getArticlesInBlogInCategory(blogID: blogID, categoryID: categoryID, page: page).headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "page", value: "\(page)")
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        // ISO8601DateFormatter로 날짜 처리
        let decoder = JSONDecoder()
        
        // DateFormatter를 사용하여 ISO8601 형식을 맞추기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(PostListDto.self, decoder: decoder)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response.articles
        
    }
        
    
    // MARK: - Comment
    func postComment(postID: Int, content: String, parentID: Int?, isSecret: Bool) async throws {
        var requestBody = [String: String]()
        if let _ = parentID {
            requestBody = [
                "content": content,
                "parent_id": "\(parentID!)",
                "secret": "\(isSecret ? 1 : 0)",
                "level": "\(parentID ?? 0 == 0 ? 0 : 1)"
            ]
        } else {
            requestBody = [
                "content": content,
                "secret": "\(isSecret ? 1 : 0)",
                "level": "\(parentID ?? 0 == 0 ? 0 : 1)"
            ]
        }
        var urlRequest = try URLRequest(
            url: NetworkRouter.postComment(postID: postID).url,
            method: NetworkRouter.postComment(postID: postID).method,
            headers: NetworkRouter.postComment(postID: postID).headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getArticleComments(postID: Int, page: Int) async throws -> CommentListDto {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getArticleComments(postID: postID, page: page).url,
            method: NetworkRouter.getArticleComments(postID: postID, page: page).method,
            headers: NetworkRouter.getArticleComments(postID: postID, page: page).headers
        )
        
        logRequest(urlRequest)
        
        // ISO8601DateFormatter로 날짜 처리
        let decoder = JSONDecoder()
        
        // DateFormatter를 사용하여 ISO8601 형식을 맞추기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(CommentListDto.self, decoder: decoder)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    // MARK: - Like
    func postLike(postID: Int) async throws {
        let requestBody = [
            "article_id": postID
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postLike.url,
            method: NetworkRouter.postLike.method,
            headers: NetworkRouter.postLike.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getIsLiked(postID: Int) async throws -> Bool { //Blog Press Like
        let urlRequest = try URLRequest(
            url: NetworkRouter.getIsLiked(postID: postID).url,
            method: NetworkRouter.getIsLiked(postID: postID).method,
            headers: NetworkRouter.getIsLiked(postID: postID).headers
        )
        
        logRequest(urlRequest)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(Bool.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    // MARK: - Image
    func postImage(_ image: UIImage) async throws -> String {
        // 이미지를 리사이즈
        guard let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 800, height: 800)) else {
            throw NSError(domain: "ImageResizeError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to resize the image."])
        }
        
        // 리사이즈된 이미지를 JPEG 데이터로 변환
        guard let imageData = resizedImage.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ImageConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert the image to JPEG data."])
        }
        
        // 압축된 이미지 크기 출력
        print("압축된 이미지 크기: \(imageData.count / 1024) KB")
        
        //presigned-urls
        let preRequestBody = [
            "file_name": "wastory",
            "file_type": "jpeg"
        ]
        
        var preUrlRequest = try URLRequest(
            url: NetworkRouter.generatePreURL.url,
            method: NetworkRouter.generatePreURL.method,
            headers: NetworkRouter.generatePreURL.headers
        )
        preUrlRequest.httpBody = try JSONEncoder().encode(preRequestBody)
        
        logRequest(preUrlRequest, body: preRequestBody)
//        let urlRequest = try URLRequest(
//            url: NetworkRouter.postImage.url,
//            method: NetworkRouter.postImage.method,
//            headers: NetworkRouter.postImage.headers
//        )
        
        
        // 서버로 요청
        let preResponse = try await AF.request(
            preUrlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(PresignedURLDto.self)
        .value
        
        
        logResponse(preResponse, url: preUrlRequest.url?.absoluteString ?? "unknown")

        return preResponse.presignedURL
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        //        let size = image.size
        //
        //        let widthRatio = targetSize.width / size.width
        //        let heightRatio = targetSize.height / size.height
        //
        //        let newSize = CGSize(
        //            width: size.width * min(widthRatio, heightRatio),
        //            height: size.height * min(widthRatio, heightRatio)
        //        )
        //
        //        let renderer = UIGraphicsImageRenderer(size: newSize)
        //        return renderer.image { _ in
        //            image.draw(in: CGRect(origin: .zero, size: newSize))
        //        }
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        let imageData = resizedImage.jpegData(compressionQuality: 0.8)
        
        if imageData!.count >= 1 * 1024 * 1024 {
            print("\(imageData!.count / 1024)KB")
            return resizeImage(image: resizedImage, targetSize: CGSize(width: newSize.width * 0.9, height: newSize.height * 0.9))
        }

        return resizedImage
    }

}
