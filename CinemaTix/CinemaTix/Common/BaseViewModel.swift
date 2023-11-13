//
//  BaseViewModel.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import Foundation
import RxSwift

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

class BaseViewModel {
    internal var loadingState: LoadingState = .done
    internal let disposeBag = DisposeBag()
}
