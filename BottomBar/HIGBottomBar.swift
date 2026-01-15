//
//  HIGBottomBar.swift
//  NEMO
//
//  Created by SUDØ on 1/13/26.
//

import SwiftUI

struct HIGBottomBar: View {
    @Binding var selectedTab: TabItem
    let onSearchTap: () -> Void

    var body: some View {
        HStack(spacing: 32) {
            // 📸 촬영
            TabButton(
                title: TabItem.camera.title,
                systemImage: TabItem.camera.systemImage,
                isSelected: selectedTab == .camera
            ) {
                selectedTab = .camera
            }

            // 🖼 갤러리
            TabButton(
                title: TabItem.gallery.title,
                systemImage: TabItem.gallery.systemImage,
                isSelected: selectedTab == .gallery
            ) {
                selectedTab = .gallery
            }

            Spacer(minLength: 16)

            // 🔍 검색 (분리)
            SearchButton {
                onSearchTap()
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

#Preview {
    HIGBottomBar(
        selectedTab: .constant(.camera),
        onSearchTap: {}
    )
}
