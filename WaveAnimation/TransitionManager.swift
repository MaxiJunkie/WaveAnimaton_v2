//
//  TransitionManager.swift
//  WaveAnimation
//
//  Created by Максим Стегниенко on 15.08.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import UIKit

class TransitionManager: NSObject ,UIViewControllerAnimatedTransitioning , UIViewControllerTransitioningDelegate {

    private var presenting = true
    private var animatableView : BCMeshTransformView = BCMeshTransformView.init(frame: CGRect(x: 0, y: 0,width: 330, height:380))
    
    let container = UIImageView.init(frame: CGRect(x: 64, y: 46,width:196,height:293))
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
       
        let container = transitionContext.containerView

      
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)

        
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        
        let fromViewController = self.presenting ? screens.from as! FirstViewController : screens.from as! MSCollectionViewController
        let toViewController = self.presenting ? screens.to as! MSCollectionViewController : screens.to as! FirstViewController
        
        let toView = toViewController.view
        let fromView = fromViewController.view
        
        
        toView?.transform = self.presenting ? offScreenRight : offScreenLeft
        
        
        if self.presenting {
            
            
            self.prepareTransportView(firstViewController: fromViewController as! FirstViewController)
            
         
        }
   
        container.addSubview(toView!)
        container.addSubview(fromView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            
            if self.presenting {
                
                fromView?.transform = offScreenLeft
              
                // moving of view
                
                self.finalPositionOfView()
                
                
            } else {
                
                fromView?.transform = offScreenRight
                
                
                self.prepareTransportView(firstViewController: toViewController as! FirstViewController)
                
                toViewController.view.addSubview(self.animatableView)
                
            }
            
            toView?.transform = CGAffineTransform.identity
          
            
        }) { (finish) in
            
           
            if self.presenting {
                
                toViewController.view.addSubview(self.animatableView)
                
                self.safeView(firstViewController: fromViewController as! FirstViewController )
                
                self.waveAnimation(view: self.animatableView)
                
                self.prepareSecondViewController(secondViewController: toViewController as! MSCollectionViewController)
                
                //  костыль  №1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    
                    self.animatableView.removeFromSuperview()
                    
                }
                
            }
            
         
            transitionContext.completeTransition(true)
            
            self.presenting = !self.presenting
        }
    
    
    }
    
    
    func prepareSecondViewController (secondViewController: MSCollectionViewController) {
        
        
        secondViewController.arrayOfItems[0] = UIImageView.init(image: UIImage.init(named: "Rectangle 4"))
       
        secondViewController.collectionView.reloadData()
     
        
    }
    
    func finalPositionOfView () {
       
    
         // костыль №2
        
        let scale = CGAffineTransform(scaleX: 0.662 ,y:0.664)
        
        let offstageRight = CGAffineTransform(translationX: 371, y: 126.5)
        
        let concat = offstageRight.concatenating(scale)
      
        self.animatableView.transform = concat
        
        
     
    }
    

    
    func safeView(firstViewController: FirstViewController){
     
        // костыль №3
        
        let scale = CGAffineTransform(scaleX: 0.662 ,y:0.664)
     
        let offstageRight = CGAffineTransform(translationX: -112.8, y: 126.5)
        
        let concat = offstageRight.concatenating(scale)
        
        firstViewController.transformView.transform = concat
        
        self.animatableView = firstViewController.transformView
        
    }
    
    
    func prepareTransportView(firstViewController: FirstViewController){
  
        firstViewController.transformView.transform = CGAffineTransform.identity
       
        self.animatableView = firstViewController.transformView
        
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
    
    
    
    // wave animation ---------
    
    
    func waveAnimation(view: BCMeshTransformView) {
        
         view.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y: 35), boundsSize: self.container.frame.size)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.animateWith(startPoint: -5, endPoint: 35, view: view)
            
        }, completion: nil)
        
        
        
    }
    
    func animateWith( startPoint: Int, endPoint: Int, view:BCMeshTransformView )  {
        
        
        if (startPoint <= endPoint)
        {
            var sp = startPoint
            
            UIView.animate(withDuration: 0.02, animations: {
                
                view.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y:sp), boundsSize: self.container.frame.size)
                
            }, completion: { (finish) in
                
                sp = sp + 1
                
                self.animateWith(startPoint: sp, endPoint: endPoint, view: view)
                
            })
            
            
        }
    }

    
    
}
