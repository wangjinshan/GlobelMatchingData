//
//  CViewController.swift
//  GlobelMatchingData
//
//  Created by shan on 2021/5/10.
//

import UIKit

class CViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "C"

        let push2 = UIButton()
        push2.frame = CGRect(x:  50, y: 500, width: 300, height: 100)
        push2.setTitle("PushD", for: .normal)
        push2.backgroundColor = .black
        push2.addTarget(self, action: #selector(self.push2), for: .touchUpInside)
        view.addSubview(push2)
    }

    @objc func push2() {
        let controller = DViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
