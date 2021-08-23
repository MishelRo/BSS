//
//  FactoryContainers.swift
//  Set2
//
//  Created by Mishel on 03/08/2021.
//  Copyright © 2021 Set. All rights reserved.
//

import Foundation
import Swinject

enum FactoryConrainersType {
    case alerts
    case services
    case analitycs
    case logging
}

struct FactoryConrainers {

    // MARK: - Static

    static func factoryRootContainer(with types: [FactoryConrainersType]) -> Container {
        let builder = ContainerBuilder()

        if types.contains(.alerts) {
            builder.addAlerts()
        }

        if types.contains(.services) {
            builder.addServices()
        }

        if types.contains(.analitycs) {
            builder.addAnalytics()
        }

        if types.contains(.logging) {
            builder.addLogging()
        }
        return builder.build()
    }
}
