//
//  ViewController.swift
//  JTAppleCalendarExample
//
//  Created by Seokho on 2019/11/22.
//  Copyright © 2019 Seokho. All rights reserved.
//

import UIKit
import JTAppleCalendar

class MainViewController: UIViewController {
    
    private weak var calendarView: JTACMonthView?
    private weak var yearLabel: UILabel?
    private weak var headerView: UIView?
    private weak var selecedLabel: UILabel?
    
    private var calendarTopAnchor: NSLayoutConstraint?
    private var calendarHeightAnchor: NSLayoutConstraint?
    private var calendarWidthAnchor: NSLayoutConstraint?
    
    private var year: String? {
        didSet(oldValue) {
            if oldValue != self.year {
                self.yearLabel?.text = self.year
            }
        }
    }
    private var selectedDate = [Date]()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        self.headerView = headerView
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let yearLabel = UILabel()
        yearLabel.font = .boldSystemFont(ofSize: 20)
        self.yearLabel = yearLabel
        headerView.addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            yearLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            yearLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let button = UIButton()
        button.setTitle("오늘", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(goToday), for: .touchUpInside)
        headerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -16)
        ])
        
        let calendarView = JTACMonthView()
        calendarView.backgroundColor = .systemBackground
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.scrollDirection = .horizontal
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        calendarView.register(CalendarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalendarHeader")
        self.calendarView = calendarView
        
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        let selecedLabel = UILabel()
        view.addSubview(selecedLabel)
        self.selecedLabel = selecedLabel
        selecedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selecedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selecedLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor)
        ])
        
        checkOrientation()
    }
    
    
    override func viewDidLoad() {
        goToday()
    }
    
    private func checkOrientation() {
        
        guard let calendarView = self.calendarView, let yearLabel = self.yearLabel  else { return }
        
        calendarTopAnchor?.isActive = false
        calendarHeightAnchor?.isActive = false
        calendarWidthAnchor?.isActive = false
        
        let orientation = UIDevice.current.orientation
        
        if orientation.isLandscape {
            calendarTopAnchor = calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            calendarHeightAnchor = calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -150)
            calendarWidthAnchor =  calendarView.widthAnchor.constraint(equalTo: calendarView.heightAnchor)
        } else {
            calendarTopAnchor = calendarView.topAnchor.constraint(equalTo: yearLabel.bottomAnchor,constant: 20)
            calendarWidthAnchor =  calendarView.widthAnchor.constraint(equalTo: view.widthAnchor)
            calendarHeightAnchor = calendarView.heightAnchor.constraint(equalTo: calendarView.widthAnchor)
        }
        
        headerView?.widthAnchor.constraint(equalTo: calendarView.widthAnchor).isActive = true
        calendarTopAnchor?.isActive = true
        calendarHeightAnchor?.isActive = true
        calendarWidthAnchor?.isActive = true
    }
    
    @objc private func goToday() {
        calendarView?.scrollToDate(Date())
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView?.visibleDates()
        calendarView?.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates?.monthDates.first?.date)
        checkOrientation()
    }
}
extension MainViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let startDate = formatter.date(from: "2016 01 01")!
        
        let endDate = Date()
        
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .off,
                                       firstDayOfWeek: .sunday)
    }
}
extension MainViewController: JTACMonthViewDelegate {

    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let dateCell = cell as? DateCell else { return }
        dateCell.dateLabel?.text = cellState.text
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as? DateCell else {
            fatalError()
        }
        
        cell.dateLabel?.text = cellState.text
        cell.dateLabel?.textColor = .label
        
        let calendar = Calendar.current

        if calendar.isDateInToday(cellState.date) {
            cell.todayView?.isHidden = false
            cell.todayView?.layer.borderWidth = 2.0
            cell.todayView?.layer.borderColor = UIColor.systemOrange.cgColor
        } else {
            cell.todayView?.isHidden = true
        }
           
        
        if cellState.day.rawValue == 7 {
            cell.dateLabel?.textColor = .systemBlue
        }
        else if cellState.day.rawValue == 1 {
            cell.dateLabel?.textColor = .systemRed
        }
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        guard let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "CalendarHeader", for: indexPath) as? CalendarHeader else { fatalError() }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.locale = Locale(identifier: "ko-KR")
        let month = formatter.string(from: range.start)
        
        formatter.dateFormat = "yyyy년"
        let year =  formatter.string(from: range.start)
        self.year = "\(year) \(month)"
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 16)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if let cell = cell as? DateCell {
            let localDate = Date(timeInterval: TimeInterval(Calendar.current.timeZone.secondsFromGMT()), since: date)
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy년 MMM dd일"
            dateformatter.locale = Locale(identifier: "ko-KR")
            self.selectedDate = [date]
            self.selecedLabel?.text = dateformatter.string(from: localDate)
            cell.selectView?.isHidden = false
        }
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if let cell = cell as? DateCell {
            cell.selectView?.isHidden = true
        } 
    }
    
    func calendarDidScroll(_ calendar: JTACMonthView) {
        calendar.selectDates(self.selectedDate)
    }

}
