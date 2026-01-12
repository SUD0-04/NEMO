//
//  ContentView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

// 모든 코드를 총집합하여 보여주는 View
// 한 View에서 구성이 가능한 내용을 분산하여 각각의 버그 및 오류를 잡을 수 있도록 한 구성

import SwiftUI

struct MainView: View {
    @State private var selectedTab: MainTab = .camera

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .camera:
                    CameraView()
                    // 카메라 촬영을 위한 View
                case .gallery:
                    GalleryView()
                    // 카메라 촬영본을 별도로 볼 수 있는 View
                case .search:
                    SearchView()
                    // 날짜 또는 해시태그만을 통해 검색할 수 있는 View
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            BottomBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    MainView()
}
