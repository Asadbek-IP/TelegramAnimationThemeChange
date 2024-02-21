//
//  RectKey.swift
//  AnimationThemeChange
//
//  Created by Mac Mini 1 on 21/02/24.
//

import Foundation

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
