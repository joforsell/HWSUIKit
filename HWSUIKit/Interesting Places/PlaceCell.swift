
//  PlaceCell.swift
//  HWSUIKit
//
//  Created by Johan Forsell on 2022-04-11.


import UIKit

class PlaceCell: UITableViewCell {
    
    var place: Place? {
        didSet {
            guard let placeItem = place else { return }
            
            let path = InterestingPlacesController.getDocumentsDirectory().appendingPathComponent(placeItem.picture)
            placeImageView.image = UIImage(contentsOfFile: path.path)
            placeDescriptionLabel.text = placeItem.name
        }
    }
    
    let placeImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    var placeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(placeImageView)
        contentView.addSubview(placeDescriptionLabel)
        
        NSLayoutConstraint.activate([
            placeImageView.heightAnchor.constraint(equalToConstant: 60),
            placeImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 2),
            placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            placeDescriptionLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 20),
            placeDescriptionLabel.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
