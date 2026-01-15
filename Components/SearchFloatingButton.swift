//
//  SearchFloatingButton.swift
//  NEMO
//
//  Created by SUDØ on 1/15/26.
//

import SwiftUI

struct SearchFloatingButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(width: 44, height: 44)
                .background(.regularMaterial)
                .clipShape(Circle())
        }
    }
}

#Preview {
    SearchFloatingButton {
        print("Search tapped")
    }
    .padding()
}
