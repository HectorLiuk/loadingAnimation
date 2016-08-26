//
//  ViewController.swift
//  animation(loading)
//
//  Created by lk on 16/7/19.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var animationView : AnimationView = {
        let animationView = AnimationView()
        animationView.frame.size = CGSize(width: 100, height: 100)
        animationView.center = self.view.center
        animationView.delegate = self
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.addSubview(animationView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController : AnimationDelegate{
    func completeAnimation(){
        
    }
    
}
