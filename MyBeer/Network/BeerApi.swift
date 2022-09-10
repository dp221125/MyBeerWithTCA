//
//  BeerApi.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import Foundation

enum BeerApi {
    case beer(page: Int, perPage: Int)
}

extension BeerApi: BaseTargetType {
    var queryParameter: [String: Any]? {
        switch self {
        case let .beer(page, perPage):
            return ["page": page, "per_page": perPage]
        }
    }

    var path: String {
        switch self {
        case .beer:
            return "/v2/beers"
        }
    }
}
