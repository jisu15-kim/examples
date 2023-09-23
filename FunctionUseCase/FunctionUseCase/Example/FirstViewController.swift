//
//  FirstViewController.swift
//  FunctionUseCase
//
//  Created by 김지수 on 2023/09/22.
//

import UIKit

class FirstViewController: UIViewController {
    //MARK: - Properties
    /// 👉지연 저장 프로퍼티를 이용해 변수 선언과 동시에 액션을 지정해줍니다.
    lazy var footerButton = FooterActionButton(title: "계속하기", fontSize: 18, backgroundColor: .systemIndigo, style: .inside(inset: 16)) { [weak self] in
        // 👇 여기서 버튼 클릭 액션을 정의합니다.
        self?.someAction()
    } tripleTapHandler: {
        // 👇 여기서 트리플 버튼 클릭 액션을 정의합니다.
        print("버튼이 세번 눌렸어요🔔")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.navigationItem.title = "첫번째 뷰"
    }
    
    //MARK: - Methods
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.footerButton)
        self.footerButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func someAction() {
        print(#function)
    }
}
