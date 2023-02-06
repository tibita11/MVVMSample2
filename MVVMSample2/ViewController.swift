//
//  ViewController.swift
//  MVVMSample2
//
//  Created by 鈴木楓香 on 2023/02/06.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    private let maxNameFieldSize = 10
    private let maxAddressFieldSize = 50
    let limitText: (Int) -> String = {
        return "あと\($0)文字"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.rx.text
        .map { [weak self] text -> String? in
            guard let text = text else { return nil }
            let count = self!.maxNameFieldSize - text.count
            return self!.limitText(count)
        }
        .filterNil()
        .bind(to: nameLabel.rx.text)
        .disposed(by: disposeBag)
        
        addressField.rx.text
        .map { [weak self] text -> String? in
            guard let text = text else { return nil }
            let count = self!.maxAddressFieldSize - text.count
            return self!.limitText(count)
        }
        .filterNil()
        .bind(to: addressLabel.rx.text)
        .disposed(by: disposeBag)
    }


}

