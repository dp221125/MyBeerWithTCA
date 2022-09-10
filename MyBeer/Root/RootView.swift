//
//  RootView.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: Store<RootState, RootAction>

    var body: some View {
        TabView {
            MainTabCoordinatorView(
                store: store.scope(
                    state: \RootState.main,
                    action: RootAction.main
                )
            )
            .tabItem {
                VStack {
                    Image(systemName: "list.bullet")
                    Text("list")
                }
            }
        }
    }
}
