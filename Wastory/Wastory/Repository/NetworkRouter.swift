//
//  NetworkRouter.swift
//  Wastory
//
//  Created by mujigae on 1/7/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    // MARK: User
    case postSignUp
    case postSignIn
    
    // MARK: Blog
    case postBlog
    case getMyBlog
    case getBlog(blogAddress: String)
    
    // MARK: Blog
    case postArticle
    case getArticlesInBlog(blogID: Int)
    
    //MARK: Comment
    case postComment(postID: Int)
    case getArticleComments(postID: Int, page: Int)
    
    
    
    var url: URL {
        URL(string: NetworkConfiguration.baseURL + self.path)!
    }
    
    var path: String {
        switch self {
        // MARK: User
        case .postSignUp: "/users/signup"
        case .postSignIn: "/users/signin"
            
        // MARK: Blog
        case .postBlog: "/blogs"
        case .getMyBlog: "/blogs/my_blog"
        case let .getBlog(blogAddress): "/blogs/\(blogAddress)"
        
        // MARK: Article
        case .postArticle: "/articles/create"
        case let .getArticlesInBlog(blogID): "/articles/blogs/\(blogID)"
            
        // MARK: Comment
        case let .postComment(postID): "/comments/article/\(postID)"
        case let .getArticleComments(postID, page): "/comments/article/\(postID)/\(page)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        // MARK: User
        case .postSignUp:
            return .post
        case .postSignIn:
            return .post
            
        // MARK: Blog
        case .postBlog:
            return .post
        case .getMyBlog:
            return .get
        case .getBlog:
            return .get
        
        // MARK: Article
        case .postArticle:
            return .post
        case .getArticlesInBlog:
            return .get
        
        // MARK: Comment
        case .postComment:
            return .post
        case .getArticleComments:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        // MARK: User
        case .postSignUp:
            return ["Content-Type": "application/json"]
        case .postSignIn:
            return ["Content-Type": "application/json"]
            
        // MARK: Blog
        case .postBlog:
            return ["Content-Type": "application/json"]
        case .getMyBlog:
            return ["Content-Type": "application/json"]
        case .getBlog:
            return ["Content-Type": "application/json"]
            
        // MARK: Article
        case .postArticle:
            return ["Content-Type": "application/json"]
        case .getArticlesInBlog:
            return ["Content-Type": "application/json"]
            
            
        // MARK: Comment
        case .postComment:
            return ["Content-Type": "application/json"]
        case .getArticleComments:
            return ["Content-Type": "application/json"]
        }
    }
}
