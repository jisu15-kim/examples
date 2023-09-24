//
//  ViewController.swift
//  TextViewExample
//
//  Created by Jisu Kim on 2023/09/24.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties
    let content = "감사원은 세입·세출의 결산을 매년 검사하여 대통령과 차년도국회에 그 결과를 보고하여야 한다. 국회에 제출된 법률안 기타의 의안은 회기중에 의결되지 못한 이유로 폐기되지 아니한다. 다만, 국회의원의 임기가 만료된 때에는 그러하지 아니하다. \n\nhttps://www.google.com\n\n계엄을 선포한 때에는 대통령은 지체없이 국회에 통고하여야 한다. 제1항의 해임건의는 국회재적의원 3분의 1 이상의 발의에 의하여 국회재적의원 과반수의 찬성이 있어야 한다.\n\n010-1234-5678"
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTextView.textContainer.lineBreakMode = .byWordWrapping
        self.contentLabel.text = self.content
        self.contentTextView.text = self.content
    }

    //MARK: - Methods
    @IBAction func textviewLayoutSetup(_ sender: UISwitch) {
        
        switch sender.isOn {
        case true:
            self.contentTextView.makeLookLikeLabel(content: self.content, font: .systemFont(ofSize: 15, weight: .regular))
            
        case false:
            self.contentTextView.isEditable = true
            self.contentTextView.isScrollEnabled = true
            self.contentTextView.textContainer.lineFragmentPadding = 5.0
        }
    }
}


extension UITextView {
    func makeLookLikeLabel(content: String, font: UIFont) {
        // TextView 설정
        self.isEditable = false
        self.isScrollEnabled = false
        self.dataDetectorTypes = [.link, .phoneNumber]
        self.textContainer.lineFragmentPadding = 0
        self.textContainer.lineBreakMode = .byWordWrapping
        
        // Attribute 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineBreakStrategy = .hangulWordPriority
        let attributeString = NSAttributedString(string: content, attributes: [.paragraphStyle: paragraphStyle, .font: font])
        self.attributedText = attributeString
    }
}
