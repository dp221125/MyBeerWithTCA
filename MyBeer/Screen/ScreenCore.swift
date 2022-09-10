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

enum MainScreenAction {
    case main(MainAction)
    case detail(DatailAction)
}

enum MainScreenState: Equatable, Identifiable {
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

struct MainScreenEnvironment {}

let mainScreenReducer = Reducer<MainScreenState, MainScreenAction, MainScreenEnvironment>.combine(
    mainReducer
        .pullback(
            state: /MainScreenState.main,
            action: /MainScreenAction.main,
            environment: { _ in MainEnvironment(beerClient: BeerEffectImpl()) }
        )
)
