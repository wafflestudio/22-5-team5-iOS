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
    var isAddressNameUnavailable: Bool = true
    
    func setAddressName() {
        UserInfoRepository.shared.setAddressName(addressName: addressName)
    }
    
    func setBlogAddress() {
        addressNameAvailability = ""
        isAddressNameUnavailable = true
        blogAddress = "wastory.store/api/blogs/" + addressName
    }
    
    func setUserInfo() {
        UserInfoRepository.shared.setUserInfo()
    }
    
    func checkAddressNameAvailability() async {
        if addressName.isEmpty || addressName.count > 20 {
            addressNameAvailability = "사용할 수 없어요."
        }
        else {
            do {
                _ = try await NetworkRepository.shared.getBlog(
                    blogAddress: self.addressName
                )
                addressNameAvailability = "사용할 수 없어요."
            }
            catch {
                print("Error: \(error.localizedDescription)")
                addressNameAvailability = "👏 세상에 하나뿐인 주소에요!"
                isAddressNameUnavailable = false
            }
        }
    }
    
    func clearIdTextField() {
        addressName = ""
    }
    
    func isClearButtonInactive() -> Bool {
        return addressName.isEmpty
    }
}
