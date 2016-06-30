//
//  MagicMovePopTransion.swift
//  MagicMove
//
//  Created by Bing on 6/29/16.
//  Copyright © 2016 Bing. All rights reserved.
//

import UIKit

class MagicMovePop: NSObject, UIViewControllerAnimatedTransitioning
{
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! Detail
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! Main
        let container = transitionContext.containerView()
        
        let snapshotView = fromVC.avatarView!.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = container!.convertRect(fromVC.avatarView!.frame, fromView: fromVC.view)
        fromVC.avatarView!.hidden = true
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.selectedCell?.avatar!.hidden = true
        
        container!.insertSubview(toVC.view, belowSubview: fromVC.view)
        container!.addSubview(snapshotView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            snapshotView.frame = container!.convertRect((toVC.selectedCell?.avatar!.frame)!, fromView: toVC.selectedCell)
            fromVC.view.alpha = 0
        }) { (finish: Bool) -> Void in
            toVC.selectedCell?.avatar!.hidden = false
            snapshotView.removeFromSuperview()
            fromVC.avatarView!.hidden = false
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
