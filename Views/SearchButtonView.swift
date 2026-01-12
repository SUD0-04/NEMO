//
//  SearchButtonView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

// 검색 버튼만을 위한 별도의 View
// 추후 iOS26 이후에서 작동 가능하며, Liquid Glass 디자인을 최대한 적용한 코드로 변경 예정

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
