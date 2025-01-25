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
    case postEmailExists
    case postSignUp
    case postSignIn
    case deleteMe
    case patchPassword(oldPW: String, newPW: String)
    
    // MARK: Blog
    case postBlog
    case getMyBlog
    case getBlog(blogAddress: String)
    case getBlogByID(blogID: Int)
    case patchBlog(blogAddress: String)
    
    // MARK: Category
    case postCategory
    case getCategoriesInBlog(blogID: Int)
    case patchCategory(categoryID: Int)
    case deleteCategory(categoryID: Int)
    
    // MARK: Article
    case postArticle
    case getArticlesInBlog(blogID: Int)
    case getTopArticlesInBlog(blogID: Int, sortBy: String)
    case getArticlesInBlogInCategory(blogID: Int, categoryID: Int, page: Int)
    
    
    //MARK: Comment
    case postComment(postID: Int)
    case getArticleComments(postID: Int, page: Int)
    
    //MARK: Like
    case postLike
    case getIsLiked(postID: Int)
    
    
    
    var url: URL {
        URL(string: NetworkConfiguration.baseURL + self.path)!
    }
    
    var path: String {
        switch self {
        // MARK: User
        case .postEmailExists: "/users/email-exists"
        case .postSignUp: "/users/signup"
        case .postSignIn: "/users/signin"
        case .deleteMe: "/users/me"
        case .patchPassword: "/users/change_password"
            
        // MARK: Blog
        case .postBlog: "/blogs"
        case .getMyBlog: "/blogs/my_blog"
        case let .getBlog(blogAddress): "/blogs/\(blogAddress)"
        case let .getBlogByID(blogID): "/blogs/by_id/\(blogID)"
        case let .patchBlog(blogAddress): "/blogs/\(blogAddress)"
            
        // MARK: Category
        case .postCategory: "/categories/create"
        case let .getCategoriesInBlog(blogID): "/categories/list/\(blogID)"
        case let .patchCategory(categoryID): "/categories/\(categoryID)"
        case let .deleteCategory(categoryID): "/categories/\(categoryID)"
        
        // MARK: Article
        case .postArticle: "/articles/create"
        case let .getArticlesInBlog(blogID): "/articles/blogs/\(blogID)"
        case let .getTopArticlesInBlog(blogID, sortBy): "/articles/blogs/\(blogID)/sort_by/\(sortBy)"
        case let .getArticlesInBlogInCategory(blogID: blogID, categoryID: categoryID, page: _): "/articles/blogs/\(blogID)/categories/\(categoryID)"
            
        // MARK: Comment
        case let .postComment(postID): "/comments/article/\(postID)"
        case let .getArticleComments(postID, page): "/comments/article/\(postID)/\(page)"
            
        //MARK: Like
        case .postLike: "/likes/create"
        case let .getIsLiked(postID): "/likes/blog/press_like/\(postID)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        // MARK: User
        case .postEmailExists:
            return .post
        case .postSignUp:
            return .post
        case .postSignIn:
            return .post
        case .deleteMe:
            return .delete
        case .patchPassword:
            return .patch
            
        // MARK: Blog
        case .postBlog:
            return .post
        case .getMyBlog:
            return .get
        case .getBlog:
            return .get
        case .getBlogByID:
            return .get
        case .patchBlog:
            return .patch
            
        // MARK: Category
        case .postCategory:
            return .post
        case .getCategoriesInBlog:
            return .get
        case .patchCategory:
            return .patch
        case .deleteCategory:
            return .delete
        
        // MARK: Article
        case .postArticle:
            return .post
        case .getArticlesInBlog:
            return .get
        case .getTopArticlesInBlog:
            return .get
        case .getArticlesInBlogInCategory:
            return .get
            
        // MARK: Comment
        case .postComment:
            return .post
        case .getArticleComments:
            return .get
            
        //MARK: Like
        case .postLike:
            return .post
        case .getIsLiked:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            // MARK: User
        case .postEmailExists:
            return ["Content-Type": "application/json"]
        case .postSignUp:
            return ["Content-Type": "application/json"]
        case .postSignIn:
            return ["Content-Type": "application/json"]
        case .deleteMe:
            return ["Content-Type": "application/json"]
        case .patchPassword:
            return ["Content-Type": "application/json"]
            
            // MARK: Blog
        case .postBlog:
            return ["Content-Type": "application/json"]
        case .getMyBlog:
            return ["Content-Type": "application/json"]
        case .getBlog:
            return ["Content-Type": "application/json"]
        case .getBlogByID:
            return ["Content-Type": "application/json"]
        case .patchBlog:
            return ["Content-Type": "application/json"]
            
        // MARK: Category
        case .postCategory:
            return ["Content-Type": "application/json"]
        case .getCategoriesInBlog:
            return ["Content-Type": "application/json"]
        case .patchCategory:
            return ["Content-Type": "application/json"]
        case .deleteCategory:
            return ["Content-Type": "application/json"]
        
        // MARK: Article
        case .postArticle:
            return ["Content-Type": "application/json"]
        case .getArticlesInBlog:
            return ["Content-Type": "application/json"]
        case .getTopArticlesInBlog:
            return ["Content-Type": "application/json"]
        case .getArticlesInBlogInCategory:
            return ["Content-Type": "application/json"]
            
            
        // MARK: Comment
        case .postComment:
            return ["Content-Type": "application/json"]
        case .getArticleComments:
            return ["Content-Type": "application/json"]
        
        //MARK: Like
        case .postLike:
            return ["Content-Type": "application/json"]
        case .getIsLiked:
            return ["Content-Type": "application/json"]
        }
    }
}
