//
//  CalendarHeader.swift
//  JTAppleCalendarExample
//
//  Created by Seokho on 2019/11/22.
//  Copyright © 2019 Seokho. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarHeader: JTACMonthReusableView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        let weekend = ["일", "월", "화", "수", "목", "금", "토", "일"]
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        for index in 0 ... 6 {
            let label = UILabel()
            label.text = weekend[index]
            label.textAlignment = .center
            label.textColor = .label
            label.font = .systemFont(ofSize: 16)
            stackView.addArrangedSubview(label)
        }

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
