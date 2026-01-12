//
//  ContentView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: MainTab = .camera

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .camera:
                    CameraView()
                case .gallery:
                    GalleryView()
                case .search:
                    SearchView()
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
