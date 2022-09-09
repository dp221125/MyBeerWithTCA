//
//  MainView.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import SwiftUI
import ComposableArchitecture
import OrderedCollections

enum RequestType {
    case initialize
    case loadMore(page: Int)
}

struct MainState: Equatable {
    let id = UUID()
    var beer = OrderedSet<Beer>()
    var oldBeer = OrderedSet<Beer>()
}

enum MainAction {
    case onAppear(requestType: RequestType)
    case beer(requestType: RequestType, TaskResult<[Beer]>)
    case itemTapped(beer: Beer)
}

struct MainEnvironment {
    var beerClient: BeerEffect
}

let mainReducer = Reducer<MainState, MainAction, MainEnvironment> { state, action, environment in
    switch action {
    case let .onAppear(type):
        return .task {
            let result: TaskResult<[Beer]>
            
            switch type {
            case .initialize:
                result = await environment.beerClient.beer(1, perPage: 20)
            case let .loadMore(page):
                result = await environment.beerClient.beer(page, perPage: 20)
            }
            return .beer(requestType: type, result)
        }
    case let .beer(requestType, .success(value)):
        switch requestType {
        case .initialize:
            state.beer = OrderedSet(value)
            state.oldBeer = state.beer
            return .none
        case .loadMore(_):
            state.beer = OrderedSet(state.oldBeer + value)
            state.oldBeer = state.beer
            return .none
        }
    case let .beer(_, .failure(error)):
        return .none
    case .itemTapped:
        return .none
    }
}


struct MainView: View {
    let store: Store<MainState, MainAction>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List(viewStore.beer) { beer in
                Text(beer.name)
                    .onAppear {
                        if beer.id > 10 && (beer.id % 19 == 1) {
                            viewStore.send(
                                .onAppear(requestType: .loadMore(page: viewStore.beer.count / 20 + 1))
                            )
                        }
                    }
                    .onTapGesture {
                        viewStore.send(.itemTapped(beer: beer))
                    }
            }
            .onAppear {
                viewStore.send(.onAppear(requestType: .initialize))
            }
            .navigationTitle("My Beer")
        }
    }
}
