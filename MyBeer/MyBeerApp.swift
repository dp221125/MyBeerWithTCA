//
//  MyBeerApp.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import SwiftUI

@main
struct MyBeerApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView(
                store: .init(
                    initialState: .initialState,
                    reducer: coordinatorReducer,
                    environment: CoordinatorEnvironment() )
            )
        }
    }
}
