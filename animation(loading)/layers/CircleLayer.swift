//
//  CircleLayer.swift
//  animation(loading)
//
//  Created by lk on 16/7/19.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit
///
/// 此类绘制圆，圆的动画处理
///
class CircleLayer: CAShapeLayer {
        /// 动画持续时间
    let animationDuration : CFTimeInterval = 0.3
        /// 动画开始时间
    let animationBegin :CFTimeInterval = 0.0
        /// 小圆
    var circleSmallLayer = UIBezierPath(ovalInRect: CGRect(x: 50, y: 50, width: 0, height: 0))
        /// 大圆
    var circleBigLayer = UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 17.5, width: 95, height: 95))
        /// 圆 垂直压扁
    var circleVerticalSquishPath = UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 20, width: 95, height: 90))
        /// 圆 水平压扁
    var circleHorizontalSquishPath = UIBezierPath(ovalInRect: CGRect(x: 5.0, y: 20, width: 90, height: 90))
    
    
    
    override init() {
        super.init()
        fillColor = UIColor.orangeColor().CGColor
        path = circleSmallLayer.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     扩展动画
     */
    func expend() {
        let expendAnimation = CABasicAnimation(keyPath: "path")
        expendAnimation.fromValue = circleSmallLayer.CGPath
        expendAnimation.toValue = circleBigLayer.CGPath
        expendAnimation.duration = animationDuration
        expendAnimation.fillMode = kCAFillModeForwards
        expendAnimation.removedOnCompletion = false //动画结束后是否保持动画设置视图
        addAnimation(expendAnimation, forKey: nil)
    }
    
    /**
     收缩动画
     */
    func contract() {
        let contractAnimation = CABasicAnimation(keyPath: "path")
        contractAnimation.fromValue = circleBigLayer.CGPath
        contractAnimation.toValue = circleSmallLayer.CGPath
        contractAnimation.duration = animationDuration
        contractAnimation.fillMode = kCAFillModeForwards
        contractAnimation.removedOnCompletion = false
        addAnimation(contractAnimation, forKey: nil)
    }
    
    /**
     压缩组合动画
     */
    func wobblGroupAnimation() {
        //1 垂直压缩 从 big 到 垂直压缩
        let verticalWobblAnimation = CABasicAnimation(keyPath: "path")
        verticalWobblAnimation.fromValue = circleBigLayer.CGPath
        verticalWobblAnimation.toValue = circleVerticalSquishPath.CGPath
        verticalWobblAnimation.beginTime = animationBegin
        verticalWobblAnimation.duration = animationDuration
        
        //2 垂直到水平压缩
        let verticalHorizonalAnimation = CABasicAnimation(keyPath: "path")
        verticalHorizonalAnimation.fromValue = circleVerticalSquishPath.CGPath
        verticalHorizonalAnimation.toValue = circleHorizontalSquishPath.CGPath
        verticalHorizonalAnimation.beginTime = verticalWobblAnimation.duration + verticalWobblAnimation.beginTime
        verticalHorizonalAnimation.duration = animationDuration
        
        //3 水平到垂直压缩
        let horizonalVerticalAnimation = CABasicAnimation(keyPath: "path")
        horizonalVerticalAnimation.fromValue = circleHorizontalSquishPath.CGPath
        horizonalVerticalAnimation.toValue = circleVerticalSquishPath.CGPath
        horizonalVerticalAnimation.beginTime = verticalHorizonalAnimation.duration + verticalHorizonalAnimation.beginTime
        horizonalVerticalAnimation.duration = animationDuration
        
        //4 垂直 到 big
        let verticalBigAnimation = CABasicAnimation(keyPath: "path")
        verticalBigAnimation.fromValue = circleHorizontalSquishPath.CGPath
        verticalBigAnimation.toValue = circleBigLayer.CGPath
        verticalBigAnimation.beginTime = horizonalVerticalAnimation.duration + horizonalVerticalAnimation.beginTime
        verticalBigAnimation.duration = animationDuration
        
        //5 组合动画
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [verticalWobblAnimation,verticalHorizonalAnimation,horizonalVerticalAnimation,verticalBigAnimation]
        animationGroup.duration = 4 * animationDuration
        animationGroup.repeatCount = 2
        addAnimation(animationGroup, forKey: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
