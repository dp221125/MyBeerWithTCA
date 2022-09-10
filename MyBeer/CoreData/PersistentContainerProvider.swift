//
//  PersistentContainerProvider.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import CoreData

class PersistentContainerProvider {
    let persistentContainer: NSPersistentContainer

    init() {
        let container = NSPersistentContainer(name: "Beer")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer = container
    }
}
