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
        view.backgroundColor = .yellow

        matchingData().startWithResult { [weak self] result in
            self?.setupData(result: result)
        }

        GlobelMatchingModelManager.share.matchingData().startWithResult { [weak self] result in
            self?.setupData(result: result)
        }

        let push1 = UIButton()
        push1.frame = CGRect(x:  50, y: 300, width: 300, height: 100)
        push1.setTitle("Line 1", for: .normal)
        push1.backgroundColor = UIColor.black
        push1.addTarget(self, action: #selector(self.push1), for: .touchUpInside)
        view.addSubview(push1)

        let push2 = UIButton()
        push2.frame = CGRect(x:  50, y: 500, width: 300, height: 100)
        push2.setTitle("Line  2", for: .normal)
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
        matchingModel?.callback?()
        GlobelMatchingModelManager.share.matchingModel = nil
    }

    @objc func push2() {
        let controller = BViewController()
        matchingModel?.callback?()
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setupData(result: Result<GlobelMatchingDataProtocol?, Error>) {
        switch result {
        case let .success(value):
            matchingModel = value
            title = value?.name
        case .failure:
            matchingModel = nil
        }
    }
}
