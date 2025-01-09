//
//  NetworkRouter.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case postSignUp
    case postSignIn
    case getMyBlog
    case postBlog
    
    var url: URL {
        URL(string: NetworkConfiguration.baseURL + self.path)!
    }
    
    var path: String {
        switch self {
        case .postSignUp: "/users/signup"
        case .postSignIn: "/users/signin"
        case .getMyBlog: "/blogs/my_blog"
        case .postBlog: "/blogs"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postSignUp:
            return .post
        case .postSignIn:
            return .post
        case .getMyBlog:
            return .get
        case .postBlog:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .postSignUp:
            return ["Content-Type": "application/json"]
        case .postSignIn:
            return ["Content-Type": "application/json"]
        case .getMyBlog:
            return ["Content-Type": "application/json"]
        case .postBlog:
            return ["Content-Type": "application/json"]
        }
    }
    
    /* 파라미터가 필요한 API가 있을 경우 구현
    var parameters: Parameters? {
        switch self {
        }
    }
    */
}
