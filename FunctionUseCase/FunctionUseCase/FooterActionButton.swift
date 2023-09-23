//
//  FooterActionButton.swift
//  FunctionUseCase
//
//  Created by 김지수 on 2023/09/22.
//

import UIKit
import SnapKit

protocol FooterActionButtonDelegate: AnyObject {
    func singleTapEvent()
    func tripleTapEvent()
}

class FooterActionButton: UIView {
    enum ButtonStyle {
        case inside(inset: CGFloat)
        case fill
        
        var inset: CGFloat {
            switch self {
            case .inside(let inset): return inset
            case .fill: return 0
            }
        }
        
        func getViewBackground(_ viewBackgroundColor: UIColor) -> UIColor {
            switch self {
            case .inside(_): return .systemBackground
            case .fill: return viewBackgroundColor
            }
        }
    }
    
    //MARK: - Properties
    weak var delegate: FooterActionButtonDelegate?
    /// 배경색
    private let viewBackgroundColor: UIColor
    /// 버튼 타이틀
    private let titleString: String
    /// 버튼 탭 이벤트
    var tapHandler: (() -> Void)?
    /// 버튼 스타일
    private let buttonStyle: ButtonStyle
    /// 폰트 사이즈
    private let fontSize: CGFloat
    /// 클릭 카운트
    private var tapCount = 0 {
        didSet {
            self.observeTapCount()
        }
    }
    /// 트리플 탭 이벤트
    var tripleTapHandler: (() -> Void)?
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = backgroundColor
        button.tintColor = .white
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    init(title: String, fontSize: CGFloat = 17, backgroundColor: UIColor, style: ButtonStyle, handler: (() -> Void)? = nil, tripleTapHandler: (() -> Void)? = nil) {
        self.titleString = title
        self.viewBackgroundColor = backgroundColor
        self.tapHandler = handler
        self.tripleTapHandler = tripleTapHandler
        self.buttonStyle = style
        self.fontSize = fontSize
        super.init(frame: .zero)
        self.setupUI()
        self.setButtonTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupUI() {
        let safeAreaBottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        
        // 배경색 설정
        self.backgroundColor = self.buttonStyle.getViewBackground(self.viewBackgroundColor)
        self.actionButton.backgroundColor = self.viewBackgroundColor
        
        // 레이아웃
        self.addSubview(self.actionButton)
        self.actionButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(self.buttonStyle.inset)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(safeAreaBottomInset + 10)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(safeAreaBottomInset + 60)
        }
        
        // 코너 라운드
        self.actionButton.layer.cornerRadius = 10
        self.actionButton.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        // 그림자
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    private func setButtonTitle() {
        let attributeTitle = NSAttributedString(string: titleString, attributes: [.font: UIFont.boldSystemFont(ofSize: fontSize), .foregroundColor: UIColor.white])
        actionButton.setAttributedTitle(attributeTitle, for: .normal)
    }
    
    // 세번 클릭하면 tripleTapEvent 호출
    private func observeTapCount() {
        if self.tapCount == 3 {
            // 함수형 프로그래밍 호출
            self.tripleTapHandler?()
            // delegate 방식 호출
            self.delegate?.tripleTapEvent()
        }
    }
    
    @objc private func actionButtonTapped() {
        self.tapHandler?()
        self.delegate?.singleTapEvent()
        self.tapCount += 1
    }
}
