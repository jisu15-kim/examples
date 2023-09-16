//
//  PickingConfig.swift
//  NiceSimplePicker
//
//  Created by Jisu Kim on 2023/09/16.
//

import Foundation

struct NiceSimplePickerConfig: Equatable {
    // equatable: id로 비교
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
}
