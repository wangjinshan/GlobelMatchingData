//
//  BViewController.swift
//  GlobelMatchingData
//
//  Created by shan on 2021/5/11.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "B"

        let push2 = UIButton()
        push2.frame = CGRect(x:  50, y: 500, width: 300, height: 100)
        push2.setTitle("PushC", for: .normal)
        push2.backgroundColor = .black
        push2.addTarget(self, action: #selector(self.push2), for: .touchUpInside)
        view.addSubview(push2)
    }

    @objc func push2() {
        let controller = CViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
