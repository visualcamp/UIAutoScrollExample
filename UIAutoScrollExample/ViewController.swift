//
//  ViewController.swift
//  AutoScrollTest
//
//  Created by 이다빈 on 2021/12/01.
//

import UIKit
import UIAutoScroll
import SeeSo
import MKRingProgressView
import AVFoundation

class ViewController: UIViewController {
  
  
  @IBOutlet weak var scroll: UIAutoScrollView!
  @IBOutlet weak var caliView: RingProgressView!
  @IBOutlet weak var startBtn: UIButton!
  @IBOutlet weak var blurView: UIVisualEffectView!
  @IBOutlet weak var goUpBtn: UIButton!
  @IBOutlet weak var contentsView: UILabel!
  
  var tracker : GazeTracker? = nil
  var license : String = "Input your key."
  var isCalibrated : Bool = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UIApplication.shared.isIdleTimerDisabled = true
    caliView.isHidden = true
    caliView.backgroundColor = UIColor.clear
    caliView.progress = 0.0
    scroll.contentSize = CGSize(width: contentsView.frame.width, height: readText() + 60)
    scroll.delegate = self
    startBtn.isEnabled = false
    startBtn.setTitle("Loading", for: .disabled)
    if !checkAccessCamera() {
      //If access is not possible, the user is requested to access.
      requestAccess()
    }else{
      initGazeTracker()
    }

  }
  
  @IBAction func clickStartBtn(_ sender: UIButton) {
    print("click! start")
    if sender == startBtn {
      if tracker != nil {
        setGazeTrackerSetting()
        DispatchQueue.main.async {
          sender.isHidden = true
        }
      }
    }else if sender == goUpBtn {
      scroll.setContentOffset(.zero, animated: true)
      sender.isHidden = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.scroll.startAutoScroll()
        self.tracker?.startTracking()
      }
    }
    
  }
  
  private func readText() -> CGFloat{
    print(#function)
    if let path = Bundle.main.path(forResource: "theoldmanandsea", ofType: "txt") {
      print("success : \(path)")
      if let text = try? String(contentsOfFile: path, encoding: .utf8){
        contentsView.text = text
      }
    }
    
    return contentsView.text?.height(withConstrainedWidth: self.scroll.frame.width, font: self.contentsView.font) ?? 0
  }
  
  private func checkAccessCamera() -> Bool {
    return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
  }
  
  private func requestAccess(){
    AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
      if response {
        self.initGazeTracker()
      } else {
        print("camera error!")
      }
    }
  }
  
  private func initGazeTracker(){
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      GazeTracker.initGazeTracker(license: self.license, delegate: self)
    }
  }
  
  
}

extension ViewController : UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y + scrollView.bounds.height == scrollView.contentSize.height {
      self.tracker?.removeCameraPreview()
      self.tracker?.stopTracking()
      self.scroll.stopAutoScroll()
      self.goUpBtn.isHidden = false
    }
  }
}

extension ViewController : InitializationDelegate, CalibrationDelegate, GazeDelegate {
  
  func onInitialized(tracker: GazeTracker?, error: InitializationError) {
    if tracker != nil {
      print("initSuccess")
      self.tracker = tracker
      startBtn.isEnabled = true
      startBtn.setTitle("Start", for: .normal)
    }else {
      print("errror : \(error.description)")
      startBtn.setTitle("Failed", for: .disabled)
    }
  }
  
  func setGazeTrackerSetting(){
    self.tracker?.setDelegates(statusDelegate: nil, gazeDelegate: self, calibrationDelegate: self, imageDelegate: nil)
    self.tracker?.startTracking()
    let _ = self.tracker?.startCalibration(mode: .ONE_POINT, criteria: .DEFAULT, region: UIScreen.main.bounds)
    
  }

  
  func onCalibrationNextPoint(x: Double, y: Double) {
    self.caliView.isHidden = false
    self.caliView.center = CGPoint(x: x, y: y)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
      let _ = self.tracker?.startCollectSamples()
    }
    
  }
  
  func onCalibrationProgress(progress: Double) {
    UIView.animate(withDuration: 0.1 , delay: 0, options: [.curveLinear], animations: {
      self.caliView.progress = progress
    }, completion: nil)
  }
  
  func onCalibrationFinished(calibrationData: [Double]) {
    DispatchQueue.main.async {
      self.isCalibrated = true
      self.caliView.isHidden = true
      self.blurView.isHidden = true
      
      self.scroll.startAutoScroll()
    }
  }
  
  func onGaze(gazeInfo: GazeInfo) {
    if isCalibrated {
      if gazeInfo.trackingState == .SUCCESS {
        self.scroll.calcScrollDistance(gazeY: gazeInfo.y)
      }
    }
  }
  
}

