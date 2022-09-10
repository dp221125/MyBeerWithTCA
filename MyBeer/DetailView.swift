//
//  DetailView.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import Foundation
import SwiftUI

enum DatailAction {}

struct DetailState: Equatable {
    let id = UUID()
    var beer: Beer
}

struct DetailEnvironment {}

struct DetailView: View {
    let store: Store<DetailState, DatailAction>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text(viewStore.beer.name)
        }
    }
}
