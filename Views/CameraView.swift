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
    var body: some View {
        Color.black
            .overlay(
                Text("📸")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                // 빈티지 카메라 이미지를 사용할 예정
            )
    }
}

#Preview {
    CameraView()
}
