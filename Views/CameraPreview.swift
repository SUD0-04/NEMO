//
//  CameraPreview.swift
//  NEMO
//
//  Created by SUDØ on 1/15/26.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraManager: CameraManager
    let size: CGSize // UIScreen.main 대신 실제 할당된 크기를 전달받음

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect(origin: .zero, size: size))
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: cameraManager.session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = CGRect(origin: .zero, size: size)
        
        view.layer.addSublayer(previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            layer.frame = CGRect(origin: .zero, size: size)
        }
    }
}
