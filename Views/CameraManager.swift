//
//  CameraManager.swift
//  NEMO
//
//  Created by SUDØ on 1/15/26.
//

import Foundation
import AVFoundation
import UIKit
import Combine // @Published를 위해 필수

class CameraManager: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let sessionQueue = DispatchQueue(label: "com.kaan.camera.session")
    private var isSessionConfigured = false
    private var shouldRunSession = false
    
    func setup() {
        start()
    }

    func start() {
        sessionQueue.async { [weak self] in
            self?.shouldRunSession = true
        }
        checkPermissions()
    }

    func stop() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            self.shouldRunSession = false
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }
    
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            configureAndStartSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
                if status {
                    self?.configureAndStartSession()
                }
            }
        default: break
        }
    }
    
    private func configureAndStartSession() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            guard self.shouldRunSession else { return }

            if !self.isSessionConfigured {
                self.session.beginConfiguration()
                defer { self.session.commitConfiguration() }

                guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                      let input = try? AVCaptureDeviceInput(device: device),
                      self.session.canAddInput(input),
                      self.session.canAddOutput(self.output) else { return }

                self.session.addInput(input)
                self.session.addOutput(self.output)
                self.isSessionConfigured = true
            }

            if !self.session.isRunning {
                self.session.startRunning()
            }
        }
    }
    
    func capture() {
        #if targetEnvironment(simulator)
        print("시뮬레이터에서는 카메라가 작동하지 않습니다.")
        #else
        guard session.isRunning else { return }
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
        #endif
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("촬영 에러: \(error.localizedDescription)")
            return
        }

        autoreleasepool {
            guard let data = photo.fileDataRepresentation(),
                  let image = UIImage(data: data) else { return }

            let squareImage = cropToSquare(image: image)

            // 앨범에 저장
            UIImageWriteToSavedPhotosAlbum(squareImage, nil, nil, nil)
        }
    }
    
    // return 문 뒤에 코드가 없도록 정리
    private func cropToSquare(image: UIImage) -> UIImage {
        let originalWidth = image.size.width
        let originalHeight = image.size.height
        let edge = min(originalWidth, originalHeight)
        
        let xOffset = (originalWidth - edge) / 2
        let yOffset = (originalHeight - edge) / 2
        
        let cropRect = CGRect(x: xOffset, y: yOffset, width: edge, height: edge)
        
        // cgImage 추출 후 크롭 진행
        guard let cgImage = image.cgImage?.cropping(to: cropRect) else {
            return image
        }
        
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}
