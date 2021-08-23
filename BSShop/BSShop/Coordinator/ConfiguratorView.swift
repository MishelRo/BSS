//
//  ConfiguratorView.swift
//  TestMarsSwinJectProject
//
//  Created by User on 05.03.2021.
//
import Swinject
import UIKit
public protocol ConfiguratorView {
    func getView() -> UIViewController
    func assemble(container: Container)
}

public typealias ConfigurationViews = (ConfiguratorView, NSObject, Assembly)

extension Container {
    func resolveAsViewController<Service>(_ serviceType: Service.Type) -> UIViewController {
        guard let vc = self.resolve(serviceType) as? UIViewController else {
            fatalError("Can't cast \(serviceType) to UIViewController")
        }
        return vc
    }
}
