import Foundation

@main
enum CalculatorChecks {
    static func main() {
        let cases: [([String], String)] = [
            (["2", "+", "3", "="], "5"),
            (["8", "−", "9", "="], "-1"),
            (["6", "×", "7", "="], "42"),
            (["9", "÷", "4", "="], "2.25"),
            (["0", ".", "1", "+", "0", ".", "2", "="], "0.3"),
            (["2", "+", "3", "×", "4", "="], "20"),
            (["2", "+", "×", "3", "="], "6"),
            (["2", "+", "3", "=", "="], "8"),
            (["2", "+", "3", "=", "7"], "7"),
            (["5", "0", "%"], "0.5"),
            (["5", "±", "×", "2", "="], "-10"),
            (["1", ".", ".", "5"], "1.5"),
            (["8", "÷", "0", "="], "Lỗi"),
            (["8", "÷", "0", "=", "2", "+", "3", "="], "5"),
            (["9", "+", "AC", "2", "="], "2"),
            (["0", "±"], "0"),
            (["4", "=", "="], "4")
        ]
        for (keys, expected) in cases {
            var calculator = Calculator()
            keys.forEach { calculator.press($0) }
            guard calculator.display == expected else {
                fatalError("\(keys): expected \(expected), got \(calculator.display)")
            }
        }
        print("Passed \(cases.count) calculator checks")
    }
}
