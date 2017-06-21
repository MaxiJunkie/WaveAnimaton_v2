//
//  ViewController.swift
//  WaveAnimation
//
//  Created by Максим Стегниенко on 13.06.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var testView: UIImageView!
    
    
    var divider: CGFloat = 500
    var degree: Double = 0
    let animationDuration: TimeInterval = 0.5
    
    let transformView :BCMeshTransformView = BCMeshTransformView.init(frame: CGRect(x: 100, y: 150,width:190,height:240))
    let container = UIImageView.init(frame: CGRect(x: 30, y: 20,width:130,height:195))
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        transformView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        transformView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        let image : UIImage = UIImage(named:"Rectangle 6")!
        
        container.image = image
    
        container.layer.cornerRadius = 5
   
        
 
        transformView.backgroundColor = UIColor.clear
        transformView.layer.cornerRadius = 5
        transformView.layer.masksToBounds = true;
        transformView.contentView.addSubview(container)
        
        
        
        
        self.view.addSubview(transformView)
        
        transformView.diffuseLightFactor = 3;
        
        var perspective = CATransform3DIdentity;
        
        perspective.m34 = -1.0/500.0;
        
        transformView.supplementaryTransform = perspective
  
        self.waveAnimation(view: transformView)
      
 
        
    }
    

    
    
    @IBAction func repeatButton(_ sender: Any) {
        
           self.waveAnimation(view: transformView)
     
    }
    
    
    
    
    func transformWaveAnimation(scaleX: CGFloat,scaleY: CGFloat,scaleZ: CGFloat) -> CATransform3D {
        
            var transform = CATransform3DIdentity
            
            transform.m34 = -1.0/divider
            
            return CATransform3DScale(transform, scaleX, scaleY, scaleZ)
   
    }
    
    
    
    
    
    func waveAnimation(view: BCMeshTransformView) {
        
        self.transformView.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y: 0), boundsSize: self.container.frame.size)
        
        UIView.animate(withDuration: self.animationDuration, animations: {
         
    
                self.animateShadowToOpacity(from: 0.0, to: 0.5, duration: self.animationDuration, offsetTo: CGSize(width: 0,height: 10), forView: view)
            
                view.layer.transform  = self.transformWaveAnimation(scaleX: 1.1, scaleY: 1.1, scaleZ: 1.1)
      
            
        }, completion:  { (finish) in
            
            UIView.animate(withDuration: 0.29, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations:{
          
                self.animateWith(startPoint: 90, endPoint: 0, view: view)
     
                self.animateShadowToOpacity(from: 0.5, to: 0.0, duration: 0.9, offsetTo: CGSize(width: 0,height: 0), forView: view)
                
                view.layer.transform  = self.transformWaveAnimation(scaleX: 1.0, scaleY: 1.0, scaleZ: 1.0)
                
            }, completion: nil)
            
            
        })
     
    }
    
    
    func animateShadowToOpacity(from: Float, to: Float, duration: TimeInterval, offsetTo: CGSize, forView: UIView){
    
        let anim = CABasicAnimation()
        anim.keyPath = "shadowOpacity"
        anim.fromValue = from;
        anim.toValue = to
        anim.duration = duration
        forView.layer .add(anim, forKey: "shadowOpacity")
        forView.layer.shadowOpacity = to
        
        
        let offsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
        offsetAnimation.toValue = offsetTo
        offsetAnimation.duration = duration
        forView.layer .add(offsetAnimation, forKey: "shadowOffset")
       
        if offsetTo.width != 0 || offsetTo.height != 0 {
            forView.layer.shadowOffset = offsetTo
        }
        
    }
    
    
    func animateWith( startPoint: Int, endPoint: Int, view:BCMeshTransformView )  {
        
   
        if (startPoint >= endPoint)
        {
            var sp = startPoint
            
            sp = sp - 1
            
            UIView.animate(withDuration: 0.01, animations: {
                
                view.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y:sp), boundsSize: self.container.frame.size)
                
            }, completion: { (finish) in
        
                 self.animateWith(startPoint: sp, endPoint: endPoint, view: view)
              
            })
        }
    }
}


