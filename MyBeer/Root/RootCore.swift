//
//  RootCore.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture

enum RootAction {
    case main(MainTabCoordinatorAction)
}

struct RootState: Equatable {
    static let initialState = RootState(
        main: .initialState
    )

    var main: MainTabCoordinatorState
}

struct RootEnvironment {}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    mainTabCoordinatorReducer
        .pullback(
            state: \RootState.main,
            action: /RootAction.main,
            environment: { _ in .init() }
        )
)
