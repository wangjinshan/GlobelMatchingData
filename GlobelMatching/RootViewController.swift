//
//  RootViewController.swift
//  GlobelMatchingData
//
//  Created by shan on 2021/5/12.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        let controller = AViewController()
        controller.matchingModel = GlobelMatchingDataDefault(actionType: .pop, name: "Line 1", callback: {
            print("line 1 执行完毕")
        })
        controller.callback = { [weak self] in
            let objc = BViewController()
            self?.navigationController?.pushViewController(objc, animated: true)
        }
        present(controller, animated: true, completion: nil)
    }

    @objc func push2() {
        let controller = BViewController()
        controller.matchingModel = GlobelMatchingDataDefault(actionType: .push, name: "Line 2", callback: {
            print("line 2 执行完毕")
        })
        navigationController?.pushViewController(controller, animated: true)
    }
}
