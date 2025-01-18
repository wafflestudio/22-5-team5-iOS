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
    
    
    var searchKeyword: String = ""
    
    
    
    func setIsSearchingInBlog(_ blogID: Int?) {
        isSearchingInBlog = (blogID != nil)
    }
    
    
    
    func isSearchKeywordEmpty() -> Bool {
        searchKeyword == ""
    }
}

enum SearchType: String {
    case post
    case blog
    case tag
}

