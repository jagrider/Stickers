//
//  CanvasViewController.swift
//  Stickers
//
//  Created by Jonathan Grider on 2/21/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
  
  @IBOutlet weak var trayView: UIView!
  
  var trayOriginalCenter: CGPoint!
  var trayDownOffset: CGFloat!
  var trayUp: CGPoint!
  var trayDown: CGPoint!
  var newlyCreatedFace: UIImageView!
  var newlyCreatedFaceOriginalCenter: CGPoint!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    trayDownOffset = 200
    trayUp = trayView.center
    trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    
    let translation = sender.translation(in: view)
    
    if sender.state == .began {
      trayOriginalCenter = trayView.center
    } else if sender.state == .changed {
      trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    } else if sender.state == .ended {
      let velocity = sender.velocity(in: view)
      
      if velocity.y > 0 {
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = self.trayDown
        }, completion: nil)
      } else {
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = self.trayUp
        }, completion: nil)
      }
    }
  }
  
  
  @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    if sender.state == .began {
      let imageView = sender.view as! UIImageView
      newlyCreatedFace = UIImageView(image: imageView.image)
      newlyCreatedFace.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:))))
      newlyCreatedFace.isUserInteractionEnabled = true
      view.addSubview(newlyCreatedFace)
      newlyCreatedFace.center = imageView.center
      newlyCreatedFace.center.y += trayView.frame.origin.y
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
      self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    } else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
    } else if sender.state == .ended {
      self.newlyCreatedFace.transform = CGAffineTransform.identity
    }
    
  }
  
  @objc func didPan(sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    if sender.state == .began {
      newlyCreatedFace = sender.view as! UIImageView
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
      self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    } else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
    } else if sender.state == .ended {
      self.newlyCreatedFace.transform = CGAffineTransform.identity
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
