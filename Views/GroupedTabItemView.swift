//
//  GroupedTabItemView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

import SwiftUI

struct GroupedTabItemView: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))

                Text(title)
                    .font(.caption2)
            }
            .foregroundStyle(isSelected ? .primary : .secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background {
                if isSelected {
                    Capsule()
                        .fill(.thinMaterial)
                }
            }
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.35, dampingFraction: 0.85),
                   value: isSelected)
    }
}


#Preview {
    GroupedTabItemView(
        icon: "camera.fill",
        title: "촬영",
        isSelected: true
    ) {
        // Preview용 더미 액션
    }
    .padding()
    .background(.black)
}

