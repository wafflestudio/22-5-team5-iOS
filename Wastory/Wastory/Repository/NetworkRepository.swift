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

    func postSignUp(userID: String, userPW: String) async throws -> String {
        let requestBody = PostSignUp(username: String(userID.split(separator: "@").first ?? ""), email: userID, password: userPW)
        var urlRequest = try URLRequest(
            url: NetworkRouter.postSignUp.url,
            method: NetworkRouter.postSignUp.method,
            headers: NetworkRouter.postSignUp.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString().value
        
        return response
    }
    
    func postSignIn(userID: String, userPW: String) async throws -> PostSignInResponse {
        let requestBody = PostSignIn(username: userID, password: userPW)
        var urlRequest = try URLRequest(
            url: NetworkRouter.postSignIn.url,
            method: NetworkRouter.postSignIn.method,
            headers: NetworkRouter.postSignIn.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingDecodable(PostSignInResponse.self).value
        
        return response
    }
}

// 연결 확인을 위한 임시 구조체
struct PostSignUp: Codable {
    let username: String
    let email: String
    let password: String
}

struct PostSignIn: Codable {
    let username: String
    let password: String
}

struct PostSignInResponse: Codable {
    let access_token: String
    let refresh_token: String
}
