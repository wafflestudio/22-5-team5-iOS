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
    case postRequestVerification
    case postVerifyEmail
    case postEmailExists
    case postSignUp
    case postSignIn
    case getMe
    case deleteMe
    case patchPassword(oldPW: String, newPW: String)
    case patchUsername
    
    // MARK: Blog
    case postBlog
    case getMyBlog
    case getBlog(blogAddress: String)
    case getBlogByID(blogID: Int)
    case patchBlog(blogAddress: String)
    
    // MARK: Category
    case postCategory
    case getCategory(categoryID: Int)
    case patchCategory(categoryID: Int)
    case deleteCategory(categoryID: Int)
    case getCategoriesInUser
    case getCategoriesInBlog(blogID: Int)
    
    // MARK: Article
    case postArticle
    case getArticlesInBlog(blogID: Int)
    case getTopArticlesInBlog(blogID: Int, sortBy: String)
    case getArticlesInBlogInCategory(blogID: Int, categoryID: Int, page: Int)
    case getArticle(postID: Int)
    case getArticlesTodayWastory
    case getArticlesWeeklyWastory
    case getArticlesHomeTopic(highHomeTopicID: Int)
    case getArticlesOfSubscription(blogID: Int)
    case searchArticlesInBlog(searchingWord: String, blogID: Int)
    case searchArticles(searchingWord: String)
    
    //MARK: Comment
    case postComment(postID: Int)
    case getArticleComments(postID: Int, page: Int)
    case postGuestBookComment(blogID: Int)
    case getGuestBookComments(blogID: Int, page: Int)
    case patchComment(commentID: Int)
    case deleteComment(commentID: Int)
    
    // MARK: Subscription
    case postSubscription
    case deleteSubscription
    case getMySubscribingBlogs(page: Int)
    case getMySubscriberBlogs(page: Int)
    case getSubscribingBlogs(page: Int)
    case getSubscriberBlogs(page: Int)
    case getIsSubscribing
    
    //MARK: Like
    case postLike
    case getIsLiked(postID: Int)
    case deleteLike(postID: Int)
    
    //MARK: Image
    case generatePreURL
    case uploadImage
    case deleteImage
    
    // MARK: HomeTopic
    case getHomeTopicList
    
    // MARK: Draft
    case postDraft
    case patchDraft(draftID: Int)
    case getDraft(draftID: Int)
    case getDraftsInBlog(blogID: Int)
    case deleteDraft(draftID: Int)
    
    var url: URL {
        URL(string: NetworkConfiguration.baseURL + self.path)!
    }
    
    var path: String {
        switch self {
        // MARK: User
        case .postRequestVerification: "/users/request-verification"
        case .postVerifyEmail: "/users/verify-email"
        case .postEmailExists: "/users/email-exists"
        case .postSignUp: "/users/signup"
        case .postSignIn: "/users/signin"
        case .getMe: "/users/me"
        case .deleteMe: "/users/me"
        case .patchPassword: "/users/change_password"
        case .patchUsername: "/users/me"
            
        // MARK: Blog
        case .postBlog: "/blogs"
        case .getMyBlog: "/blogs/my_blog"
        case let .getBlog(blogAddress): "/blogs/\(blogAddress)"
        case let .getBlogByID(blogID): "/blogs/by_id/\(blogID)"
        case let .patchBlog(blogAddress): "/blogs/\(blogAddress)"
            
        // MARK: Category
        case .postCategory: "/categories/create"
        case let .getCategory(categoryID): "/categories/\(categoryID)"
        case let .patchCategory(categoryID): "/categories/\(categoryID)"
        case let .deleteCategory(categoryID): "/categories/\(categoryID)"
        case .getCategoriesInUser: "/categories/list/user"
        case let .getCategoriesInBlog(blogID): "/categories/list/\(blogID)"
        
        // MARK: Article
        case .postArticle: "/articles/create"
        case let .getArticlesInBlog(blogID): "/articles/blogs/\(blogID)"
        case let .getTopArticlesInBlog(blogID, sortBy): "/articles/blogs/\(blogID)/sort_by/\(sortBy)"
        case let .getArticlesInBlogInCategory(blogID: blogID, categoryID: categoryID, page: _): "/articles/blogs/\(blogID)/categories/\(categoryID)"
        case let .getArticle(postID): "/articles/get/\(postID)"
        case .getArticlesTodayWastory: "/articles/today_wastory"
        case .getArticlesWeeklyWastory: "/articles/weekly_wastory"
        case .getArticlesHomeTopic: "/articles/hometopic/{highHomeTopicID}"
        case let .getArticlesOfSubscription(blogID): "/articles/blogs/\(blogID)/subscription"
        case let .searchArticlesInBlog(searchingWord, blogID): "/articles/search/\(blogID)/\(searchingWord)"
        case let .searchArticles(searchingWord): "/articles/search/\(searchingWord)"
            
        // MARK: Comment
        case let .postComment(postID): "/comments/article/\(postID)"
        case let .getArticleComments(postID, page): "/comments/article/\(postID)/\(page)"
        case let .postGuestBookComment(blogID): "/comments/guestbook/\(blogID)"
        case let .getGuestBookComments(blogID, page): "/comments/guestbook/\(blogID)/\(page)"
        case let .patchComment(commentID): "/comments/\(commentID)"
        case let .deleteComment(commentID): "/comments/\(commentID)"
            
        // MARK: Subscription
        case .postSubscription: "/subscription"
        case .deleteSubscription: "/subscription"
        case let .getMySubscribingBlogs(page): "/subscription/my_subscriptions/\(page)"
        case let .getMySubscriberBlogs(page): "/subscription/my_subscribers/\(page)"
        case let .getSubscribingBlogs(page): "/subscription/subscriptions/\(page)"
        case let .getSubscriberBlogs(page): "/subscription/subscribers/\(page)"
        case .getIsSubscribing: "/subscription/is_subscribing"
            
        //MARK: Like
        case .postLike: "/likes/create"
        case let .getIsLiked(postID): "/likes/blog/press_like/\(postID)"
        case let .deleteLike(postID): "/likes/\(postID)"
            
        //MARK: Image
        case .generatePreURL: "/images/generate-presigned-urls"
        case .uploadImage: "presignedURL로 대체해서 사용합니다"
        case .deleteImage: "/images/deletes"
            
        // MARK: HomeTopic
        case .getHomeTopicList: "/hometopics/list"
            
        // MARK: Draft
        case .postDraft: "/drafts/create"
        case let .patchDraft(draftID): "/drafts/update/\(draftID)"
        case let .getDraft(draftID): "/drafts/get/\(draftID)"
        case let .getDraftsInBlog(blogID): "/drafts/blogs/\(blogID)"
        case let .deleteDraft(draftID): "/drafts/delete/\(draftID)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        // MARK: User
        case .postVerifyEmail:
            return .post
        case .postRequestVerification:
            return .post
        case .postEmailExists:
            return .post
        case .postSignUp:
            return .post
        case .postSignIn:
            return .post
        case .getMe:
            return .get
        case .deleteMe:
            return .delete
        case .patchPassword:
            return .patch
        case .patchUsername:
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
        case .getCategory:
            return .get
        case .patchCategory:
            return .patch
        case .deleteCategory:
            return .delete
        case .getCategoriesInUser:
            return .get
        case .getCategoriesInBlog:
            return .get
        
        // MARK: Article
        case .postArticle:
            return .post
        case .getArticlesInBlog:
            return .get
        case .getTopArticlesInBlog:
            return .get
        case .getArticlesInBlogInCategory:
            return .get
        case .getArticle:
            return .get
        case .getArticlesTodayWastory:
            return .get
        case .getArticlesWeeklyWastory:
            return .get
        case .getArticlesHomeTopic:
            return .get
        case .getArticlesOfSubscription:
            return .get
        case .searchArticlesInBlog:
            return .get
        case .searchArticles:
            return .get
            
        // MARK: Comment
        case .postComment:
            return .post
        case .getArticleComments:
            return .get
        case .postGuestBookComment:
            return .post
        case .getGuestBookComments:
            return .get
        case .patchComment:
            return .patch
        case .deleteComment:
            return .delete
        
        // MARK: Subscription
        case .postSubscription:
            return .post
        case .deleteSubscription:
            return .delete
        case .getMySubscribingBlogs:
            return .get
        case .getMySubscriberBlogs:
            return .get
        case .getSubscribingBlogs:
            return .get
        case .getSubscriberBlogs:
            return .get
        case .getIsSubscribing:
            return .get
            
        //MARK: Like
        case .postLike:
            return .post
        case .getIsLiked:
            return .get
        case .deleteLike:
            return .delete
          
        //MARK: Image
        case .generatePreURL:
            return .post
        case .uploadImage:
            return .put
        case .deleteImage:
            return .delete
            
        // MARK: HomeTopic
        case .getHomeTopicList:
            return .get
            
        // MARK: Draft
        case .postDraft:
            return .post
        case .patchDraft:
            return .patch
        case .getDraft:
            return .get
        case .getDraftsInBlog:
            return .get
        case .deleteDraft:
            return .delete
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        // MARK: User
        case .postVerifyEmail:
            return ["Content-Type": "application/json"]
        case .postRequestVerification:
            return ["Content-Type": "application/json"]
        case .postEmailExists:
            return ["Content-Type": "application/json"]
        case .postSignUp:
            return ["Content-Type": "application/json"]
        case .postSignIn:
            return ["Content-Type": "application/json"]
        case .getMe:
            return ["Content-Type": "application/json"]
        case .deleteMe:
            return ["Content-Type": "application/json"]
        case .patchPassword:
            return ["Content-Type": "application/json"]
        case .patchUsername:
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
        case .getCategory:
            return ["Content-Type": "application/json"]
        case .patchCategory:
            return ["Content-Type": "application/json"]
        case .deleteCategory:
            return ["Content-Type": "application/json"]
        case .getCategoriesInUser:
            return ["Content-Type": "application/json"]
        case .getCategoriesInBlog:
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
        case .getArticle:
            return ["Content-Type": "application/json"]
        case .getArticlesTodayWastory:
            return ["Content-Type": "application/json"]
        case .getArticlesWeeklyWastory:
            return ["Content-Type": "application/json"]
        case .getArticlesHomeTopic:
            return ["Content-Type": "application/json"]
        case .getArticlesOfSubscription:
            return ["Content-Type": "application/json"]
        case .searchArticlesInBlog:
            return ["Content-Type": "application/json"]
        case .searchArticles:
            return ["Content-Type": "application/json"]
            
        // MARK: Comment
        case .postComment:
            return ["Content-Type": "application/json"]
        case .getArticleComments:
            return ["Content-Type": "application/json"]
        case .postGuestBookComment:
            return ["Content-Type": "application/json"]
        case .getGuestBookComments:
            return ["Content-Type": "application/json"]
        case .patchComment:
            return ["Content-Type": "application/json"]
        case .deleteComment:
            return ["Content-Type": "application/json"]
            
        // MARK: Subscription
        case .postSubscription:
            return ["Content-Type": "application/json"]
        case .deleteSubscription:
            return ["Content-Type": "application/json"]
        case .getMySubscribingBlogs:
            return ["Content-Type": "application/json"]
        case .getMySubscriberBlogs:
            return ["Content-Type": "application/json"]
        case .getSubscribingBlogs:
            return ["Content-Type": "application/json"]
        case .getSubscriberBlogs:
            return ["Content-Type": "application/json"]
        case .getIsSubscribing:
            return ["Content-Type": "application/json"]
            
        //MARK: Like
        case .postLike:
            return ["Content-Type": "application/json"]
        case .getIsLiked:
            return ["Content-Type": "application/json"]
        case .deleteLike:
            return ["Content-Type": "application/json"]
          
        //MARK: Image
        case .generatePreURL:
            return ["Content-Type": "application/json"]
        case .uploadImage:
            return ["Content-Type": "image/jpeg"]
        case .deleteImage:
            return ["Content-Type": "application/json"]
            
        // MARK: HomeTopic
        case .getHomeTopicList:
            return ["Content-Type": "application/json"]
            
        // MARK: Draft
        case .postDraft:
            return ["Content-Type": "application/json"]
        case .patchDraft:
            return ["Content-Type": "application/json"]
        case .getDraft:
            return ["Content-Type": "application/json"]
        case .getDraftsInBlog:
            return ["Content-Type": "application/json"]
        case .deleteDraft:
            return ["Content-Type": "application/json"]
        }
    }
}
