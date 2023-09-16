//
//  VehicleExampleConfigs.swift
//  NiceSimplePicker
//
//  Created by Jisu Kim on 2023/09/16.
//

import Foundation

enum VehicleExampleConfigs: CaseIterable {
    case car
    case motorcycle
    case bicycle
    case airplane
    case boat
    case train
    case bus
    
    var title: String {
        switch self {
        case .car: return "자동차"
        case .motorcycle: return "오토바이"
        case .bicycle: return "자전거"
        case .airplane: return "비행기"
        case .boat: return "보트"
        case .train: return "기차"
        case .bus: return "버스"
        }
    }
    
    var id: Int {
        switch self {
        case .car: return 0
        case .motorcycle: return 1
        case .bicycle: return 2
        case .airplane: return 3
        case .boat: return 4
        case .train: return 5
        case .bus: return 6
        }
    }
    
    var pickerConfig: NiceSimplePickerConfig {
        return NiceSimplePickerConfig(id: self.id, title: self.title)
    }
}
