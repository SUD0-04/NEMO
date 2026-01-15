//
//  CameraView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

// 촬영만을 위하여 존재하는 별도의 View
// 촬영 컨셉은 아직 구상중

import SwiftUI

struct CameraView: View {
    @StateObject private var camera = CameraManager()
    @State private var isFlashing = false // 셔터 효과용

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            GeometryReader { geometry in
                let width = geometry.size.width
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    // 정방형 미리보기
                    ZStack {
                        CameraPreview(cameraManager: camera, size: CGSize(width: width, height: width))
                            .frame(width: width, height: width)
                            .clipped()
                        
                        // 셔터 효과 레이어
                        if isFlashing {
                            Color.white
                                .frame(width: width, height: width)
                                .opacity(0.8)
                        }
                    }
                    
                    Spacer()
                    
                    // 촬영 버튼
                    Button(action: {
                        camera.capture()
                        // 셔터 애니메이션
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isFlashing = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation { isFlashing = false }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 75, height: 75)
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                                .frame(width: 85, height: 85)
                        }
                    }
                    .padding(.bottom, 120)
                }
            }
        }
        .onAppear {
            camera.setup()
        }
    }
}
