//
//  ScreenCore.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import TCACoordinators
import ComposableArchitecture
import Foundation
import SwiftUI

enum ScreenAction {
    case main(MainAction)
    case detail(DatailAction)
}

enum ScreenState: Equatable, Identifiable {
    case main(MainState)
    case detail(DetailState)
    
    var id: UUID {
        switch self {
        case .main(let state):
            return state.id
        case .detail(let state):
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

struct CoordinatorView: View {
    
    let store: Store<CoordinatorState, CoordinatorAction>
    
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

enum CoordinatorAction: IndexedRouterAction {
    case routeAction(Int, action: ScreenAction)
    case updateRoutes([Route<ScreenState>])
}

struct CoordinatorState: Equatable, IndexedRouterState {
    
    static let initialState = CoordinatorState(
        routes: [.root(.main(.init()), embedInNavigationView: true)]
    )
    
    var routes: [Route<ScreenState>]
}

struct CoordinatorEnvironment {}

typealias CoordinatorReducer = Reducer<
    CoordinatorState, CoordinatorAction, CoordinatorEnvironment
>

let coordinatorReducer: CoordinatorReducer = screenReducer
    .forEachIndexedRoute(environment: { _ in ScreenEnvironment() })
    .withRouteReducer(
        Reducer<CoordinatorState, CoordinatorAction, CoordinatorEnvironment> { state, action, environment in
            switch action {
            case .routeAction(_, action: .main(let .itemTapped(beer))):
                state.routes.push(.detail(DetailState(beer: beer)))
            default:
                break
            }
            return .none
        }
    )

