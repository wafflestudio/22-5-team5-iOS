//
//  NetworkInterceptor.swift
//  Wastory
//
//  Created by mujigae on 1/9/25.
//

import Alamofire
import Foundation

final class NetworkInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization("Bearer \(NetworkConfiguration.accessToken)"))
        completion(.success(urlRequest))
    }
}
