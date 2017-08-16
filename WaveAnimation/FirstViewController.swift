//
//  FirstViewController.swift
//  WaveAnimation
//
//  Created by Максим Стегниенко on 13.08.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    let transitionManager = TransitionManager()
    
    var divider: CGFloat = 500
    var degree: Double = 0
    let animationDuration: TimeInterval = 0.7
    let startPoint : Int = 55

    
    let transformView :BCMeshTransformView = BCMeshTransformView.init(frame: CGRect(x: -20, y: -20,width: 350, height:420))
    
    let container = UIImageView.init(frame: CGRect(x: 84, y: 66,width:196,height:293))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 3
        
        transformView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        let image : UIImage = UIImage(named:"Rectangle 4")!
        
        container.image = image
        
        container.layer.cornerRadius = 5
        
        
        
        
        transformView.backgroundColor = UIColor.clear
        transformView.layer.cornerRadius = 5
        transformView.layer.masksToBounds = true;
        transformView.contentView.addSubview(container)
        
        self.view.addSubview(transformView)
        
        transformView.diffuseLightFactor = -4.2;
        
        var perspective = CATransform3DIdentity;
        
        perspective.m34 = -1.0/divider;
        
        transformView.supplementaryTransform = perspective
        
      
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let toViewController = segue.destination as! MSCollectionViewController
        
        toViewController.transitioningDelegate = self.transitionManager
        
        // инициализируем пустую ячейку в коллекшн вью (то место куда идет вьюха) 
        
        toViewController.arrayOfItems.insert((UIImageView.init(image: UIImage.init(named: ""))), at: 0)
     
    }
    
    
    
    @IBOutlet weak var button: UIButton!
    

    
   

}

