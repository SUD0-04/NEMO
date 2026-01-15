//
//  SearchButton.swift
//  NEMO
//
//  Created by SUDØ on 1/13/26.
//

import SwiftUI

struct SearchButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .bold))
                .frame(width: 44, height: 44)
                .background(.thinMaterial)
                .clipShape(Circle())
        }
    }
}

//#Preview {
//    SearchButton()
//}

#Preview {
    SearchButton(action: {})
        .padding()
}
