//
//  ViewController.swift
//  FunctionUseCase
//
//  Created by 김지수 on 2023/09/22.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - Methods

    @IBAction func ButtonDidTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = FirstViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = SecondViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = ThirdViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            return
        }
    }
}

