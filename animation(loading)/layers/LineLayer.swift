//
//  LineLayer.swift
//  animation(loading)
//
//  Created by lk on 16/7/19.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class LeftLineLayer: CAShapeLayer {
    /// 左边画线
    lazy var leftLine : UIBezierPath = {
        let leftLine = UIBezierPath()
        leftLine.moveToPoint(CGPoint(x: 50, y: 100))
        leftLine.addLineToPoint(CGPoint(x: 0, y: 100))
        leftLine.addLineToPoint(CGPoint(x: 0, y: -self.lineWidth))
        leftLine.addLineToPoint(CGPoint(x: 50, y: -self.lineWidth))
        return leftLine
    }()
    
    
    override init() {
        super.init()
        fillColor = UIColor.clearColor().CGColor
        lineWidth = 5
        path = leftLine.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bottomToTopAnimation(color : UIColor, fromValue : AnyObject, toValue : AnyObject, keyPath :String)  {
        strokeColor = color.CGColor //设置线的颜色
        
        let bottomToTopAnimation = CABasicAnimation(keyPath: keyPath)
        bottomToTopAnimation.fromValue = fromValue
        bottomToTopAnimation.toValue = toValue
        bottomToTopAnimation.duration = 1.0
        bottomToTopAnimation.removedOnCompletion = false
        addAnimation(bottomToTopAnimation, forKey: nil)
    }
}

class RightLineLayer: CAShapeLayer {
    /// 右边画线
    lazy var rightLine : UIBezierPath = {
        let rightLine = UIBezierPath()
        rightLine.moveToPoint(CGPoint(x: 50, y: 100))
        rightLine.addLineToPoint(CGPoint(x: 100, y: 100))
        rightLine.addLineToPoint(CGPoint(x: 100, y: -self.lineWidth))
        rightLine.addLineToPoint(CGPoint(x: 50, y: -self.lineWidth))
        return rightLine
    }()
    
    override init() {
        super.init()
        fillColor = UIColor.clearColor().CGColor
        lineWidth = 5
        path = rightLine.CGPath
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bottomToTopAnimation(color : UIColor, fromValue : AnyObject, toValue : AnyObject, keyPath :String) {
        strokeColor = color.CGColor //设置线的颜色
        
        let bottomToTopAnimation = CABasicAnimation(keyPath: keyPath)
        bottomToTopAnimation.fromValue = fromValue
        bottomToTopAnimation.toValue = toValue
        bottomToTopAnimation.duration = 1.0
        bottomToTopAnimation.removedOnCompletion = false
        addAnimation(bottomToTopAnimation, forKey: nil)
        
        
    }

    
}
