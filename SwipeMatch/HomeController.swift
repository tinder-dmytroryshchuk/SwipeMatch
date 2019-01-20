//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Tinder on 1/20/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonStackView = HomeBottomControlsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupDummyCards()
    }
    
    
    fileprivate func setupDummyCards() {
        (0..<10).forEach { (_) in
            let cardView = CardView(frame: .zero)
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    //MARK: - Fileprivate
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
}

