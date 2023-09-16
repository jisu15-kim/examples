//
//  PickingCell.swift
//  NiceSimplePicker
//
//  Created by Jisu Kim on 2023/09/16.
//

import UIKit

class NiceSimplePickerCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "NiceSimplePickerCell"
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var cellTintColor: UIColor = .systemIndigo
    var pickerConfig: NiceSimplePickerConfig? {
        didSet {
            configure()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            configureSelection()
        }
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupUI() {
        
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.layer.cornerRadius = 40 / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func configure() {
        guard let config = self.pickerConfig else { return }
        self.contentLabel.text = config.title
        self.configureSelection()
    }
    
    private func configureSelection() {
        let selection: PickerCellSelectConfig = isSelected ? .selected : .none
        self.layer.borderColor = selection.getBorderColor(cellTintColor)
        self.layer.borderWidth = selection.borderWidth
        self.contentLabel.textColor = selection.getTextColor(cellTintColor)
    }
}

enum PickerCellSelectConfig {
    case selected
    case none
    
    var borderWidth: CGFloat {
        switch self {
        case .selected: return 2
        case .none: return 1
        }
    }
    
    func getTextColor(_ tintColor: UIColor) -> UIColor {
        switch self {
        case .selected: return tintColor
        case .none: return .lightGray
        }
    }
    
    func getBorderColor(_ tintColor: UIColor) -> CGColor {
        switch self {
        case .selected: return tintColor.cgColor
        case .none: return UIColor.lightGray.cgColor
        }
    }
}
