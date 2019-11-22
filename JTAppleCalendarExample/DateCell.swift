//
//  DateCell.swift
//  JTAppleCalendarExample
//
//  Created by Seokho on 2019/11/22.
//  Copyright © 2019 Seokho. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateCell: JTACDayCell {
    
    weak var dateLabel: UILabel?
    weak var todayView: UIView?
    weak var selectView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel()
        self.dateLabel = label
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let todayView = UIView()
        todayView.backgroundColor = .clear
        label.addSubview(todayView)
        todayView.isHidden = true
        self.todayView = todayView
        todayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            todayView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            todayView.widthAnchor.constraint(equalToConstant: 30),
            todayView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        todayView.layer.cornerRadius = 15
        todayView.layer.masksToBounds = true
        
        let selectView = UIView()
        selectView.backgroundColor = .systemPurple
        contentView.addSubview(selectView)
        selectView.isHidden = true
        self.selectView = selectView
        selectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectView.topAnchor.constraint(equalTo: todayView.bottomAnchor, constant: 5),
            selectView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            selectView.widthAnchor.constraint(equalToConstant: 6),
            selectView.heightAnchor.constraint(equalToConstant: 6)
        ])
        selectView.layer.cornerRadius = 3
    }
    
    override func prepareForReuse() {
        self.selectView?.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
