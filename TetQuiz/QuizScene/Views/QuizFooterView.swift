//
//  QuizFooterView.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

class QuizFooterView: UIView {
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.setTitle("Hoàn thành", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(finishButton)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        finishButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        finishButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        finishButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        finishButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
}
