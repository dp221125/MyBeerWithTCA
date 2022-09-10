//
//  MainTabCore.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import TCACoordinators

enum MainTabCoordinatorAction: IndexedRouterAction {
    case routeAction(Int, action: MainScreenAction)
    case updateRoutes([Route<MainScreenState>])
}

struct MainTabCoordinatorState: Equatable, IndexedRouterState {
    static let initialState = MainTabCoordinatorState(
        routes: [.root(.main(.init()), embedInNavigationView: true)]
    )

    var routes: [Route<MainScreenState>]
}

struct CoordinatorEnvironment {}

typealias MainTabCoordinatorReducer = Reducer<
    MainTabCoordinatorState, MainTabCoordinatorAction, CoordinatorEnvironment
>

let mainTabCoordinatorReducer: MainTabCoordinatorReducer = mainScreenReducer
    .forEachIndexedRoute(environment: { _ in MainScreenEnvironment() })
    .withRouteReducer(
        Reducer<MainTabCoordinatorState, MainTabCoordinatorAction, CoordinatorEnvironment> { state, action, _ in
            switch action {
            case let .routeAction(_, action: .main(.itemTapped(beer))):
                state.routes.push(.detail(DetailState(beer: beer)))
            default:
                break
            }
            return .none
        }
    )
