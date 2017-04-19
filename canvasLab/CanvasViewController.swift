//
//  CanvasViewController.swift
//  canvasLab
//
//  Created by Gerard Recinto on 4/12/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class CanvasViewController: ViewController {

    @IBOutlet weak var trayView: UIView!
  var newlyCreatedFace: UIImageView!
  var newlyCreatedFaceOriginalCenter: CGPoint!

    var trayOriginalCenter: CGPoint!
  var trayDownOffset: CGFloat!
  var trayUp: CGPoint!
  var trayDown: CGPoint!
  @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    if (sender.state == .began){
      trayOriginalCenter = trayView.center
    } else if sender.state == .changed {
      trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    } else if sender.state == .ended {
      var velocity = sender.velocity(in: view)
      if (velocity.y > 0){
        //moving down
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = self.trayDown
        }, completion: nil)
      } else {
        //moving up
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
var imageView = sender.view as! UIImageView
    newlyCreatedFace = UIImageView(image: imageView.image)
      newlyCreatedFace.isUserInteractionEnabled = true
      view.addSubview(newlyCreatedFace)
    newlyCreatedFace.center = imageView.center
      newlyCreatedFace.center.y += trayView.frame.origin.y
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
    } else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
    } else if sender.state == .ended {
      print("Gesture ended")
    }
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      trayDownOffset = 250
      trayUp = trayView.center
      trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
