//
//  SecondViewController.swift
//  FunctionUseCase
//
//  Created by 김지수 on 2023/09/22.
//

import UIKit

class SecondViewController: UIViewController {
    //MARK: - Properties
    let footerButton = FooterActionButton(title: "⭐️눌러봐요", fontSize: 18, backgroundColor: .systemBlue, style: .fill)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButton()
        self.setupUI()
        self.navigationItem.title = "두번째 뷰"
    }
    
    //MARK: - Methods
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.footerButton)
        self.footerButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    /// 👉버튼 내부의 변수에 접근하여 각 이벤트에서 호출될 함수를 정의해줍니다.
    private func setupButton() {
        // 버튼 탭 이벤트 정의
        self.footerButton.tapHandler = {
            print("버튼이 눌렸어요")
        }
        
        // 세번 눌림 액션 정의
        self.footerButton.tripleTapHandler = { [weak self] in
            self?.tripleButtonTapEvent()
        }
    }
    
    private func tripleButtonTapEvent() {
        print(#function)
    }
}
