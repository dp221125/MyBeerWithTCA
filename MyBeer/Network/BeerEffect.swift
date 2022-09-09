//
//  BeerEffect.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import Foundation
import ComposableArchitecture

protocol BeerEffect {
    func beer(_ page: Int, perPage: Int) async -> TaskResult<[Beer]>
}

class BeerEffectImpl: BaseEffect<BeerApi>, BeerEffect {
    func beer(_ page: Int, perPage: Int) async -> TaskResult<[Beer]> {
        return await self.excute(.beer(page: page, perPage: perPage))
    }
}
