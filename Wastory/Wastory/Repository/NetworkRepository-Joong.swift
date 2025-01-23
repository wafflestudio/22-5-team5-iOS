//
//  NetworkRepository.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

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
    
    
}
