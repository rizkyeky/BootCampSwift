//
//  ContainerDI.swift
//  CinemaTix
//
//  Created by Eky on 12/11/23.
//

import Foundation
import Swinject

class ContainerDI {
    
    static let shared: Container = {
        let container = Container()
        
        container.register(MovieViewModel.self) { r in
            return MovieViewModel()
        }.inObjectScope(.container)
        
        container.register(AuthViewModel.self) { r in
            return AuthViewModel()
        }.inObjectScope(.container)
        
        container.register(WalletViewModel.self) { r in
            return WalletViewModel()
        }.inObjectScope(.container)

        container.register(DarkMode.self) { r in
            return DarkMode()
        }.inObjectScope(.container)
        
        container.register(BiometricAuth.self) { r in
            return BiometricAuth()
        }.inObjectScope(.container)
        
        container.register(BookViewModel.self) { _ in
            return BookViewModel()
        }.inObjectScope(.container)
        
        return container
    }()
}
