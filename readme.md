# 不同业务相同界面数据处理的思考

####问题: 很多时候开发中会遇到一个这样的问题, 有几个页面是经过多个界面跳转,然后根据最开始的入口处业务参数的不同,显示不同的内容的场景
举个例子
![流程图.png](https://upload-images.jianshu.io/upload_images/2845360-919f9e57db213264.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
如何实现上面的数据传递呢? 一层一层传递?我觉得不科学,用协议去传递?感觉代码入侵成也很高, 所以我想了以下两个方法, 目前我在项目里已经实现, 给位老板有什么见解 qq: 1096452045 咱们聊聊你的更好的方案

#### 实践方案一: 
你在不确定你赋值的对象是不是还在内存中,需要选择单利去处理, 但是这种场景需要你自己控制你赋值数据的有效性,最后在不用了的时候及时更新成 nil

####### 场景: root-->presentA-->pushB-->pushC-->pushD-->popRoot

```
协议: 你可以继承这个协议去做你觉得合理的业务配置
GlobelMatchingDataProtocol
```
#######  入口处
```
  @objc func push1() {
        let controller = AViewController()
        GlobelMatchingModelManager.share.matchingModel = GlobelMatchingDataDefault(actionType: .pop, name: "Line 1", callback: {
            print("line 1 执行完毕")
        })
        controller.callback = { [weak self] in
            let objc = BViewController()
            self?.navigationController?.pushViewController(objc, animated: true)
        }
        present(controller, animated: true, completion: nil)
    }
```
#######出口处:

```
override func viewDidLoad() {
        super.viewDidLoad()     
        GlobelMatchingModelManager.share.matchingData().startWithResult { [weak self] result in
            self?.setupData(result: result)
        }
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
    
    逻辑跳转
     @objc func push1() {
        if let navi = navigationController {
            navi.popToRootViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
        matchingModel?.callback?()
        GlobelMatchingModelManager.share.matchingModel = nil
    }
```
#### 实践方案二:
你在你的业务场景中非常明确,你赋值的对象一定在内存中,通常都是push行为,控制器都保存在堆栈中,这时候思路就是从后往前找出所有赋值过的对象,默认以找到最后一个赋值对象为准其他赋值无效, 在这种场景下你不需要关心内存问题,对象在控制器销毁时候被销毁

####### 场景: root-->pushB-->pushC-->pushD-->popRoot

```
入口:
  let controller = BViewController()
        controller.matchingModel = GlobelMatchingDataDefault(actionType: .push, name: "Line 2", callback: {
            print("line 2 执行完毕")
        })
        navigationController?.pushViewController(controller, animated: true)
```
出口:
```
 override func viewDidLoad() {
        super.viewDidLoad()
        matchingData().startWithResult { [weak self] result in
            self?.setupData(result: result)
        }
}

跳转逻辑
 @objc func push2() {
        let controller = BViewController()
        matchingModel?.callback?()
        navigationController?.pushViewController(controller, animated: true)
    }
```


