//
//  MainStart.swift
//  BSShop
//
//  Created by User on 18.08.2021.
//
protocol MainStartProtocol {
    func start()
}

import Foundation
class MainStart: MainStartProtocol {

    static var shared = MainStart()

    func start() {
        Coordinator.shared.display(confViews: MainModuleConfigurator())
    }
}
