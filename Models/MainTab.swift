//
//  MainTab.swift
//  NEMO
//
//  Created by SUDØ on 1/12/26.
//

// 작동을 위한 구상 모델

import Foundation

enum MainTab: String, CaseIterable {
    case shot = "Shot"
    case films = "Films"

    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }

    var symbolName: String {
        switch self {
        case .shot:
            return "camera.fill"
        case .films:
            return "photo.on.rectangle.angled"
        }
    }

    var displayTitle: String {
        switch self {
        case .shot:
            return "Shots"
        case .films:
            return "Films"
        }
    }
}
