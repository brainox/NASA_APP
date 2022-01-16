//
//  PictureOfTheDayView.swift
//  NASA_APP
//
//  Created by Decagon on 15/01/2022.
//

import UIKit

class PictureOfTheDayView: UIView {
    let dailyAstronomyVM = DailyAstronomyViewModel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setUpViews()
        //        populateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Astronomy Picture of the day"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        //        label.text = "2022-01-14"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "sample")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        //        label.text = "Michael Joseph Jackson (August 29, 1958 – June 25, 2009) was an American singer, songwriter and dancer. Dubbed the , he is regarded as one of the most significant cultural figures of the 20th century. Over a four-decade career, his contributions to music, dance and fashion, along with his publicized personal life, made him a global figure in popular culture. Jackson influenced artists across many music genres; through stage and video performances, he popularized complicated dance moves such as the moonwalk, to which he gave the name, as well as the robot. He is the most awarded music artist in history.The eighth child of the Jackson family, Jackson made his professional debut in 1964 with his elder brothers Jackie, Tito, Jermaine and Marlon as a member of the Jackson 5 (later known as the Jacksons). Jackson began his solo career in 1971 while at Motown Records. He became a solo star with his 1979 album Off the Wall. His music videos, including those for from his 1982 album Thriller, are credited with breaking racial barriers and transforming the medium into an artform and promotional tool. He helped propel the success of MTV and continued to innovate with videos for the albums Bad (1987), Dangerous (1991) and HIStory: Past, Present and Future, Book I (1995). Thriller became the best-selling album of all time, while Bad was the first album to produce five U.S. Billboard Hot 100 number-one singles.[nb 1]From the late 1980s, Jackson became a figure of controversy and speculation due to his changing appearance, relationships, behavior and lifestyle. In 1993, he was accused of sexually abusing the child of a family friend. The lawsuit was settled out of civil court; Jackson was not indicted due to lack of evidence. In 2005, he was tried and acquitted of further child sexual abuse allegations and several other charges. In both cases, the FBI found no evidence of criminal conduct on Jackson's behalf in either case. In 2009, while preparing for a series of comeback concerts, This Is It, Jackson died from an overdose of propofol administered by his personal physician, Conrad Murray, who was convicted in 2011 of involuntary manslaughter."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(explanationLabel)
        
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
        
        titleLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10))
        
        imageView.anchor(top: dateLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), size: CGSize(width: 0, height: 200))
        
        explanationLabel.anchor(top: imageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10))
    }
    
    //    func setUpBinders() {
    //        dailyAstronomyVM.error.bind { model in
    //            self.titleLabel.text = self.dailyAstronomyVM.astronomyDetail?.title
    //            self.dateLabel.text = self.dailyAstronomyVM.astronomyDetail?.date
    //            self.imageView.image = UIImage(named: "sample")
    //            self.explanationLabel.text = self.dailyAstronomyVM.astronomyDetail?.explanation
    //        }
    //
    ////        dailyAstronomyVM.error.bind { model in
    ////            self.titleLabel.text = model?.title
    ////            self.dateLabel.text = model?.date
    ////            self.imageView.image = UIImage(named: "sample")
    ////            self.explanationLabel.text = model?.explanation
    ////        }
    //    }
    
    func populateViews() -> String {
        DispatchQueue.main.async {
            self.titleLabel.text = self.dailyAstronomyVM.astronomyDetail?.title
            self.dateLabel.text = self.dailyAstronomyVM.astronomyDetail?.date
            //                self?.dateLabel.text = self?.dailyAstronomyVM.date
            self.explanationLabel.text = self.dailyAstronomyVM.astronomyDetail?.explanation
        }
        return self.dailyAstronomyVM.astronomyDetail?.explanation ?? "Nothing is printing"
        
    }
}
