//
//  AViewController.swift
//  GlobelMatchingData
//
//  Created by shan on 2021/5/10.
//

import UIKit

class AViewController: UIViewController {

    deinit {
        print("A销毁了")
    }

    public var callback: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "A"

        let push2 = UIButton()
        push2.frame = CGRect(x:  50, y: 500, width: 300, height: 100)
        push2.setTitle("dismiss them push", for: .normal)
        push2.backgroundColor = .black
        push2.addTarget(self, action: #selector(self.push2), for: .touchUpInside)
        view.addSubview(push2)
    }

    @objc func push2() {
        dismiss(animated: true) { [weak self] in
            self?.callback?()
        }
    }
}
