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
                    state: /ScreenState.main,
                    action: ScreenAction.main,
                    then: MainView.init
                )
                CaseLet(
                    state: /ScreenState.detail,
                    action: ScreenAction.detail,
                    then: DetailView.init
                )
            }
        }
    }
}
