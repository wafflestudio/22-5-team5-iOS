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

