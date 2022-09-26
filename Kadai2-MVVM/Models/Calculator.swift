//
//  Calculator.swift
//  Kadai2-MVVM
//
//  Created by 近藤米功 on 2022/09/26.
//

import Foundation

class Calculator {
    var calcResultNumber = Double()

    func addition(number1: Int,number2: Int) {
        calcResultNumber = Double(number1 + number2)
    }

    func subtraction(number1: Int,number2: Int) {
        calcResultNumber = Double(number1 - number2)
    }

    func muti(number1: Int,number2: Int) {
        calcResultNumber = Double(number1 * number2)
    }

    func divi(number1: Int,number2: Int) {
        calcResultNumber = Double(number1 / number2)
    }
}
