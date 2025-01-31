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
    
    // MARK: - User
    
    
    // MARK: - Blog
    
    
    // MARK: - Category
    
    
    // MARK: - Article

    
    // MARK: - Comment
    
    
    // MARK: - Notification
    
    
    // MARK: - Subscription
    
    
    // MARK: - Like
    
    
    // MARK: - Image
    
    
    // MARK: - HomeTopic
    
    
}
