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
    let animationDuration: TimeInterval = 0.7
    let startPoint : Int = 55
    
    let transformView :BCMeshTransformView = BCMeshTransformView.init(frame: CGRect(x: 100, y: 150,width:190,height:270))

    let container = UIImageView.init(frame: CGRect(x: 30, y: 30,width:130,height:195))
    
    var dynamicColor = UIColor.gray

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        transformView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        transformView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        let image : UIImage = UIImage(named:"Rectangle 4")!
        
        container.image = image
    
        container.layer.cornerRadius = 5
        
     
        DispatchQueue.global(qos: .background).async {
            
        
             self.dynamicColor = self.areaAverage()
            
        }
        
        
     
        transformView.backgroundColor = UIColor.clear
        transformView.layer.cornerRadius = 5
        transformView.layer.masksToBounds = true;
        transformView.contentView.addSubview(container)
    
        self.view.addSubview(transformView)
        
        transformView.diffuseLightFactor = -1.2;
        
        var perspective = CATransform3DIdentity;
        
        perspective.m34 = -1.0/divider;
        
        transformView.supplementaryTransform = perspective
  
 
        
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
        
        self.transformView.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y: 30), boundsSize: self.container.frame.size)
 
        
        UIView.animate(withDuration: self.animationDuration, animations: {
            
            self.animateShadowToOpacity(from: 0.0, to: 0.8, duration:  self.animationDuration, offsetTo: CGSize(width: 0,height: 8), forView: view)
            
            self.animateWith(startPoint: -5, endPoint: 30, view: view)
            
        }, completion:  nil)

 
     
    }
 
    
    func areaAverage() -> UIColor {
        
    
        var bitmap = [UInt8](repeating: 0, count: 4)
        
        let context = CIContext(options: nil)
        let cgImg = context.createCGImage(CoreImage.CIImage(cgImage: (self.container.image?.cgImage!)!), from: CoreImage.CIImage(cgImage: (self.container.image?.cgImage!)!).extent)
        
        let inputImage = CIImage(cgImage: cgImg!)
        let extent = inputImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let filter = CIFilter(name: "CIAreaAverage", withInputParameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent])!
        let outputImage = filter.outputImage!
        let outputExtent = outputImage.extent
        assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)
      
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: kCIFormatRGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
        
        let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
        return result
    }
    
    
    func animateShadowToOpacity(from: Float, to: Float, duration: TimeInterval, offsetTo: CGSize, forView: UIView){
    
        let anim = CABasicAnimation()
        anim.autoreverses = true;
        anim.keyPath = "shadowOpacity"
        anim.fromValue = from;
        anim.toValue = to
        anim.duration = duration
        forView.layer .add(anim, forKey: "shadowOpacity")
      
        
        DispatchQueue.main.async {
           forView.layer.shadowColor = self.dynamicColor.cgColor
            
        }
        
        let offsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
        offsetAnimation.autoreverses = true;
        offsetAnimation.toValue = offsetTo
        offsetAnimation.duration = duration
        forView.layer .add(offsetAnimation, forKey: "shadowOffset")

        
        
        
    }
    
  
    
    func animateWith( startPoint: Int, endPoint: Int, view:BCMeshTransformView )  {
        
   
        if (startPoint <= endPoint)
        {
            var sp = startPoint
     
            UIView.animate(withDuration: 0.025, animations: {
                
                view.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y:sp), boundsSize: self.container.frame.size)
                
            }, completion: { (finish) in
                
                 sp = sp + 1
                
                 self.animateWith(startPoint: sp, endPoint: endPoint, view: view)
              
            })
            
            
        }
    }
  
}


