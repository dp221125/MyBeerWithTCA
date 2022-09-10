//
//  MainTabView.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

struct MainTabCoordinatorView: View {
    let store: Store<MainTabCoordinatorState, MainTabCoordinatorAction>

    var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                CaseLet(
                    state: /MainScreenState.main,
                    action: MainScreenAction.main,
                    then: MainView.init
                )
                CaseLet(
                    state: /MainScreenState.detail,
                    action: MainScreenAction.detail,
                    then: DetailView.init
                )
            }
        }
    }
}
