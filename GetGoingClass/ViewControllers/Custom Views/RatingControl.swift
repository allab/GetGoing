//
//  RatingControl.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-28.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    // MARK: - Properties
    var stars = [UIButton]()

    var rating: Int = 0 {
        didSet {
            updateRating()
        }
    }

    // MARK: - Initializers

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    // MARK: - Methods

    func updateRating() {
        for (index, star) in stars.enumerated() {
            star.isSelected = index < rating
        }
    }


    private func setupButtons() {

        let filledStar = UIImage(named: "StarFull")
        let emptyStar = UIImage(named: "StarEmpty")

        for _ in 0..<5 {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)

            button.translatesAutoresizingMaskIntoConstraints = false
            let buttonSize: CGFloat = 22.0
            button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true

            addArrangedSubview(button)
            stars.append(button)
        }
    }

}
