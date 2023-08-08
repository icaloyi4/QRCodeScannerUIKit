//
//  PaymentController.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import UIKit
import AVFoundation

class PaymentController:  UIViewController {
    
    var presenter : PaymentViewToPresenterProtocol?
    
    @IBOutlet weak var lbl_footer_message: UILabel!
    @IBOutlet weak var pg_loading: UIActivityIndicatorView!
    @IBOutlet weak var back_btn: UINavigationBar!
    @IBOutlet weak var btn_scan: UIImageView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        PaymentRoute.createModule(ref: self)
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PaymentController.imageTapped(gesture:)))
        
        // add it to the image view;
        btn_scan.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        btn_scan.isUserInteractionEnabled = true
        
        setupQRCode()
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()

        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        
    }
    @IBAction func close_btn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    @objc func dismissScreen(notification: Notification){


    let dismissScreen : NSNumber = notification.userInfo!["dismissScreen"] as! NSNumber

        if (dismissScreen.boolValue) {
            dismiss(animated: true){
                print("ilang")
            }
        }
    }

    
    @objc func imageTapped(gesture: UIGestureRecognizer)   {
        // if the tapped view is a UIImageView then set it to imageview
        
        if (gesture.view as? UIImageView) != nil  {
            Task{
                let isValid = await presenter?.doingPayment(code: "BNI.ID12345678.MERCHANT MOCK TEST.50000")
                //Here you can initiate your new ViewController
                
                if (isValid ?? false) {
                    hideQR(isHidden: false)
                    setFooterMessage(message: "Point the camera to the qrcode")
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let successController = storyBoard.instantiateViewController(withIdentifier: "success_controller") as! SuccessController
                    successController.modalPresentationStyle = .fullScreen
                    
                    self.present(successController, animated: true) {
                        let codeArray = ("BNI.ID12345678.MERCHANT MOCK TEST.50000" ).components(separatedBy: ".")
                        let transactionHistory = TransactionHistory(id: codeArray[1], bank: codeArray[0], merchant: codeArray[2], value: Int(codeArray[3]))
                        successController.lbl_ammount.text = "Rp. \( transactionHistory.value ?? 0)"
                        successController.lbl_merchant.text = "\(transactionHistory.merchant ?? "")"
                        successController.lbl_idtrans.text = "\((transactionHistory.id ?? ""))"
                        
                    }
                    NotificationCenter.default.addObserver(self, selector: #selector(self.dismissScreen(notification:)), name: Notification.Name("dismissScreen"), object: nil)
                    
                    
                }
            }
            
        }
    }
    
}

extension PaymentController : PaymentPresenterToViewProtocol {
    func hideQR(isHidden: Bool) {
        
        DispatchQueue.main.async{
            if isHidden {
                self.btn_scan.isHidden = true
//                self.view.layoutIfNeeded()
                
                self.pg_loading.isHidden = false
                self.view.layoutIfNeeded()
            } else {
                self.btn_scan.isHidden = false
//                self.view.layoutIfNeeded()
                
                self.pg_loading.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
       
    }
    
    func setFooterMessage(message: String) {
        DispatchQueue.main.async{
            self.lbl_footer_message.text = message
        }
       
    }
    
    
}

extension PaymentController: AVCaptureMetadataOutputObjectsDelegate {
    func setupQRCode(){
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)

        guard let captureDevice = deviceDiscoverySession.devices.first else {
            lbl_footer_message.text = "Failed to get the camera device"
            hideQR(isHidden: false)
            return
        }

        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)

            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            // Start video capture.
            captureSession.startRunning()
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            lbl_footer_message.text = "No QR code is detected"
            return
        }

        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
//                lbl_footer_message.text = metadataObj.stringValue
                Task{
                    let isValid = await presenter?.doingPayment(code: metadataObj.stringValue)
                    //Here you can initiate your new ViewController
                    
                    if (isValid ?? false) {
                        hideQR(isHidden: false)
                        setFooterMessage(message: "Point the camera to the qrcode")
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let successController = storyBoard.instantiateViewController(withIdentifier: "success_controller") as! SuccessController
                        successController.modalPresentationStyle = .fullScreen
                        
                        self.present(successController, animated: true) {
                            let codeArray = ("BNI.ID12345678.MERCHANT MOCK TEST.50000" ).components(separatedBy: ".")
                            let transactionHistory = TransactionHistory(id: codeArray[1], bank: codeArray[0], merchant: codeArray[2], value: Int(codeArray[3]))
                            successController.lbl_ammount.text = "Rp. \( transactionHistory.value ?? 0)"
                            successController.lbl_merchant.text = "\(transactionHistory.merchant ?? "")"
                            successController.lbl_idtrans.text = "\((transactionHistory.id ?? ""))"
                            
                        }
                        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissScreen(notification:)), name: Notification.Name("dismissScreen"), object: nil)
                        
                        
                    }
                }
            }
        }
    }
}
