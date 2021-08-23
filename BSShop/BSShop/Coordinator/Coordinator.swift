//
//  Coordinator.swift
//  TestMarsSwinJectProject
//
//  Created by User on 05.03.2021.
//
import Swinject
import Foundation
class Coordinator {

    static var shared = Coordinator()
    var window: UIWindow?

    func display(confViews: ConfiguratorView) {
        confViews.assemble(container: Container())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let controller = UINavigationController(rootViewController: confViews.getView())
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
}
