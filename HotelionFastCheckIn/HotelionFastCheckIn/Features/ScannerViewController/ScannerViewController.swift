//
//  ScannerViewController.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 27.01.2021.
//

import UIKit
import AVFoundation
import HotelionCommon

public protocol ScannerCoordinatorDelegate: class {
    func found(code: String, from viewController: ScannerViewController)
    func dismiss(from viewController: ScannerViewController)
}

final public class ScannerViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private var closeButton: UIButton!

    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    public weak var coordinatorDelegate: ScannerCoordinatorDelegate?

    // MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()

        closeButton.layer.cornerRadius = 20
        closeButton.layer.masksToBounds = true
        closeButton.layer.zPosition = 100
        closeButton.backgroundColor = .white

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    override public var prefersStatusBarHidden: Bool {
        return true
    }

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    func failed() {
        AlertHelper.show(title: "Scanning not supported",
                         message: "Your device does not support scanning a code from an item. Please use a device with a camera.")
        captureSession = nil
    }

    func found(code: String) {
        coordinatorDelegate?.found(code: code, from: self)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        coordinatorDelegate?.dismiss(from: self)
    }
}

// MARK: - Actions
private extension ScannerViewController {
    @IBAction func closeAction(_ sender: Any) {
        coordinatorDelegate?.dismiss(from: self)
    }
}
