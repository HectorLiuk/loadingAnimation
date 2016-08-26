//
//  AnimationView.swift
//  animation(loading)
//
//  Created by lk on 16/7/19.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

protocol AnimationDelegate: class {
    func completeAnimation()
}


class AnimationView: UIView {

    let circleLayer = CircleLayer()
    
    let triangleLayer = TriangleLayer()
    
    let leftLineLayer = LeftLineLayer()
    
    let rightLineLayer = RightLineLayer()
    
    let leftLineLayerRed = LeftLineLayer()
    
    let rightLineLayerRed = RightLineLayer()
    
    let waveLayer = WaveLayer()
    
    weak var delegate: AnimationDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        addCircleLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     1 圆形扩大动画
     */
    func addCircleLayer() {
        layer.addSublayer(circleLayer)
        circleLayer.expend()
       //延迟执行两种方法 
        //1 gcd
//        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(0.3 * Double(NSEC_PER_SEC)))
//        dispatch_after(time, dispatch_get_main_queue()) {
            //防止循环引用
//            [unowned self]  in
//            self.circleLayer.wobblGroupAnimation()
//        }
        //2 NSTimer
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(wobbleCircleLayer), userInfo: nil, repeats: false)
    }
    
    /**
     2 圆形压缩动画
     */
    func wobbleCircleLayer() {
        circleLayer.wobblGroupAnimation()
        layer.addSublayer(triangleLayer)
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(triangleAnimationLayer), userInfo: nil, repeats: false)
    }
    
    /**
     3 三角形凸起
     */
    func triangleAnimationLayer() {
        triangleLayer.trangleGroupAnimation()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(transformAnimation), userInfo: nil, repeats: false)

    }
    
    /**
     4 旋转视图 消失圆
     */
    func transformAnimation() {
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.65) //设置锚点 围绕此点旋转
        layer.addAnimation(triangleLayer.transformRotationZ(), forKey: nil)
        circleLayer.contract()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(addBottomToTopLineLayer), userInfo: nil, repeats: false)
    }
    
    /**
     5 添加自下到上 线动画
     */
    func addBottomToTopLineLayer() {
        layer.addSublayer(leftLineLayer)
        leftLineLayer.bottomToTopAnimation(UIColor.cyanColor(), fromValue: 0, toValue: 1, keyPath:"strokeEnd")
        layer.addSublayer(rightLineLayer)
        rightLineLayer.bottomToTopAnimation(UIColor.cyanColor(), fromValue: 0, toValue: 1, keyPath:"strokeEnd")
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(addTopToBottomLineLayer), userInfo: nil, repeats: false)
    }
    
    /**
     6 添加自上而下 线动画
     */
    func addTopToBottomLineLayer() {
        layer.addSublayer(leftLineLayerRed)
        leftLineLayerRed.bottomToTopAnimation(UIColor.orangeColor(), fromValue: 1, toValue: 0,keyPath:"strokeStart")

        layer.addSublayer(rightLineLayerRed)
        rightLineLayerRed.bottomToTopAnimation(UIColor.orangeColor(), fromValue: 1, toValue: 0,keyPath:"strokeStart")
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(waveAnimation), userInfo: nil, repeats: false)
    }
    
    /**
     7 水波纹动画效果
     */
    func waveAnimation() {
        layer.addSublayer(waveLayer)
        waveLayer.animate()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(expendView), userInfo: nil, repeats: false)
    }
    
    /**
     8 弹出 视图
     */
    func expendView() {
        backgroundColor = UIColor.orangeColor()
        center = CGPoint(x: UIScreen.mainScreen().bounds.size.width/2 , y: UIScreen.mainScreen().bounds.size.height/2)
        
        layer.sublayers = nil
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { 
            self.frame = UIScreen.mainScreen().bounds
            }) { (finished) in
                self.delegate?.completeAnimation()
        }
        
    }
    
}
