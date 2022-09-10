//
//  MyBeerApp.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import SwiftUI

@main
struct MyBeerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: .init(initialState: .initialState,
                             reducer: rootReducer,
                             environment: RootEnvironment())
            )
        }
    }
}
