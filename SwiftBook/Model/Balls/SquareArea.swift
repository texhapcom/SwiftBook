//
//  SquareArea.swift
//  SwiftBook
//
//  Created by Yuri on 19.01.2023.
//

import UIKit

protocol SquareAreaProtocol {
    init(size: CGSize, color: UIColor)
    
    func setBalls(withColors: [UIColor], andRadius: Int)
}

public class SquareArea: UIView, SquareAreaProtocol {
    
    private var balls: [Ball] = []
    
    private var animator: UIDynamicAnimator?
    
    private var snapBahavor: UISnapBehavior?
    
    private var collisionBahavior: UICollisionBehavior
    
    required public init(size: CGSize, color: UIColor) {
        collisionBahavior = UICollisionBehavior(items: [])
        
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        self.backgroundColor = color
        
        collisionBahavior.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        animator = UIDynamicAnimator(referenceView: self)
        animator?.addBehavior(collisionBahavior)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setBalls(withColors ballsColor: [UIColor], andRadius radius: Int) {
        for (index, oneBallColor) in ballsColor.enumerated() {
            let coordinateX = 10 + (2 * radius) * index
            let coordinateY = 10 + (2 * radius) * index
            
            let ball = Ball(
                color: oneBallColor,
                radius: radius,
                coordinates: (x: coordinateX, y: coordinateY)
            )
            
            self.addSubview(ball)
            self.bringSubviewToFront(ball)
            self.balls.append(ball)
            collisionBahavior.addItem(ball)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            for ball in balls {
                if (ball.frame.contains(touchLocation)) {
                    snapBahavor = UISnapBehavior(item: ball, snapTo: touchLocation)
                    snapBahavor?.damping = 0.5
                    if let _snapBehavior = snapBahavor {
                        animator?.addBehavior(_snapBehavior)
                    }
                }
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            if let snapBahavor = snapBahavor {
                snapBahavor.snapPoint = touchLocation
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let snapBehavior = snapBahavor {
            animator?.removeBehavior(snapBehavior)
        }
        snapBahavor = nil
    }
    
}
