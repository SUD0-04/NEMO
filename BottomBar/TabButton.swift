//
//  TabButton.swift
//  NEMO
//
//  Created by SUDØ on 1/13/26.
//

import SwiftUI

struct TabButton: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))

                Text(title)
                    .font(.caption2)
            }
            .foregroundStyle(isSelected ? .primary : .secondary)
        }
    }
}

//#Preview {
//    TabButton()
//}

#Preview {
    TabButton(
        title: "촬영",
        systemImage: "camera",
        isSelected: true,
        action: {}
    )
    .padding()
}
