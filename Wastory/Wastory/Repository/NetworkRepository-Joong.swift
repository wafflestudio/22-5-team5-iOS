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
    func patchUsername(newUsername: String) async throws {
        let requestBody = [
            "username": newUsername
        ]
        var urlRequest = try URLRequest(
            url: NetworkRouter.patchUsername.url,
            method: NetworkRouter.patchUsername.method,
            headers: NetworkRouter.patchUsername.headers
        )
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest, body: requestBody)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingString()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getMe() async throws -> User {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getMe.url,
            method: NetworkRouter.getMe.method,
            headers: NetworkRouter.getMe.headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(User.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
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

    func patchBlog(blogName: String, description: String, mainImageURL: String?) async throws {
        var requestBody = [String: String]()
        if mainImageURL == nil {
            requestBody = [
                "blog_name": blogName,
                "description": description,
            ]
        } else {
            requestBody = [
                "blog_name": blogName,
                "description": description,
                "main_image_URL": mainImageURL!
            ]
        }
        
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
    
    func searchBlogs(searchingWord: String, page: Int) async throws -> BlogListDto {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.searchBlogs.url,
            method:  NetworkRouter.searchBlogs.method,
            headers: NetworkRouter.searchBlogs.headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "keywords", value: searchingWord),
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
        .serializingDecodable(BlogListDto.self, decoder: decoder)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    // MARK: - Category
    func postCategory(categoryName: String, parentID: Int?) async throws {
        var requestBody = [String: String]()
        if let _ = parentID {
            requestBody = [
                "categoryname": categoryName,
                "categoryLevel": "2",
                "parent_id": "\(parentID ?? 0)"
            ]
        } else {
            requestBody = [
                "categoryname": categoryName,
                "categoryLevel": "1"
            ]
        }
        
        var urlRequest = try URLRequest(
            url: NetworkRouter.postCategory.url,
            method: NetworkRouter.postCategory.method,
            headers: NetworkRouter.postCategory.headers
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
    
    func getCategoriesInBlog(blogID: Int) async throws -> [Category] {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getCategoriesInBlog(blogID: blogID).url,
            method: NetworkRouter.getCategoriesInBlog(blogID: blogID).method,
            headers: NetworkRouter.getCategoriesInBlog(blogID: blogID).headers
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
    
    func patchCategory(categoryName: String, categoryID: Int) async throws {
        let requestBody = [
            "categoryname": categoryName
        ]
        
        var urlRequest = try URLRequest(
            url: NetworkRouter.patchCategory(categoryID: categoryID).url,
            method: NetworkRouter.patchCategory(categoryID: categoryID).method,
            headers: NetworkRouter.patchCategory(categoryID: categoryID).headers
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
    
    func deleteCategory(categoryID: Int) async throws {
        let urlRequest = try URLRequest(
            url: NetworkRouter.deleteCategory(categoryID: categoryID).url,
            method: NetworkRouter.deleteCategory(categoryID: categoryID).method,
            headers: NetworkRouter.deleteCategory(categoryID: categoryID).headers
        )
        
        logRequest(urlRequest)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getCategory(categoryID: Int) async throws -> Category {
        let urlRequest = try URLRequest(
            url:     NetworkRouter.getCategory(categoryID: categoryID).url,
            method:  NetworkRouter.getCategory(categoryID: categoryID).method,
            headers: NetworkRouter.getCategory(categoryID: categoryID).headers
        )
        
        logRequest(urlRequest)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(Category.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
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
    
    func getArticle(postID: Int) async throws -> Post {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getArticle(postID: postID).url,
            method: NetworkRouter.getArticle(postID: postID).method,
            headers: NetworkRouter.getArticle(postID: postID).headers
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
        .serializingDecodable(Post.self, decoder: decoder)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func getArticlesTodayWastory() async throws -> [Post] {
        var urlRequest = try URLRequest(
            url: NetworkRouter.getArticlesTodayWastory.url,
            method: NetworkRouter.getArticlesTodayWastory.method,
            headers: NetworkRouter.getArticlesTodayWastory.headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "page", value: "1")
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
    
    func getArticlesWeeklyWastory() async throws -> [Post] {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getArticlesWeeklyWastory.url,
            method: NetworkRouter.getArticlesWeeklyWastory.method,
            headers: NetworkRouter.getArticlesWeeklyWastory.headers
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
    
    func getArticlesHomeTopic(highHomeTopicID: Int) async throws -> [Post] {
        var urlRequest = try URLRequest(
            url: NetworkRouter.getArticlesHomeTopic(highHomeTopicID: highHomeTopicID).url,
            method: NetworkRouter.getArticlesHomeTopic(highHomeTopicID: highHomeTopicID).method,
            headers: NetworkRouter.getArticlesHomeTopic(highHomeTopicID: highHomeTopicID).headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "high_hometopic_id", value: "\(highHomeTopicID)"),
                URLQueryItem(name: "page", value: "1")
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
    
    func getFocusArticles1() async throws -> [Post] { //J의 주말 계획
        let urlRequest = try URLRequest(
            url:     NetworkRouter.getFocusArticles1.url,
            method:  NetworkRouter.getFocusArticles1.method,
            headers: NetworkRouter.getFocusArticles1.headers
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
    
    func getFocusArticles2() async throws -> [Post] { //오후에는 커피 한 잔
        let urlRequest = try URLRequest(
            url:     NetworkRouter.getFocusArticles2.url,
            method:  NetworkRouter.getFocusArticles2.method,
            headers: NetworkRouter.getFocusArticles2.headers
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
    
    func getArticlesOfSubscription(blogID: Int, page: Int) async throws -> [Post] {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.getArticlesOfSubscription(blogID: blogID).url,
            method:  NetworkRouter.getArticlesOfSubscription(blogID: blogID).method,
            headers: NetworkRouter.getArticlesOfSubscription(blogID: blogID).headers
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
    
    func searchArticlesInBlog(searchingWord: String, blogID: Int, page: Int) async throws -> PostListDto {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.searchArticlesInBlog(searchingWord: searchingWord, blogID: blogID).url,
            method:  NetworkRouter.searchArticlesInBlog(searchingWord: searchingWord, blogID: blogID).method,
            headers: NetworkRouter.searchArticlesInBlog(searchingWord: searchingWord, blogID: blogID).headers
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
        
        return response
    }
    
    func searchArticles(searchingWord: String, page: Int) async throws -> PostListDto {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.searchArticles(searchingWord: searchingWord).url,
            method:  NetworkRouter.searchArticles(searchingWord: searchingWord).method,
            headers: NetworkRouter.searchArticles(searchingWord: searchingWord).headers
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
        
        return response
    }
    
    // MARK: - Comment
    func postComment(postID: Int, content: String, parentID: Int?, isSecret: Bool) async throws {
        var requestBody = [String: String]()
        if let _ = parentID {
            requestBody = [
                "content": content,
                "parent_id": "\(parentID!)",
                "secret": "\(isSecret ? 1 : 0)",
                "level": "\(parentID ?? 0 == 0 ? 1 : 2)"
            ]
        } else {
            requestBody = [
                "content": content,
                "secret": "\(isSecret ? 1 : 0)",
                "level": "\(parentID ?? 0 == 0 ? 1 : 2)"
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
    
    func postGuestBookComment(blogID: Int, content: String, parentID: Int?, isSecret: Bool) async throws {
        var requestBody = [String: String]()
        if let _ = parentID {
            requestBody = [
                "content": content,
                "parent_id": "\(parentID!)",
                "secret": "\(isSecret ? 1 : 0)",
                "level": "\(parentID ?? 0 == 0 ? 1 : 2)"
            ]
        } else {
            requestBody = [
                "content": content,
                "secret": "\(isSecret ? 1 : 0)",
                "level": "\(parentID ?? 0 == 0 ? 1 : 2)"
            ]
        }
        var urlRequest = try URLRequest(
            url: NetworkRouter.postGuestBookComment(blogID: blogID).url,
            method: NetworkRouter.postGuestBookComment(blogID: blogID).method,
            headers: NetworkRouter.postGuestBookComment(blogID: blogID).headers
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
    
    func getGuestBookComments(blogID: Int, page: Int) async throws -> CommentListDto {
        let urlRequest = try URLRequest(
            url: NetworkRouter.getGuestBookComments(blogID: blogID, page: page).url,
            method: NetworkRouter.getGuestBookComments(blogID: blogID, page: page).method,
            headers: NetworkRouter.getGuestBookComments(blogID: blogID, page: page).headers
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
    
    func patchComment(commentID: Int, content: String) async throws {
        var urlRequest = try URLRequest(
            url: NetworkRouter.patchComment(commentID: commentID).url,
            method: NetworkRouter.patchComment(commentID: commentID).method,
            headers: NetworkRouter.patchComment(commentID: commentID).headers
        )
        
        let requestBody = [
            "content": content
        ]
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func deleteComment(commentID: Int) async throws {
        let urlRequest = try URLRequest(
            url: NetworkRouter.deleteComment(commentID: commentID).url,
            method: NetworkRouter.deleteComment(commentID: commentID).method,
            headers: NetworkRouter.deleteComment(commentID: commentID).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    // MARK: - Notification
    func getNotifications(page: Int, type: Int? = nil) async throws -> [Noti] {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.getNotifications.url,
            method:  NetworkRouter.getNotifications.method,
            headers: NetworkRouter.getNotifications.headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            
            if type ?? 0 == 0 {
                components?.queryItems = [
                    URLQueryItem(name: "page", value: "\(page)"),
                ]
            } else {
                components?.queryItems = [
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "type", value: "\(type ?? 0)")
                ]
            }
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
            .serializingDecodable(NotiListDto.self, decoder: decoder)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response.notifications
    }
    
    func patchNotification(notificationID: Int) async throws {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.patchNotification.url,
            method:  NetworkRouter.patchNotification.method,
            headers: NetworkRouter.patchNotification.headers
        )
        
        let requestBody = [
            "notification_id": "\(notificationID)"
        ]
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func deleteNotification(notificationID: Int) async throws {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.deleteNotification.url,
            method:  NetworkRouter.deleteNotification.method,
            headers: NetworkRouter.deleteNotification.headers
        )
        
        let requestBody = [
            "notification_id": "\(notificationID)"
        ]
        urlRequest.httpBody = try JSONEncoder().encode(requestBody)
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    // MARK: - Subscription
    func postSubscription(blogID: Int) async throws {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.postSubscription.url,
            method:  NetworkRouter.postSubscription.method,
            headers: NetworkRouter.postSubscription.headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "subscribed_id", value: "\(blogID)")
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func deleteSubscription(blogAddress: String) async throws {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.deleteSubscription.url,
            method:  NetworkRouter.deleteSubscription.method,
            headers: NetworkRouter.deleteSubscription.headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "subscribed_address_name", value: blogAddress)
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingData()
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    func getMySubscribingBlogs(page: Int) async throws -> BlogListDto {
        let urlRequest = try URLRequest(
            url:     NetworkRouter.getMySubscribingBlogs(page:  page).url,
            method:  NetworkRouter.getMySubscribingBlogs(page:  page).method,
            headers: NetworkRouter.getMySubscribingBlogs(page:  page).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(BlogListDto.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func getMySubscriberBlogs(page: Int) async throws -> BlogListDto {
        let urlRequest = try URLRequest(
            url:     NetworkRouter.getMySubscriberBlogs(page: page).url,
            method:  NetworkRouter.getMySubscriberBlogs(page: page).method,
            headers: NetworkRouter.getMySubscriberBlogs(page: page).headers
        )
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(BlogListDto.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func getSubscribingBlogs(blogID: Int, page: Int) async throws -> BlogListDto {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.getSubscribingBlogs(page: page).url,
            method:  NetworkRouter.getSubscribingBlogs(page: page).method,
            headers: NetworkRouter.getSubscribingBlogs(page: page).headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "blog_id", value: "\(blogID)")
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(BlogListDto.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func getSubscriberBlogs(blogID: Int, page: Int) async throws -> BlogListDto {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.getSubscriberBlogs(page: page).url,
            method:  NetworkRouter.getSubscriberBlogs(page: page).method,
            headers: NetworkRouter.getSubscriberBlogs(page: page).headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "blog_id", value: "\(blogID)")
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(BlogListDto.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response
    }
    
    func getIsSubscribing(BlogID: Int) async throws -> Bool {
        var urlRequest = try URLRequest(
            url:     NetworkRouter.getIsSubscribing.url,
            method:  NetworkRouter.getIsSubscribing.method,
            headers: NetworkRouter.getIsSubscribing.headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "subscribed_id", value: "\(BlogID)")
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(SubscriptionDto.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response.isSubscribing
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
    
    func deleteLike(postID: Int) async throws {
        let urlRequest = try URLRequest(
            url: NetworkRouter.deleteLike(postID: postID).url,
            method: NetworkRouter.deleteLike(postID: postID).method,
            headers: NetworkRouter.deleteLike(postID: postID).headers
        )
        
        logRequest(urlRequest)
        
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
            "file_name": "wastory.jpg",
            "file_type": "image/jpeg"
        ]
        
        var preUrlRequest = try URLRequest(
            url: NetworkRouter.generatePreURL.url,
            method: NetworkRouter.generatePreURL.method,
            headers: NetworkRouter.generatePreURL.headers
        )
        preUrlRequest.httpBody = try JSONEncoder().encode(preRequestBody)
        
        logRequest(preUrlRequest, body: preRequestBody)
        
        // 서버로 요청
        let preResponse = try await AF.request(
            preUrlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(PresignedURLDto.self)
        .value
        
        logResponse(preResponse, url: preUrlRequest.url?.absoluteString ?? "unknown")
        
        let urlRequest = try URLRequest(
            url: preResponse.presignedURL,
            method: NetworkRouter.uploadImage.method,
            headers: NetworkRouter.uploadImage.headers
        )
        
        logRequest(urlRequest)
        
        AF.upload(imageData, with: urlRequest)
            .validate()
            .response { response in
                if let error = response.error {
                    print("Error details: \(error.localizedDescription)")
                } else {
                    print("업로드 성공!")
                }
            }
        
        
        logResponse(urlRequest, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return preResponse.fileURL
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
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
    
    func deleteImage(fileURL: String) async throws {
        var urlRequest = try URLRequest(
            url: NetworkRouter.deleteImage.url,
            method: NetworkRouter.deleteImage.method,
            headers: NetworkRouter.deleteImage.headers
        )
        
        if let url = urlRequest.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [
                URLQueryItem(name: "file_url", value: fileURL)
            ]
            urlRequest.url = components?.url
        }
        
        logRequest(urlRequest)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
        .serializingDecodable(ImageDeleteDto.self)
        .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
    }
    
    // MARK: - HomeTopic
    func getHomeTopicList() async throws -> [HomeTopic] {
        let urlRequest = try URLRequest(
            url:     NetworkRouter.getHomeTopicList.url,
            method:  NetworkRouter.getHomeTopicList.method,
            headers: NetworkRouter.getHomeTopicList.headers
        )
        
        logRequest(urlRequest)
        
        // 응답 데이터 확인
        let response = try await AF.request(
            urlRequest,
            interceptor: NetworkInterceptor()
        ).validate()
            .serializingDecodable(HomeTopicListDto.self)
            .value
        
        logResponse(response, url: urlRequest.url?.absoluteString ?? "unknown")
        
        return response.hometopics
    }
}
