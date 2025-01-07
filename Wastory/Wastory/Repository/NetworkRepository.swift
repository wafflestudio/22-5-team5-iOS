//
//  NetworkRepository.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import Foundation
import Alamofire

final class NetworkRepository {
    static let shared = UserInfoRepository()    // 싱글톤 인스턴스

    func postSignUp(userID: String, userPW: String) async throws -> String {
        let requestBody = PostSignUp(username: "", email: userID, password: userPW)
        var urlRequest = try URLRequest(url: NetworkRouter.postSignUp.url, method: NetworkRouter.postSignUp.method, headers: NetworkRouter.postSignUp.headers)
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        let response = try await AF.request(urlRequest)
            .validate()
            .serializingString().value
        
        return response
    }
    
    func getSignIn(userID: String, userPW: String) async throws -> String {
        
        return ""
    }
}

// 연결 확인을 위한 임시 구조체
struct PostSignUp: Codable {
    let username: String
    let email: String
    let password: String
}
