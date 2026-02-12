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
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 55, height: 55)
                .glassEffect(.regular.interactive(), in: .circle)
        }
    }
}

#Preview {
    SearchFloatingButton {
        print("Search tapped")
    }
    .padding()
}
