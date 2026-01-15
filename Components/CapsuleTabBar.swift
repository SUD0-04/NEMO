//
//  CapsuleTabBar.swift
//  NEMO
//
//  Created by SUDØ on 1/15/26.
//

import SwiftUI

struct CapsuleTabBar: UIViewRepresentable {
    let size: CGSize
    @Binding var selectedTab: MainTab

    func makeUIView(context: Context) -> UISegmentedControl {
        let control = UISegmentedControl(
            items: MainTab.allCases.map(\.rawValue)
        )
        control.selectedSegmentIndex = selectedTab.index
        control.backgroundColor = .clear
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.changed(_:)),
            for: .valueChanged
        )
        return control
    }

    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        uiView.selectedSegmentIndex = selectedTab.index
    }

    func sizeThatFits(
        _ proposal: ProposedViewSize,
        uiView: UISegmentedControl,
        context: Context
    ) -> CGSize? {
        size
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject {
        let parent: CapsuleTabBar
        init(_ parent: CapsuleTabBar) { self.parent = parent }

        @objc func changed(_ sender: UISegmentedControl) {
            parent.selectedTab = MainTab.allCases[sender.selectedSegmentIndex]
        }
    }
}

#Preview {
    CapsuleTabBarPreview()
}

private struct CapsuleTabBarPreview: View {
    @State private var tab: MainTab = .camera

    var body: some View {
        GeometryReader { proxy in
            CapsuleTabBar(
                size: proxy.size,
                selectedTab: $tab
            )
        }
        .frame(height: 44)
        .glassEffect(.regular.interactive(), in: .capsule)
        .padding()
    }
}
