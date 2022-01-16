//
//  PictureOfTheDayView.swift
//  NASA_APP
//
//  Created by Decagon on 15/01/2022.
//

import UIKit
import SDWebImage

class PictureOfTheDayView: UIView {
    let dailyAstronomyVM = DailyAstronomyViewModel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        setUpViews()
        dailyAstronomyVM.fetchNasaData()
        
        dailyAstronomyVM.onLoadingfetchedCompletion = { [weak self] data in
            DispatchQueue.main.async {
                self?.titleLabel.text = data.title
                self?.dateLabel.text = data.date
                self?.explanationLabel.text = data.explanation
                self?.imageView.sd_setImage(with: URL(string: data.url))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewToReload() {
        dailyAstronomyVM.onDateChangedFetchedCompletion = { [weak self] data in
            DispatchQueue.main.async {
                self?.titleLabel.text = data.title
                self?.dateLabel.text = data.date
                self?.explanationLabel.text = data.explanation
                self?.imageView.sd_setImage(with: URL(string: data.url))
                    self?.layoutIfNeeded()
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode =  UIView.ContentMode.scaleAspectFit
        imageView.backgroundColor = .systemBackground
        imageView.frame.size.width = 20
        imageView.frame.size.height = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(handleDismissingDatePicker), for: .editingDidEnd)
        
        //Set minimum and Maximum Dates
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.day = 0
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.month = 0
        comps.year = -10
        let minDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        return datePicker
    }()
    
    
    @objc func valueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "MM/dd/yyyy"
        
        let pickedDate = formatter.string(from: sender.date)
        
        let date = formatter.date(from: pickedDate)
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateFormat = "yyyy-MM-dd"
        let resultString = formatter.string(from: date!)
    }
    
    @objc func handleDismissingDatePicker() {
        datePicker.resignFirstResponder()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "MM/dd/yyyy"
        
        let pickedDate = formatter.string(from: datePicker.date)
        
        let date = formatter.date(from: pickedDate)
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateFormat = "yyyy-MM-dd"
        let resultString = formatter.string(from: date!)
        
        dailyAstronomyVM.fetchNasaDataWithDate(updateDateString: resultString)
        self.viewToReload()
        print(resultString)
    }
    
    func setUpViews() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(explanationLabel)
        contentView.addSubview(datePicker)
        
        [
            scrollView,
            contentView,
            titleLabel,
            dateLabel,
            imageView,
            explanationLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
        titleLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20))
        
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20))
        
        imageView.anchor(top: dateLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 100))
        
        datePicker.centerXInSuperview()
        datePicker.anchor(top: imageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        explanationLabel.anchor(top: datePicker.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10))
    }
}

