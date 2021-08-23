//
//  AppDelegate.swift
//  BSShop
//
//  Created by User on 18.08.2021.
//

import UIKit
import CoreData
import Swinject
public var globalContainer: Container!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var mainCoordinator: MainStartProtocol! {
        globalContainer.resolve(MainStartProtocol.self)
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        containerRegister()
        mainCoordinator.start()
        return true
    }
    
    func containerRegister() {
        globalContainer = FactoryConrainers.factoryRootContainer(with: [.alerts, .analitycs, .logging, .services])
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BSShop")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
