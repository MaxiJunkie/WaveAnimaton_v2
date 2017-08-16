//
//  MSCollectionViewController.swift
//  WaveAnimation
//
//  Created by Максим Стегниенко on 02.07.17.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import UIKit




class MSCollectionViewController: UIViewController , UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource   {

    // init a testView
    
    public var arrayOfItems : [UIImageView] = []
    var divider: CGFloat = 500
    var degree: Double = 0
    let animationDuration: TimeInterval = 0.7
    let startPoint : Int = 55
    
    let transformView :BCMeshTransformView = BCMeshTransformView.init(frame: CGRect(x: 100, y: 150,width:190,height:270))
    
    let container = UIImageView.init(frame: CGRect(x: 30, y: 29,width:130,height:195))
    
    var dynamicColor = UIColor.gray

    
    // -----
    
    
    let segmentedControl = HMSegmentedControl(items: ["посмотрю", "смотрел", "профиль"])
    
    var collectionView: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.profileImage.layer.masksToBounds = true
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        
        
        view.addSubview(segmentedControl)
        
        segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectionIndicatorPosition = .bottom
        segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        segmentedControl.titleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
            NSFontAttributeName : UIFont.systemFont(ofSize: 14)
        ]
        
        segmentedControl.selectedTitleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSFontAttributeName : UIFont.systemFont(ofSize: 14)
        ]
        
     
        
        NSLayoutConstraint.activate(
            [segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.0),
             segmentedControl.heightAnchor.constraint(equalToConstant: 30),
             segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40.0),
             segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)]
        )

        let viewWidth = self.view.frame.size.width
   
       
        self.scrollView.isScrollEnabled = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSize(width: 2 * viewWidth, height: 400)
        self.scrollView.delegate = self
        
        
        segmentedControl.indexChangedHandler = { index in
      
            let rect = CGRect(origin: CGPoint(x: CGFloat(viewWidth * CGFloat(index)) , y: 0), size: CGSize(width: viewWidth, height: 400))
            
            self.scrollView.scrollRectToVisible( rect, animated: true)
            
            
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 190, right: 20)
        layout.itemSize = CGSize(width: 130, height: 200)
        
        layout.minimumLineSpacing = 20
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        self.scrollView.addSubview(collectionView)

        
        arrayOfItems.append(UIImageView.init(image: UIImage.init(named: "Rectangle 5")))
        arrayOfItems.append(UIImageView.init(image: UIImage.init(named: "Rectangle 6")))
        arrayOfItems.append(UIImageView.init(image: UIImage.init(named: "Rectangle 6")))
        arrayOfItems.append(UIImageView.init(image: UIImage.init(named: "Rectangle 6")))
        arrayOfItems.append(UIImageView.init(image: UIImage.init(named: "Rectangle 5")))
        arrayOfItems.append(UIImageView.init(image: UIImage.init(named: "Rectangle 4")))
        
        
        
      //   arrayOfItems.insert((UIImageView.init(image: UIImage.init(named: ""))), at: 0)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfItems.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
      
        let view = arrayOfItems[indexPath.row ]
        
        cell.contentView.addSubview(view)
        
        return cell
    }
    
    
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        
        super .viewWillAppear(animated)
        
        transformView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        transformView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        let image : UIImage = UIImage(named:"Rectangle 4")!
        
        container.image = image
        
        container.layer.cornerRadius = 5
        
     
        
        
        transformView.backgroundColor = UIColor.clear
        transformView.layer.cornerRadius = 5
        transformView.layer.masksToBounds = true;
        
        transformView.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y: -5), boundsSize: self.container.frame.size)
        
        
        transformView.contentView.addSubview(container)
        
        self.view.addSubview(transformView)
        
        transformView.diffuseLightFactor = -1.2;
        
        var perspective = CATransform3DIdentity;
        
        perspective.m34 = -1.0/divider;
        
        transformView.supplementaryTransform = perspective
        
        
   /*
        arrayOfItems.insert((UIImageView.init(image: UIImage.init(named: ""))), at: 0)
        
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.transformView.frame.origin.x -= 75
            
         //   self.transformView.frame.origin.y -= 1

        }, completion: { (finish) in
            
            arrayOfItems.remove(at: 0)
            
            self.waveAnimation(view: self.transformView)
            
            arrayOfItems.insert((UIImageView.init(image: UIImage.init(named: "Rectangle 4"))), at: 0)
            
            self.collectionView.reloadData()
            
           
            
        })
   //       self.transformView.removeFromSuperview()
   
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.transformView.removeFromSuperview()
            
        }
       */
        
        
        
        
    }
    */
    
    
  
    
    
    @IBAction func dissmisButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func transformWaveAnimation(scaleX: CGFloat,scaleY: CGFloat,scaleZ: CGFloat) -> CATransform3D {
        
        var transform = CATransform3DIdentity
        
        transform.m34 = -1.0/divider
        
        return CATransform3DScale(transform, scaleX, scaleY, scaleZ)
        
    }
    
    
    
    
    
    func waveAnimation(view: BCMeshTransformView) {
        
     // view.meshTransform = BCMutableMeshTransform.curtainMeshTransform(at: CGPoint(x:0,y: 30), boundsSize: self.container.frame.size)
        
        
        UIView.animate(withDuration: self.animationDuration, animations: {
            
            //   self.animateShadowToOpacity(from: 0.0, to: 0.8, duration:  self.animationDuration, offsetTo: CGSize(width: 0,height: 8), forView: view)
            
            self.animateWith(startPoint: -5, endPoint: 30, view: view)
            
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
