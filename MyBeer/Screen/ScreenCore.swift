//
//  ScreenCore.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import Foundation
import SwiftUI
import TCACoordinators

enum ScreenAction {
    case main(MainAction)
    case detail(DatailAction)
}

enum ScreenState: Equatable, Identifiable {
    case main(MainState)
    case detail(DetailState)

    var id: UUID {
        switch self {
        case let .main(state):
            return state.id
        case let .detail(state):
            return state.id
        }
    }
}

struct ScreenEnvironment {}

let screenReducer = Reducer<ScreenState, ScreenAction, ScreenEnvironment>.combine(
    mainReducer
        .pullback(
            state: /ScreenState.main,
            action: /ScreenAction.main,
            environment: { _ in MainEnvironment(beerClient: BeerEffectImpl()) }
        )
)
