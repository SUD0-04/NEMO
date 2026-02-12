//
//  CapsuleTabBar.swift
//  NEMO
//
//  Created by SUDØ on 1/15/26.
//

import SwiftUI

struct CapsuleTabBar: View {
    let size: CGSize
    @Binding var selectedTab: MainTab
    @Namespace private var selectionAnimation

    var body: some View {
        HStack(spacing: 4) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                tabButton(tab)
            }
        }
        .padding(4)
        .frame(width: size.width, height: size.height)
        .glassEffect(.regular.interactive(), in: .capsule)
    }

    private func tabButton(_ tab: MainTab) -> some View {
        Button {
            withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                selectedTab = tab
            }
        } label: {
            ZStack {
                if selectedTab == tab {
                    Capsule()
                        .fill(Color.white.opacity(0.22))
                        .matchedGeometryEffect(id: "tabSelection", in: selectionAnimation)
                }

                VStack(spacing: 1) {
                    Image(systemName: tab.symbolName)
                        .font(.system(size: 17, weight: .semibold))
                    Text(tab.displayTitle)
                        .font(.custom("Futura-Medium", size: 10))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Capsule())
        }
        .buttonStyle(TabPressStyle())
    }
}

private struct TabPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

#Preview {
    CapsuleTabBarPreview()
}

private struct CapsuleTabBarPreview: View {
    @State private var tab: MainTab = .shot

    var body: some View {
        GeometryReader { proxy in
            CapsuleTabBar(
                size: proxy.size,
                selectedTab: $tab
            )
        }
        .frame(height: 55)
        .glassEffect(.regular.interactive(), in: .capsule)
        .padding()
    }
}
