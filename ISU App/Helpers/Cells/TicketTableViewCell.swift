//
//  TicketTableViewCell.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 8/1/24.
//

import UIKit

class TicketTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "TicketTableViewCell"

    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aViewForDate: UIView = {
        let aView = UIView()
//        aView.backgroundColor = .systemRed
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var aCardView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.layer.cornerRadius = 12
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var dividerView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .systemGray
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.text = "Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateDayValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateHourValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .label
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var idLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aViewDescription: UIView = {
        let aView = UIView()
//        aView.backgroundColor = .red
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.text = "Date"
//        label.backgroundColor = .blue
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
       let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        icon.image = UIImage(systemName: "location")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var titleLocation: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .label
//        label.backgroundColor = .blue
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var buttonInfo: UIButton = {
        let aView = UIButton()
        aView.backgroundColor = .systemGreen
        aView.setTitle("View Ticket", for: .normal)
        aView.titleLabel?.textColor = .white
        aView.layer.cornerRadius = 12
//        aView.addTarget(self, action: #selector(goToTicket), for: .touchUpInside)
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    // MARK: - setUpView
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray
        [dateLabel, dateDayValue, dateHourValue, idLabel].forEach {
            aViewForDate.addSubview($0)
        }
        
        [titleLabel, iconImage, titleLocation, buttonInfo].forEach {
            aViewDescription.addSubview($0)
        }

        [aViewForDate, dividerView, aViewDescription].forEach {
            aCardView.addSubview($0)
        }
        
        addSubview(aCardView)
        
        NSLayoutConstraint.activate([
            
            aViewForDate.topAnchor.constraint(equalTo: aCardView.topAnchor, constant: 20),
            aViewForDate.leadingAnchor.constraint(equalTo: aCardView.leadingAnchor, constant: 5),
            aViewForDate.bottomAnchor.constraint(equalTo: aCardView.bottomAnchor, constant: -20),
            aViewForDate.widthAnchor.constraint(equalToConstant: 100),
            
            dateLabel.topAnchor.constraint(equalTo: aViewForDate.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: aViewForDate.leadingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: aViewForDate.trailingAnchor, constant: -5),
            
            dateDayValue.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            dateDayValue.leadingAnchor.constraint(equalTo: aViewForDate.leadingAnchor, constant: 5),
            dateDayValue.trailingAnchor.constraint(equalTo: aViewForDate.trailingAnchor, constant: -5),
            
            dateHourValue.topAnchor.constraint(equalTo: dateDayValue.bottomAnchor, constant: 5),
            dateHourValue.leadingAnchor.constraint(equalTo: aViewForDate.leadingAnchor, constant: 5),
            dateHourValue.trailingAnchor.constraint(equalTo: aViewForDate.trailingAnchor, constant: -5),
            
            idLabel.topAnchor.constraint(equalTo: dateHourValue.bottomAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: aViewForDate.leadingAnchor, constant: 5),
            idLabel.trailingAnchor.constraint(equalTo: aViewForDate.trailingAnchor, constant: -5),
            
            dividerView.topAnchor.constraint(equalTo: aCardView.topAnchor, constant: 40),
            dividerView.leadingAnchor.constraint(equalTo: aViewForDate.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: aCardView.bottomAnchor, constant: -40),
            dividerView.widthAnchor.constraint(equalToConstant: 3),
            
            aViewDescription.topAnchor.constraint(equalTo: aCardView.topAnchor, constant: 20),
            aViewDescription.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: 0),
            aViewDescription.trailingAnchor.constraint(equalTo: aCardView.trailingAnchor, constant: -5),
            aViewDescription.bottomAnchor.constraint(equalTo: aCardView.bottomAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: aViewDescription.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: aViewDescription.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: aViewDescription.trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            iconImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            iconImage.leadingAnchor.constraint(equalTo: aViewDescription.leadingAnchor, constant: 5),
            
            titleLocation.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleLocation.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 5),
            titleLocation.trailingAnchor.constraint(equalTo: aViewDescription.trailingAnchor, constant: -5),
            
            buttonInfo.bottomAnchor.constraint(equalTo: aViewDescription.bottomAnchor, constant: -5),
            buttonInfo.trailingAnchor.constraint(equalTo: aViewDescription.trailingAnchor, constant: -5),
            buttonInfo.widthAnchor.constraint(equalToConstant: 120),
            buttonInfo.heightAnchor.constraint(equalToConstant: 35),
            
            aCardView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            aCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            aCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            aCardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    func configureCell(ticket: TicketModelCell) {
        let date = ticket.dateScheduled.formatted(date: .numeric, time: .standard)
        let dateArray = date.components(separatedBy: ", ")
        
        dateDayValue.text = dateArray[0]
        dateHourValue.text = dateArray[1]
        idLabel.text = "Ticket #\(ticket.id)"
        titleLabel.text = ticket.name
        titleLocation.text = ticket.placeName
    }
    
}
