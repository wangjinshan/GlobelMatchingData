//
//  GlobelMatchingData.swift
//  RACSwiftDemo
//
//  Created by shan on 2021/4/25.
//  Copyright © 2021 山神. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

// MARK: - 数据协议
public enum GlobelMatchingDataEnum {
    case push
    case pop
}

public protocol GlobelMatchingDataProtocol {
    var name: String? { get set }
    var actionType: GlobelMatchingDataEnum {get set}
    var callback: (() -> Void)? { get set }
}

public class GlobelMatchingDataDefault: GlobelMatchingDataProtocol {
    public var name: String?
    public var actionType: GlobelMatchingDataEnum = .pop
    public var callback: (() -> Void)?
    init(actionType: GlobelMatchingDataEnum = .pop, name: String? = "GlobelMatchingDataDefault", callback: (() -> Void)? = nil) {
        self.actionType = actionType
        self.name = name
        self.callback = callback
    }
}
// MARK: - 堆栈中可能销毁了对象
public class GlobelMatchingModelManager {

   static let share = GlobelMatchingModelManager()

   public var matchingModel: GlobelMatchingDataProtocol? // 需要自己去管理内存,在确定需要销毁的地方销毁

   public func matchingData() -> SignalProducer<GlobelMatchingDataProtocol?, Error> {
        return SignalProducer { [weak self] (observer, lifeTime) in
            observer.send(value: self?.matchingModel)
            observer.sendCompleted()
            lifeTime.observeEnded {
                #if DEBUG
                print("在单利中设置的数据被清理数据了, 数据将无效")
                #endif
                self?.matchingModel = nil
            }
        }
    }
}

// MARK: - 确定堆栈中没有销毁对象, 只支持顶层window
public extension UIViewController {

    private static var matchingModelKey = "matchingModelKey"

    var matchingModel: GlobelMatchingDataProtocol? {
        get {
            return objc_getAssociatedObject(self, &UIViewController.matchingModelKey) as? GlobelMatchingDataProtocol
        }
        set(uniqueId) {
            objc_setAssociatedObject(self, &UIViewController.matchingModelKey, uniqueId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func matchingData() -> SignalProducer<GlobelMatchingDataProtocol?, Error> {
        return SignalProducer { [weak self] (observer, lifeTime) in
            let first = self?.getAllController().first(where: { (controller) -> Bool in
                return controller.matchingModel != nil
            })
            let model = first?.matchingModel
            observer.send(value: model) // 在这个位置找到堆栈中赋值过matchingModel,空值也需要触发
            observer.sendCompleted()
            lifeTime.observeEnded {
                first?.matchingModel = nil
                #if DEBUG
                print("在\(String(describing: first))设置的数据被清理数据了, 数据将无效")
                #endif
            }
        }
    }

    func getAllController() -> [UIViewController] {
        var controllers: [UIViewController] = []
        var objc: Any?
        if let navigation = navigationController {
            controllers.append(contentsOf: navigation.viewControllers)
            objc = navigation.presentingViewController
        } else {
            controllers.append(self)
            objc = presentingViewController
        }
        while objc != nil {
            if let navi = objc as? UINavigationController {
                controllers.append(contentsOf: navi.viewControllers)
                objc = navi.presentingViewController
            } else {
                if let controller = objc as? UIViewController {
                    controllers.append(controller)
                    objc = controller.presentingViewController
                } else {
                    objc = nil
                }
            }
        }
        return controllers
    }
}
