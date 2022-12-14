//
//  ViewModel.swift
//  Kadai2-MVVM
//
//  Created by 近藤米功 on 2022/09/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

// MARK: - ViewModelInputs
protocol ViewModelInputs {
    var number1TextFieldObservable: Observable<String> { get }
    var number2TextFieldObservable: Observable<String> { get }
    var calculateButtonTapObservable: Observable<Void> { get }
    var calculatorSegmentedControlObservable: Observable<Int> { get }
}

// MARK: - ViewModelOutputs
protocol ViewModelOutputs {
    var calcResult: PublishRelay<String> { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {

    // MARK: - Inputs
    var number1TextFieldObservable: Observable<String>
    var number2TextFieldObservable: Observable<String>
    var calculateButtonTapObservable: Observable<Void>
    var calculatorSegmentedControlObservable: Observable<Int>

    // MARK: - Outputs
    var calcResult = PublishRelay<String>()

    private let disposeBag = DisposeBag()

    // MARK: - Model Connect
    private let calculator = Calculator()

    // MARK: - property
    private var number1 = 0
    private var number2 = 0
    private var calcMethodIndex = 0

    // MARK: - enum
    private enum CalculationMethod: Int {
        case addition
        case subtraction
        case mult
        case div
    }

    init(number1TextFieldObservable: Observable<String>,number2TextFieldObservable: Observable<String>,
         calculateButtonTapObservable: Observable<Void>,
         calculatorSegmentedControlObservable: Observable<Int>){
        self.number1TextFieldObservable = number1TextFieldObservable
        self.number2TextFieldObservable = number2TextFieldObservable
        self.calculateButtonTapObservable = calculateButtonTapObservable
        self.calculatorSegmentedControlObservable = calculatorSegmentedControlObservable
        setupBindings()
    }

    private func setupBindings() {
        let totalInput = Observable.combineLatest(number1TextFieldObservable, number2TextFieldObservable, calculatorSegmentedControlObservable)

        totalInput.subscribe { number1,number2,calculatorSegmentedControl in
            self.number1 = Int(number1) ?? 0
            self.number2 = Int(number2) ?? 0
            self.calcMethodIndex = calculatorSegmentedControl
        }.disposed(by: disposeBag)

        calculateButtonTapObservable.subscribe(onNext: {
            guard let calcMethod = CalculationMethod(rawValue: self.calcMethodIndex) else { return }
            switch calcMethod {
            case .addition:
                self.calculator.addition(number1: self.number1, number2: self.number2)
            case .subtraction:
                self.calculator.subtraction(number1: self.number1, number2: self.number2)
            case .mult:
                self.calculator.muti(number1: self.number1, number2: self.number2)
            case .div:
                self.calculator.divi(number1: self.number1, number2: self.number2)
            }
            self.calcResult.accept(String(self.calculator.calcResultNumber))
        }).disposed(by: disposeBag)

    }

}
