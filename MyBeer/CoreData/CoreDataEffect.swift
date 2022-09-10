//
//  CoreDataEffect.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import ComposableArchitecture
import CoreData

protocol CoreDataEffect {
    func fetch() -> TaskResult<[FavoriteBeer]>
    func save(id: Int, name: String, isFavorite: Bool) async -> TaskResult<Void>
}

class CoreDataEffectImpl: CoreDataEffect {
    private let provider: PersistentContainerProvider

    init(provider: PersistentContainerProvider = PersistentContainerProvider()) {
        self.provider = provider
    }

    func fetch() -> TaskResult<[FavoriteBeer]> {
        do {
            let fetchRequest = FavoriteBeer.fetchRequest()
            let data = try fetchRequest.execute()
            return .success(data)
        } catch {
            return .failure(error)
        }
    }

    private func save(id: Int, name: String, isFavorite: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        let container = provider.persistentContainer

        container.performBackgroundTask { context in
            let newData = FavoriteBeer(context: context)
            newData.id = Int64(id)
            newData.name = name
            newData.isFavorite = isFavorite

            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func save(id: Int, name: String, isFavorite: Bool) async -> TaskResult<Void> {
        return await withCheckedContinuation { continuation in
            self.save(id: id, name: name, isFavorite: isFavorite) { result in
                switch result {
                case .success:
                    continuation.resume(returning: .success(()))
                case let .failure(error):
                    continuation.resume(returning: .failure(error))
                }
            }
        }
    }
}
