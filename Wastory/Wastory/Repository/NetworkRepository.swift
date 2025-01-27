//
//  NetworkRepository.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import Foundation
import Alamofire

final class NetworkRepository {
    static let shared = NetworkRepository()    // 싱글톤 인스턴스
    
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
    
    // MARK: - User
    func postRequestVerification(email: String) async throws {
        let requestBody = [
            "email": email
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postRequestVerification.url,
            method: NetworkRouter.postRequestVerification.method,
            headers: NetworkRouter.postRequestVerification.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString()
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func postVerifyEmail(email: String, code: String) async throws -> Bool {
        let requestBody = [
            "email": email,
            "code": code
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postVerifyEmail.url,
            method: NetworkRouter.postVerifyEmail.method,
            headers: NetworkRouter.postVerifyEmail.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString()
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response == "\"True\""
    }
    
    func postEmailExists(email: String) async throws -> Bool {
        let requestBody = [
            "email": email
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postEmailExists.url,
            method: NetworkRouter.postEmailExists.method,
            headers: NetworkRouter.postEmailExists.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString()
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        // response: {"verification":???}
        return response[16..<response.count - 1] == "true"
    }
    
    func postSignUp(userID: String, userPW: String) async throws {
        let requestBody = [
            "email": userID,
            "password": userPW
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postSignUp.url,
            method: NetworkRouter.postSignUp.method,
            headers: NetworkRouter.postSignUp.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString()
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func postSignIn(userID: String, userPW: String) async throws -> TokenDto {
        let requestBody = [
            "email": userID,
            "password": userPW
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postSignIn.url,
            method: NetworkRouter.postSignIn.method,
            headers: NetworkRouter.postSignIn.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingDecodable(TokenDto.self)
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func deleteMe() async throws {
        let urlRequest = try URLRequest(
            url: NetworkRouter.deleteMe.url,
            method: NetworkRouter.deleteMe.method,
            headers: NetworkRouter.deleteMe.headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingString()
        .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func patchPassword(oldPW: String, newPW: String) async throws {
        let requestBody = [
            "old_password": oldPW,
            "new_password": newPW
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.patchPassword(oldPW: oldPW, newPW: newPW).url,
            method: NetworkRouter.patchPassword(oldPW: oldPW, newPW: newPW).method,
            headers: NetworkRouter.patchPassword(oldPW: oldPW, newPW: newPW).headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingString()
        .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    // MARK: - Blog
    func postBlog(addressName: String) async throws {
        let requestBody = [
            "address_name": addressName
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postBlog.url,
            method: NetworkRouter.postBlog.method,
            headers: NetworkRouter.postBlog.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(Blog.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getMyBlog() async throws -> Blog {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getMyBlog.url,
            method: NetworkRouter.getMyBlog.method,
            headers: NetworkRouter.getMyBlog.headers
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
    
    func getBlog(blogAddress: String) async throws -> Blog {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getBlog(blogAddress: blogAddress).url,
            method: NetworkRouter.getBlog(blogAddress: blogAddress).method,
            headers: NetworkRouter.getBlog(blogAddress: blogAddress).headers
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
    
    // MARK: - Category
    func getCategoriesInUser() async throws -> [Category] {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getCategoriesInUser.url,
            method: NetworkRouter.getCategoriesInUser.method,
            headers: NetworkRouter.getCategoriesInUser.headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(CategoryListDto.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response.categories
    }
    
    // MARK: - Article
    func postArticle(title: String, content: String, description: String, main_image_url: String, categoryID: Int, homeTopicID: Int, secret: Int) async throws {
        let requestBody = [
            "title": title,
            "content": content,
            "description": description,
            "main_image_url": main_image_url,
            "category_id": "\(categoryID)",
            "homeTopic_id": "\(homeTopicID)",
            "secret": "\(secret)"
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postArticle.url,
            method: NetworkRouter.postArticle.method,
            headers: NetworkRouter.postArticle.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getArticlesInBlog(blogID: Int, page: Int) async throws -> [Post] {
        var urlRequest = try URLRequest(
            url: NetworkRouter.getArticlesInBlog(blogID: blogID).url,
            method: NetworkRouter.getArticlesInBlog(blogID: blogID).method,
            headers: NetworkRouter.getArticlesInBlog(blogID: blogID).headers
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
    
    // MARK: - Draft
    func postDraft(title: String, content: String) async throws -> Draft {
        let requestBody = [
            "title": title,
            "content": content
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.postDraft.url,
            method: NetworkRouter.postDraft.method,
            headers: NetworkRouter.postDraft.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingDecodable(Draft.self)
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func patchDraft(title: String, content: String, draftID: Int) async throws {
        let requestBody = [
            "title": title,
            "content": content
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.patchDraft(draftID: draftID).url,
            method: NetworkRouter.patchDraft(draftID: draftID).method,
            headers: NetworkRouter.patchDraft(draftID: draftID).headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingDecodable(Draft.self)
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getDraft(draftID: Int) async throws -> Draft {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getDraft(draftID: draftID).url,
            method: NetworkRouter.getDraft(draftID: draftID).method,
            headers: NetworkRouter.getDraft(draftID: draftID).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingDecodable(Draft.self)
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func getDraftsInBlog(blogID: Int, page: Int) async throws -> DraftListDto {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getDraftsInBlog(blogID: blogID).url,
            method: NetworkRouter.getDraftsInBlog(blogID: blogID).method,
            headers: NetworkRouter.getDraftsInBlog(blogID: blogID).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest as! URLConvertible,
            parameters: [
                "page": page
            ]
        ).validate()
        .serializingDecodable(DraftListDto.self)
        .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func deleteDraft(draftID: Int) async throws {
        let urlRequest = try URLRequest(
            url: NetworkRouter.deleteDraft(draftID: draftID).url,
            method: NetworkRouter.deleteDraft(draftID: draftID).method,
            headers: NetworkRouter.deleteDraft(draftID: draftID).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString()
            .value
            
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
}
