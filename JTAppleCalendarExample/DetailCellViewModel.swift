//
//  DetailCellViewModel.swift
//  JTAppleCalendarExample
//
//  Created by Seokho on 2019/11/22.
//  Copyright © 2019 Seokho. All rights reserved.
//

import Foundation
import Combine

class DateCellViewModel {
    var day = PassthroughSubject<String,Never>()
    
    init() {

    }
}
class Test {
    
    var cancel = Set<AnyCancellable>()
    init(vm: DateCellViewModel) {
        vm.day.sink { (str) in
            print(str)
        }.store(in: &cancel)
    }
}


