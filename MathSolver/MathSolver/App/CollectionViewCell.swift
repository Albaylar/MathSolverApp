//
//  CollectionViewCell.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 7.12.2023.
//

import UIKit
import AVFoundation
import SnapKit

class CustomCameraViewController: UIViewController {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupBlurOverlay()
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }

        override var shouldAutorotate: Bool {
            return false
        }

    func setupCamera() {
        captureSession = AVCaptureSession()
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera.")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
        } catch {
            print("Unable to initialize camera input.")
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(previewLayer, at: 0)

        captureSession.startRunning()
    }

    func setupBlurOverlay() {
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)

        // Add other UI elements on top of the blur view
        let overlayView = UIView()
        overlayView.backgroundColor = .clear
        view.addSubview(overlayView)

        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // You can add additional UI elements to the overlayView using SnapKit
        let customLabel = UILabel()
        customLabel.text = "Custom Overlay"
        customLabel.textColor = .white
        overlayView.addSubview(customLabel)

        customLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}



