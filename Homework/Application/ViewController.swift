//
//  ViewController.swift
//  Homework
//
//  Created by David on 2022/4/6.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    var bag = DisposeBag()
    var a = OpenSeaUseCase()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        a.fetchAssets(of: "0x19818f44faf5a217f619aff0fd487cb2a55cca65", offset: 0)
            .subscribe { assets in
                print(assets)
            }
            .disposed(by: bag)
    }
}
