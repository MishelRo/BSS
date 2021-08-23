//
//  Sequense.swift
//  BSShop
//
//  Created by User on 22.08.2021.
//

import Foundation
extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}
