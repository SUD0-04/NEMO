//
//  BottomBar.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

// 하단 기능 bar구성을 위한 view
// 현재 Liquid Glass 디자인 적용을 위한 구상 중

import SwiftUI

struct BottomBar: View {
    @Binding var selectedTab: MainTab

    var body: some View {
        HStack {
            GroupedTabBar(selectedTab: $selectedTab)

            Spacer()

            SearchButtonView {
                selectedTab = .search
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

#Preview {
    @Previewable @State var tab: MainTab = .gallery
    BottomBar(selectedTab: $tab)
        .background(.black)
}
