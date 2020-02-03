//
//  QuizTableViewCell.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/20/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    var checked = false
    
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setup()
        setupLayout()
    }
    
    func setup() {
        self.addSubview(checkImageView)
        self.addSubview(answerLabel)
    }
    
    func setupLayout() {
        checkImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        checkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        checkImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        checkImageView.heightAnchor.constraint(equalTo: checkImageView.widthAnchor, multiplier: 0.67).isActive = true
        checkImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16).isActive = true
        
        answerLabel.centerYAnchor.constraint(equalTo: checkImageView.centerYAnchor, constant: 0).isActive = true
        answerLabel.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 16).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 16).isActive = true
        answerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        answerLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16).isActive = true
    }
}
