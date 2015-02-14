//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Shelley on 2/13/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
private enum Op {
    case Operand(Double)
    case UnaryOperation(String, Double -> Double)
    case BinaryOperation(String, (Double, Double) -> Double)
}

private var opStack = [Op]()

private var knownOps = [String:Op]()

init() {
    
    knownOps["×"] = Op.BinaryOperation("×", *)
    knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
    knownOps["+"] = Op.BinaryOperation("+", +)
    knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
    knownOps["√"] = Op.UnaryOperation ("√", sqrt)
    
    }
    
    private func evaluate( opsIn: [Op]) -> (result: Double?, remainingOps: [Op]) {
        
        if !opsIn.isEmpty {
            
            var remainingOps = opsIn
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation (_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        
        
        }
        
        
        return (nil, opsIn)
    }
    
    func evaluate() -> Double? {
        let (results, remainder) = evaluate(opStack)
        return results
        
    }
    
    func pushOperand(operandIn: Double){
        opStack.append(Op.Operand(operandIn))
    }
    
    func performOperation(symbolIn: String){
        if let operation = knownOps[symbolIn]{
            opStack.append(operation)
        }
    }
    
    
    
    
    
    
}