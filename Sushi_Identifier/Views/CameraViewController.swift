//
//  CameraViewController.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/10/31.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class CameraViewController: UIViewController {
  private let disposeBag = DisposeBag()
  let captureSession: AVCaptureSession =  .init()
  let imageOutput: AVCapturePhotoOutput = .init()
  let settings: AVCapturePhotoSettings = .init()
  var previewLayer: AVCaptureVideoPreviewLayer = .init()
  var cameraDevices: AVCaptureDevice!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Camera"
    settingSession()
    edgesForExtendedLayout = []//navigation bar とviewが被らないように
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    navigationController?.setNavigationBarHidden(true, animated: false)
    startCapture()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    stopCapture()
  }
}


extension CameraViewController:AVCapturePhotoCaptureDelegate{
  @IBAction func shootButton(_ sender: Any) {
   print("シャッター押してるで!!")
   settings.flashMode = .auto
   // カメラの手ぶれ補正
   settings.isAutoStillImageStabilizationEnabled = true
   UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, 0.0)
   
   //スクショの処理を記述
   imageOutput.capturePhoto(with: settings, delegate: self)
  }

  //出力するimageDataに関すること(トリミングなど)
  internal func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
   let imageData = photo.fileDataRepresentation()
   let trimmedImg = trimmingImage((UIImage(data: imageData!))!)
   let jpegImageDate = trimmedImg.jpegData(compressionQuality: 1)
   let udf = UserDefaults.standard
   udf.set(jpegImageDate, forKey: "imageData")

   let resultViewController = UIStoryboard(name: "Result", bundle: nil).instantiateInitialViewController() as! UIViewController
   self.view.window?.rootViewController!.present(resultViewController, animated: true, completion: nil)
  }

  // カメラの設定やセッションの組み立てはここで行う
  func settingSession()
  {
   let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
   // プロパティの条件を満たしたカメラデバイスの取得
   let devices = deviceDiscoverySession.devices
   for device in devices {
     if device.position == AVCaptureDevice.Position.back {
       cameraDevices = device
     }
   }
   //バックカメラからVideoInputを取得
   let videoInput: AVCaptureInput!
   do {
     videoInput = try AVCaptureDeviceInput.init(device: cameraDevices)
   } catch {
     videoInput = nil
   }
   
   //セッションに追加
   captureSession.addInput(videoInput)
   captureSession.addOutput(imageOutput)
   //画像を表示するレイヤーを生成
   previewLayer = .init(session: captureSession)
   previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
   previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
   //Viewに追加
   self.view.layer.insertSublayer(previewLayer, at: 0)
  }


  //カメラ起動(セッションをスタート)
  func startCapture() {
   captureSession.startRunning()
  }

  // カメラを閉じる(セッションをストップ)
  func stopCapture() {
   captureSession.stopRunning()
  }

  //正方形にトリミング
  func trimmingImage(_ image: UIImage) -> UIImage {
   let posX: CGFloat = image.size.width - image.size.height/2.9
   let posY: CGFloat = 0.0
   let edge: CGFloat = image.size.width
   let rect: CGRect = CGRect(x : posX, y : posY, width : edge, height : edge)
   let imgRef = image.cgImage?.cropping(to: rect)
   let trimImage = UIImage(cgImage: imgRef!, scale: image.scale, orientation: image.imageOrientation)
   return trimImage
  }
}
