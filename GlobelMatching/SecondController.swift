//
//  SecondController.swift
//  TestApp
//
//  Created by 顾鹏凌MacBook Air(New) on 2021/4/22.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

let notificationName = Notification.Name(rawValue: "DownloadImageNotification")
let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height
let conditionViewWidth = screenWidth - 70

class SecondController: UIViewController {

    deinit {
        print("SecondController控制器销毁了")
    }

    @objc func jump() {
        if let x = getAController() as? AProtocol,
           let _ = x.getAModel() {

        }
    }

    private func getAController() -> UIViewController? {
        if let vcs = navigationController?.viewControllers {
            for (_, vc) in vcs.enumerated() {
                if ((vc as? AProtocol) != nil) {
                    return vc
                }
            }
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        let push2 = UIButton()
        push2.frame = CGRect(x:  50, y: 500, width: 300, height: 100)
        push2.setTitle("push2", for: .normal)
        push2.backgroundColor = .black
        push2.addTarget(self, action: #selector(self.push2), for: .touchUpInside)
        view.addSubview(push2)
    }

    @objc func push2() {
        let controller = SecondController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
