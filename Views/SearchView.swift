//
//  SearchView.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        Color.black
            .overlay(
                Text("사진검색")
                    .foregroundStyle(.white)
                // 아날로그 휠을 사용한 사진 검색 기능
            )
    }
}

#Preview {
    SearchView()
}
