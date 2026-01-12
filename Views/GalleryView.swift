//
//  GalleryView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

// 본 앱을 통해 촬영된 내용을 보여주는 View
// 날짜별로 묶거나, 스크랩 북으로 만드는 등의 기능 추가 예정

import SwiftUI

struct GalleryView: View {
    var body: some View {
        Color.black
            .overlay(
                Text("갤러리")
                    .foregroundStyle(.white)
            )
    }
}

#Preview {
    GalleryView()
}
