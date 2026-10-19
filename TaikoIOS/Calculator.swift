import Foundation

struct Calculator {
    private(set) var display = "0"
    private var stored: Double?
    private var operation: String?
    private var lastOperation: String?
    private var lastOperand: Double?
    private var startsNewNumber = true

    mutating func press(_ key: String) {
        switch key {
        case "AC": self = Calculator()
        case "±", "%":
            guard let value = Double(display) else { return }
            show(key == "±" ? -value : value / 100)
            startsNewNumber = false
            lastOperation = nil
            lastOperand = nil
        case "+", "−", "×", "÷":
            guard let value = Double(display) else { return }
            if let lhs = stored, let op = operation, !startsNewNumber {
                guard calculate(lhs, op, value) else { return }
            }
            stored = Double(display)
            operation = key
            lastOperation = nil
            lastOperand = nil
            startsNewNumber = true
        case "=":
            guard let value = Double(display) else { return }
            if let lhs = stored, let op = operation {
                guard calculate(lhs, op, value) else { return }
                lastOperation = op
                lastOperand = value
            } else if let op = lastOperation, let rhs = lastOperand {
                guard calculate(value, op, rhs) else { return }
            }
            stored = nil
            operation = nil
            startsNewNumber = true
        case ".", "0"..."9":
            guard key == "." || (key.count == 1 && key.first?.isNumber == true) else { return }
            if startsNewNumber {
                display = "0"
                startsNewNumber = false
            }
            lastOperation = nil
            lastOperand = nil
            if key == "." {
                if !display.contains(".") { display += "." }
            } else if display == "0" {
                display = key
            } else if display.filter({ $0.isNumber }).count < 12 {
                display += key
            }
        default: break
        }
    }

    @discardableResult
    private mutating func calculate(_ lhs: Double, _ op: String, _ rhs: Double) -> Bool {
        let result: Double
        switch op {
        case "+": result = lhs + rhs
        case "−": result = lhs - rhs
        case "×": result = lhs * rhs
        case "÷": result = rhs == 0 ? .nan : lhs / rhs
        default: return false
        }
        guard result.isFinite else {
            self = Calculator()
            display = "Lỗi"
            return false
        }
        show(result)
        return true
    }

    private mutating func show(_ value: Double) {
        display = value == 0 ? "0" : String(format: "%.12g", locale: Locale(identifier: "en_US_POSIX"), value)
    }
}
