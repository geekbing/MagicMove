//
//  Detail.swift
//  MagicMove
//
//  Created by Bing on 6/29/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

class Detail: UIViewController
{
    var avatar: UIImage?
    var avatarView: UIImageView?
    
    var descStr: String?
    var desc: UITextView?
    
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Detail"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.avatarView = UIImageView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenWidth))
        self.avatarView?.image = avatar
        self.view.addSubview(self.avatarView!)
        
        self.desc = UITextView(frame: CGRect(x: 0, y: screenWidth + 64, width: screenWidth, height: screenHeight - screenWidth - 64))
        self.view.addSubview(self.desc!)
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: screenWidth + 64 + 40, width: 120, height: 40))
        backBtn.center.x = self.view.center.x
        backBtn.layer.masksToBounds = true
        backBtn.layer.cornerRadius = 20
        backBtn.setTitle("返回", forState: .Normal)
        backBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backBtn.backgroundColor = UIColor.redColor()
        backBtn.addTarget(self, action: .backBtnClick, forControlEvents: .TouchUpInside)
        //        self.view.addSubview(backBtn)
        
        //手势监听器
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: .edgePanGesture)
        edgePan.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(edgePan)
    }
    
    deinit
    {
        print("deinit Detail")
    }
    
    // 点击返回按钮
    func backBtnClick()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 屏幕边缘滑动手势
    func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer)
    {
        let progress = edgePan.translationInView(self.view).x / self.view.bounds.width
        
        if edgePan.state == .Began
        {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        }
        else if edgePan.state == .Changed
        {
            self.percentDrivenTransition?.updateInteractiveTransition(progress)
        }
        else if edgePan.state == .Cancelled || edgePan.state == .Ended
        {
            if progress > 0.5
            {
                self.percentDrivenTransition?.finishInteractiveTransition()
            }
            else
            {
                self.percentDrivenTransition?.cancelInteractiveTransition()
            }
            self.percentDrivenTransition = nil
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

private extension Selector
{
    static let backBtnClick = #selector(Detail.backBtnClick)
    static let edgePanGesture = #selector(Detail.edgePanGesture(_:))
}

extension Detail: UINavigationControllerDelegate
{
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        if animationController is MagicMovePop
        {
            return self.percentDrivenTransition
        }
        else
        {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        if operation == .Pop
        {
            return MagicMovePop()
        }
        else
        {
            return nil
        }
    }
}