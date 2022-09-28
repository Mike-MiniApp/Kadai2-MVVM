//
//  ViewController.swift
//  Kadai2-MVVM
//
//  Created by 近藤米功 on 2022/09/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    // MARK: - UI Patrs
    @IBOutlet private weak var number1TextField: UITextField!
    @IBOutlet private weak var number2TextField: UITextField!
    @IBOutlet private weak var calculatorSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var calculateButton: UIButton!
    @IBOutlet private weak var calcResultLabel: UILabel!

    private lazy var viewModel = ViewModel(number1TextFieldObservable: number1TextField.rx.text.map { $0 ?? ""}.asObservable(),
                                           number2TextFieldObservable: number2TextField.rx.text.map{ $0 ?? ""}.asObservable(),
                                           calculateButtonTapObservable: calculateButton.rx.tap.asObservable(),
                                           calculatorSegmentedControlObservable: calculatorSegmentedControl.rx.value.asObservable())

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        viewModel.calcResult.bind(to: calcResultLabel.rx.text).disposed(by: disposeBag)
    }
}

