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
    @State private var selectedTab: MainTab = .shot
    @State private var showSearch = false

    var body: some View {
        ZStack {
            // 메인 콘텐츠
            Group {
                switch selectedTab {
                case .shot:
                    CameraView()
                case .films:
                    GalleryView()
                }
            }

            // 하단 UI
            VStack {
                Spacer()

                HStack(spacing: 12) {
                    GeometryReader { proxy in
                        CapsuleTabBar(
                            size: proxy.size,
                            selectedTab: $selectedTab
                        )
                    }
                    .frame(height: 55)
                    .glassEffect(.regular.interactive(), in: .capsule)

                    SearchFloatingButton {
                        showSearch = true
                    }
                }
                .frame(height: 44)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showSearch) {
            SearchView()
        }
    }
}

#Preview {
    MainView()
}
