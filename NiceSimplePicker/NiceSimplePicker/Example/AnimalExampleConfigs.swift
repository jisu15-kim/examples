//
//  ExamplePickerConfig.swift
//  NiceSimplePicker
//
//  Created by Jisu Kim on 2023/09/16.
//

import Foundation

enum AnimalExampleConfigs: CaseIterable {
    case horse
    case rabbit
    case dolphin
    case cat
    
    var title: String {
        switch self {
        case .horse: return "말"
        case .rabbit: return "토끼"
        case .dolphin: return "돌고래"
        case .cat: return "고양이"
        }
    }
    
    var id: Int {
        switch self {
        case .horse: return 0
        case .rabbit: return 1
        case .dolphin: return 2
        case .cat: return 3
        }
    }
    
    var pickerConfig: NiceSimplePickerConfig {
        return NiceSimplePickerConfig(id: self.id, title: self.title)
    }
}
