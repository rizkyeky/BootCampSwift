//
//  BookViewModel.swift
//  CinemaTix
//
//  Created by Eky on 29/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class BookViewModel: BaseViewModel {
    open var movie: MovieModel?
    open var movieDetail: MovieDetailModel?
    
    open var selectedDateRelay = PublishRelay<Int>()
    
    open var sevenDays: [Date] = []
    
    func init7Days() {
        sevenDays.append(contentsOf: getDatesForThisWeek())
    }
    
    private func getDatesForThisWeek() -> [Date] {
        var dates = [Date]()
        let calendar = Calendar.current
        let currentDate = Date.now
        
        for day in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: day, to: currentDate) {
                dates.append(date)
            }
        }
        
        return dates
    }

}
