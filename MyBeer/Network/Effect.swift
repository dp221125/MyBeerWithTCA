//
//  Effect.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import Foundation

enum NetworkError: Error {
    case unknown
    case serverError(Error)
    case badRequest
    case parsing
}

class BaseEffect<API: BaseTargetType> {
    func excute<T: Decodable>(_ api: API) async -> TaskResult<T> {
        do {
            let (data, response) = try await URLSession.shared.data(from: api.url)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.unknown)
            }

            if httpResponse.statusCode >= 200, httpResponse.statusCode < 300 {
                guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                    return .failure(NetworkError.parsing)
                }
                return .success(model)
            } else {
                return .failure(NetworkError.badRequest)
            }

        } catch {
            return .failure(NetworkError.serverError(error))
        }
    }
}
