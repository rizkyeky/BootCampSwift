//
//  ExtContainer.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import Foundation
import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        container.register(MovieViewModel.self) { r in
            return MovieViewModel()
        }.inObjectScope(.container)
        return container
    }()
}
