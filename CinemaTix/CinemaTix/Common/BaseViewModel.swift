//
//  BaseViewModel.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import Foundation

enum LoadingState {
    case start
    case done
    
    func isWaiting() -> Bool {
        return self == .start
    }
    
    func isDone() -> Bool {
        return self == .done
    }
}

protocol BaseViewModel {
    var loadingState: LoadingState { get }
}
