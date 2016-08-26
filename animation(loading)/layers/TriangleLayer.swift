//
//  TriangleLayer.swift
//  animation(loading)
//
//  Created by lk on 16/7/19.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit
///
/// 此类绘制圆凸起，凸起为三角形。对他的绘制和动画处理
///
class TriangleLayer: CAShapeLayer {
    
        /// 边距
    let paddingSpace : CGFloat = 30.0
    
        /// 绘制小三角形
    lazy var smallTriangle : UIBezierPath = {
        let smallTriangle = UIBezierPath()
        smallTriangle.moveToPoint(CGPoint(x: 5.0 + self.paddingSpace , y: 95))
        smallTriangle.addLineToPoint(CGPoint(x: 50.0, y: 12.5 + self.paddingSpace))
        smallTriangle.addLineToPoint(CGPoint(x: 95.0 - self.paddingSpace, y: 95.0))
        smallTriangle.closePath()
        return smallTriangle
    }()
    
        /// 绘制左边凸起三角形
    lazy var leftTriangle : UIBezierPath = {
        let leftTriangel = UIBezierPath()
        leftTriangel.moveToPoint(CGPoint(x: 5.0, y: 95))
        leftTriangel.addLineToPoint(CGPoint(x: 50.0, y: 12.5))
        leftTriangel.addLineToPoint(CGPoint(x: 95.0 - self.paddingSpace , y: 95.0))
        return leftTriangel
    }()
    
        /// 绘制右边凸起三角形
    lazy var rightTriangle : UIBezierPath = {
       let rightTriangle = UIBezierPath()
        rightTriangle.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        rightTriangle.addLineToPoint(CGPoint(x: 50.0, y: 12.5))
        rightTriangle.addLineToPoint(CGPoint(x: 95.0, y: 95.0))
        rightTriangle.closePath()
        return rightTriangle
    }()
    
        /// 绘制上面凸起
    lazy var topTriangle : UIBezierPath = {
        let topTriangle = UIBezierPath()
        topTriangle.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        topTriangle.addLineToPoint(CGPoint(x: 50.0, y: 12.5))
        topTriangle.addLineToPoint(CGPoint(x: 95.0, y: 95.0))
        topTriangle.closePath()
        return topTriangle
    }()
    
    
    override init() {
        super.init()
        fillColor = UIColor.orangeColor().CGColor
        //设置圆角 需要边线设置颜色
        strokeColor = UIColor.orangeColor().CGColor
        lineWidth = 7.0
        lineCap = kCALineCapRound
        lineJoin = kCALineJoinRound
        
        path = smallTriangle.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     三角形组合动画
     */
    func trangleGroupAnimation() {
         //1 左边凸起
        let leftAnimation = CABasicAnimation(keyPath: "path")
        leftAnimation.fromValue = smallTriangle.CGPath
        leftAnimation.toValue = leftTriangle.CGPath
        leftAnimation.beginTime = 0.0
        leftAnimation.duration = 0.4
        
        //2 右边凸起
        let rightAnimation = CABasicAnimation(keyPath: "path")
        rightAnimation.fromValue = leftTriangle.CGPath
        rightAnimation.toValue = rightTriangle.CGPath
        rightAnimation.beginTime = 0.0 + leftAnimation.duration
        rightAnimation.duration = 0.4
        
        //3 上面凸起
        let topAnimation = CABasicAnimation(keyPath: "path")
        topAnimation.fromValue = rightTriangle.CGPath
        topAnimation.toValue = topTriangle.CGPath
        topAnimation.beginTime = rightAnimation.duration + rightAnimation.beginTime
        topAnimation.duration = 0.4
        
        //4 组合动画
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [leftAnimation,rightAnimation,topAnimation];
        animationGroup.duration = topAnimation.beginTime + topAnimation.duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.removedOnCompletion = false
        addAnimation(animationGroup, forKey: nil)
    }
    
    /**
     旋转三角形
     */
    func transformRotationZ() -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2)
        rotationAnimation.duration = 0.6
        rotationAnimation.removedOnCompletion = true
        return rotationAnimation
    }
}
