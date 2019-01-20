//
//  CardView.swift
//  SwipeMatch
//
//  Created by Tinder on 1/20/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class CardView: UIView {

    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "girl-1"))

    // Configuration
    fileprivate let treshhold: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handelChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handelChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        // rotation
        // do some math to condert radians to degress
        let degress: CGFloat = translation.x / 20
        let angle = degress * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > treshhold
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
        }, completion: ({ (_) in
            print("Complited animation, let's bring our card back")
            self.transform = .identity
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
