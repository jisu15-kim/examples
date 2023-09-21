//
//  ThirdViewController.swift
//  FunctionUseCase
//
//  Created by 김지수 on 2023/09/22.
//

import UIKit

class ThirdViewController: UIViewController {
    //MARK: - Properties
    let footerButton = FooterActionButton(title: "🚨Delegate 방식 탭", fontSize: 17, backgroundColor: .systemBlue, style: .inside(inset: 20))
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButton()
        self.setupUI()
        self.navigationItem.title = "세번째 뷰"
    }
    
    //MARK: - Methods
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.footerButton)
        self.footerButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupButton() {
        self.footerButton.delegate = self
    }
}

/// Protocol을 이용한 delegate 방식으로 액션을 전달받습니다.
extension ThirdViewController: FooterActionButtonDelegate {
    func singleTapEvent() {
        print("버튼 눌렸어요")
    }
    
    func tripleTapEvent() {
        print("버튼 세번 눌렸어요")
    }
}
