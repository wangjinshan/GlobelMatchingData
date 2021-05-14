//
//  FirstController.swift
//  TestApp
//
//  Created by 顾鹏凌MacBook Air(New) on 2021/4/22.
//

import Foundation
import UIKit

protocol AProtocol: AnyObject {
    func getAModel() -> Any?
}

class FirstController: UIViewController, AProtocol {

    deinit {
        print("FirstController控制器销毁了")
    }

    private var xx = ""

    func getAModel() -> Any? {
        return xx
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let push2 = UIButton()
        push2.frame = CGRect(x:  50, y: 500, width: 300, height: 100)
        push2.setTitle("push1", for: .normal)
        push2.backgroundColor = .black
        push2.addTarget(self, action: #selector(self.push2), for: .touchUpInside)
        view.addSubview(push2)
    }


    @objc func push2() {
        let controller = SecondController()

        navigationController?.pushViewController(controller, animated: true)
    }
}
