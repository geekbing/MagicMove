//
//  MagicMoveTransion.swift
//  MagicMove
//
//  Created by Bing on 6/29/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

class MagicMovePush: NSObject, UIViewControllerAnimatedTransitioning
{
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        // 1.获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! Main
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! Detail
        let container = transitionContext.containerView()
        
        // 2.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
        let snapshotView = fromVC.selectedCell?.avatar!.snapshotViewAfterScreenUpdates(false)
        snapshotView!.frame = container!.convertRect((fromVC.selectedCell?.avatar!.frame)!, fromView: fromVC.selectedCell)
        fromVC.selectedCell?.avatar!.hidden = true
        
        // 3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.alpha = 0
        toVC.avatarView?.hidden = true
        
        // 4.都添加到 container 中。注意顺序不能错了
        container!.addSubview(toVC.view)
        container!.addSubview(snapshotView!)
        
        // 5.执行动画
        toVC.avatarView!.layoutIfNeeded()
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: .CurveEaseInOut, animations:{ () -> Void in
            snapshotView!.frame = toVC.avatarView!.frame
            toVC.view.alpha = 1
        }) { (finish: Bool) -> Void in
            fromVC.selectedCell?.avatar!.hidden = false
            toVC.avatarView!.image = toVC.avatar
            toVC.desc?.text = toVC.descStr
            toVC.avatarView?.hidden = false
            snapshotView!.removeFromSuperview()
            
            //一定要记得动画完成后执行此方法，让系统管理 navigation
            transitionContext.completeTransition(true)
        }
    }
}
