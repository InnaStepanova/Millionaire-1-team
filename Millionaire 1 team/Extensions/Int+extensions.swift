//
//  Int+extensions.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 10.02.2023.
//

import Foundation

extension Int {
    func setEmptyAtBegin() -> String {
            return (Double(self) / 10.0 < 1 ? " \(self)" : "\(self)")
        }
}
