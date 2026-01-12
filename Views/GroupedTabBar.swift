//
//  GroupedTabBar.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

import SwiftUI

struct GroupedTabBar: View {
    @Binding var selectedTab: MainTab

    var body: some View {
        HStack(spacing: 4) {
            GroupedTabItemView(
                icon: "camera.fill",
                title: "Shot",
                isSelected: selectedTab == .camera
            ) {
                selectedTab = .camera
            }

            GroupedTabItemView(
                icon: "photo.on.rectangle",
                title: "Film",
                isSelected: selectedTab == .gallery
                //이후에 아이콘을 필름통 이미지와 같이 변경(예정)
            ) {
                selectedTab = .gallery
            }
        }
        .padding(6)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .shadow(radius: 8)
        )
    }
}


#Preview {
    @Previewable @State var tab: MainTab = .camera

    GroupedTabBar(selectedTab: $tab)
        .padding()
        .background(.black)
}
