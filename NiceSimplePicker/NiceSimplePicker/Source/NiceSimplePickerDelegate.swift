//
//  NiceSimplePickerDelegate.swift
//  NiceSimplePicker
//
//  Created by Jisu Kim on 2023/09/16.
//

import Foundation

protocol NiceSimplePickerDelegate: AnyObject {
    func didTappedSelection(picker: NiceSimplePickerView, index: Int)
    func didTappedSelection(picker: NiceSimplePickerView, config: NiceSimplePickerConfig)
}

extension NiceSimplePickerDelegate {
    func didTappedSelection(picker: NiceSimplePickerView, index: Int) {}
    func didTappedSelection(picker: NiceSimplePickerView, config: NiceSimplePickerConfig) {}
}
