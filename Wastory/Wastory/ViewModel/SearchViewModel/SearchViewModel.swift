//
//  SearchViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/18/25.
//

import SwiftUI
import Observation


@Observable final class SearchViewModel {
    var isSearchingInBlog: Bool = false
    var searchingBlogID: Int?
    
    var isSearched: Bool = false
    var searchType: SearchType = .post
    var didOnAppear: Bool = false
    
    
    var searchKeyword: String = ""
    
    
    
    func setIsSearchingInBlog(_ blogID: Int?) {
        isSearchingInBlog = (blogID != nil)
        searchingBlogID = blogID
    }
    
    func setIsSearched(to bool: Bool) {
        isSearched = bool
    }
    
    
    
    func isSearchKeywordEmpty() -> Bool {
        searchKeyword == ""
    }
    
    func clearSearchKeyword() {
        searchKeyword = ""
    }
    
    func setPrevSearchKeyword(_ keyword: String?) {
        if !didOnAppear {
            searchKeyword = keyword ?? ""
        }
    }
    
    func doOnAppear() {
        didOnAppear = true
    }
    
    
    func setSearchType(to type: SearchType) {
        if searchType == type {
            return
        } else {
            searchType = type
            resetPage()
        }
    }
    
    func isSearchType(is type: SearchType) -> Bool {
        searchType == type
    }
    
    //pagination
    var page = 1
    var isPageEnded: Bool = false
    
    func resetPage() {
        page = 1
        isPageEnded = false
        searchPostResult = []
        searchBlogResult = []
    }
    
    
    //Network
    
    var searchPostResult: [Post] = [
    ]
    
    var searchBlogResult: [Blog] = [
    ]
    
    var resultCount: Int = 0
    
    
    func doSearch() {
        if !isSearchKeywordEmpty() {
            setIsSearched(to: true)
            
            if searchType == .post {
                Task {
                    await getSearchedArticles()
                }
            } else if searchType == .blog {
//                Task {
//                    await getSearchedBlogs()
//                }
            }
            
        }
    }
    
    
    
    
    
    func getSearchedArticles() async {
        do {
            var response = PostListDto.defaultPostListDto
            if searchingBlogID == nil {
                response = try await NetworkRepository.shared.searchArticles(searchingWord: searchKeyword, page: page)
            } else {
                response = try await NetworkRepository.shared.searchArticlesInBlog(searchingWord: searchKeyword, blogID: searchingBlogID!, page: page)
            }
            
            //posts 저장
            if self.page == 1 {
                searchPostResult = response.articles
                resultCount = response.totalCount
            } else {
                searchPostResult.append(contentsOf: response.articles)
            }
            
            //pagination
            if !response.articles.isEmpty {
                self.page += 1
            } else {
                self.isPageEnded = true
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
//    func getSearchedBlogs() async {
//        do {
//            let response = try await NetworkRepository.shared.getSearchedBlogs(searchingWord: searchKeyword, page: page)
//            
//            //posts 저장
//            if self.page == 1 {
//                searchBlogResult = response.blogs
//                resultCount = response.totalCount
//            } else {
//                searchBlogResult.append(contentsOf: response.blogs)
//            }
//            
//            //pagination
//            if !response.blogs.isEmpty {
//                self.page += 1
//            } else {
//                self.isPageEnded = true
//            }
//        } catch {
//            print("Error: \(error.localizedDescription)")
//        }
//    }
    
}

enum SearchType: String {
    case post
    case blog
    case tag
}

