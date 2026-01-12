//
//  SearchButtonView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

import SwiftUI

struct SearchButtonView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(width: 56, height: 56)
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                        .shadow(radius: 10)
                )
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    SearchButtonView {
        print("Search tapped")
    }
    .padding()
    .background(.black)
}
