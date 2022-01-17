//
//  PictureOfTheDayView.swift
//  NASA_APP
//
//  Created by Decagon on 15/01/2022.
//

import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper
import ProgressHUD


class PictureOfTheDayView: UIView {
    let dailyAstronomyVM = DailyAstronomyViewModel()
    var switchImageVideoView = UIView()
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        setUpViews()
        dailyAstronomyVM.fetchNasaData()
        
        datePicker.isHidden = true
        
        HUD.show(status: "Loading...")
        dailyAstronomyVM.onLoadingfetchedCompletion = { [weak self] data in
            
            self?.setViewsToModel(model: data)
    
            DispatchQueue.main.async {
                self?.datePicker.isHidden = false
            }
        }
    }
    
    func setViewsToModel(model: NasaModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = model.title
            self.dateLabel.text = model.date
            self.explanationLabel.text = model.explanation
            
            guard let fetchedUrl = URL(string: model.url) else { return }
    
            if model.mediaType == MediaType.video.rawValue {
                self.youtubePlayerView.load(URLRequest(url: fetchedUrl))
                self.youtubePlayerView.isHidden = false
                self.imageView.isHidden = true
            } else {
                self.imageView.sd_setImage(with: fetchedUrl)
                self.imageView.sd_setImage(with: fetchedUrl, completed: { image, error, cache, urls in
                    if (error != nil) {
                        self.imageView.image = UIImage(named: "placeholder")
                    } else {
                        self.imageView.image = image
                    }
                })
                self.youtubePlayerView.isHidden = true
                self.imageView.isHidden = false
            }
            HUD.hide()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViewFromApi() {
        HUD.show(status: "Loading...")
        dailyAstronomyVM.onDateChangedFetchedCompletion = { [weak self] data in
            self?.setViewsToModel(model: data)
        }
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    func viewToReload() {
        loadViewFromApi()
    }
    
    lazy var  titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var  dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var youtubePlayerView: WKWebView = {
        let youtubeView = WKWebView()
        youtubeView.translatesAutoresizingMaskIntoConstraints = false
        return youtubeView
    }()
    
    lazy var  imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode =  UIView.ContentMode.scaleAspectFit
        imageView.frame.size.width = 20
        imageView.frame.size.height = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var  explanationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var  datePicker: UIDatePicker = {
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
        contentView.addSubview(youtubePlayerView)
        contentView.addSubview(explanationLabel)
        contentView.addSubview(datePicker)
        
        [
            scrollView,
            contentView,
            titleLabel,
            dateLabel,
            imageView,
            switchImageVideoView,
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
        
        datePicker.centerXInSuperview()
        
        datePicker.anchor(top: dateLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        
        imageView.anchor(top: datePicker.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 250))
        
        youtubePlayerView.anchor(top: datePicker.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 250))
        
        explanationLabel.anchor(top: imageView.isHidden == true ? youtubePlayerView.bottomAnchor : imageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10))
        
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }
}

enum MediaType: String {
    case video
    case image
}
