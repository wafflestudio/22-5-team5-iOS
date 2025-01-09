//
//  SignUpStep5ViewModel.swift
//  Wastory
//
//  Created by mujigae on 12/27/24.
//

import SwiftUI
import Observation

@Observable final class SignUpStep5ViewModel {
    var addressName = "example"
    var blogAddress = "wastory.store/api/blogs/"
    var addressNameAvailability = "사용할 수 없어요."
    
    func setUsername() {
        UserInfoRepository.shared.setUsername(username: addressName)
    }
    
    func setBlogAddress() {
        blogAddress = "wastory.store/api/blogs/" + addressName
    }
    
    func setUserInfo() {
        UserInfoRepository.shared.setUserInfo()
    }
    
    func checkAddressNameAvailability() {
        if addressName.isEmpty || addressName.count > 20 {
            addressNameAvailability = "사용할 수 없어요."
        }
        else {
            addressNameAvailability = "👏 세상에 하나뿐인 주소에요!"
        }
    }
    
    func clearIdTextField() {
        addressName = ""
    }
    
    func isClearButtonInactive() -> Bool {
        return addressName.isEmpty
    }
}
