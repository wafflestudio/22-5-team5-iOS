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
    
    var isSearched: Bool = false
    var searchType: SearchType = .post
    var didOnAppear: Bool = false
    
    
    var searchKeyword: String = ""
    
    
    
    func setIsSearchingInBlog(_ blogID: Int?) {
        isSearchingInBlog = (blogID != nil)
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
        searchType = type
    }
    
    func isSearchType(is type: SearchType) -> Bool {
        searchType == type
    }
    
    //Network
    
    var searchPostResult: [Post] = [
        Post.init(id: 1, blogID: 1, title: "asdfasdf", description: "asdfasdfasdfasdfasdfasdf", createdAt: Date(), commentCount: 5, likeCount: 55),
        Post.init(id: 2, blogID: 1, title: "asdf1asdf", description: "asdfa6sdfasdfasdfasdfasdf", createdAt: Date(), commentCount: 5, likeCount: 55),
        Post.init(id: 3, blogID: 1, title: "asdf2asdf", description: "asdf5asdfasdfasdfasdfasdf", createdAt: Date(), commentCount: 5, likeCount: 55),
        Post.init(id: 4, blogID: 1, title: "asdf3asdf", description: "asdf4asdfasdfasdfasdfasdf", createdAt: Date(), commentCount: 5, likeCount: 55),
        Post.init(id: 5, blogID: 1, title: "asdf4asdf", description: "asdfasdfasd3fasdfasdfasdf", createdAt: Date(), commentCount: 5, likeCount: 55),
        Post.init(id: 6, blogID: 1, title: "asd5fasdf", description: "asdfasdfa2sdfasdfasdfasdf", createdAt: Date(), commentCount: 5, likeCount: 55),
        Post.init(id: 7, blogID: 1, title: "as6dfasdf", description: "asdfasdf1asdfasdfasdfasdf", createdAt: Date(), commentCount: 5, likeCount: 55),
    ]
    
    var searchBlogResult: [Blog] = [
    ]
    
    var resultCount: Int = 0
    
    
    func doSearch() {
        if !isSearchKeywordEmpty() {
            setIsSearched(to: true)
        }
    }
}

enum SearchType: String {
    case post
    case blog
    case tag
}

