//
//  DViewController.swift
//  GlobelMatchingData
//
//  Created by shan on 2021/5/10.
//

import UIKit

class DViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        matchingData().startWithResult { [weak self] result in
            switch result {
            case let .success(value):
                self?.matchingModel = value
            case .failure:
                self?.matchingModel = nil
            }
        }
        title = matchingModel?.name

        let push1 = UIButton()
        push1.frame = CGRect(x:  50, y: 300, width: 300, height: 100)
        push1.setTitle("presentA", for: .normal)
        push1.backgroundColor = UIColor.black
        push1.addTarget(self, action: #selector(self.push1), for: .touchUpInside)
        view.addSubview(push1)

        let push2 = UIButton()
        push2.frame = CGRect(x:  50, y: 500, width: 300, height: 100)
        push2.setTitle("PushB", for: .normal)
        push2.backgroundColor = .black
        push2.addTarget(self, action: #selector(self.push2), for: .touchUpInside)
        view.addSubview(push2)
    }

    @objc func push1() {
        if let navi = navigationController {
            navi.popToRootViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc func push2() {
        let controller = BViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
