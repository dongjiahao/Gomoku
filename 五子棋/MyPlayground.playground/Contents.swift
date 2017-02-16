//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Matrix<Element> {
    let rows: Int, columns: Int
    var grid: [Element]?
    var a: Element
    init(rows: Int, columns: Int, a: Element) {
        self.rows = rows
        self.columns = columns
        self.a = a
        grid = Array<Element>(repeating: a, count: rows * columns)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Element {
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid![(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid?[(row * columns) + column] = newValue
        } }
}
var b = Matrix<Int>(rows: 2, columns: 2, a: 0)
b[0, 0] = 1
b[0, 0]

//var cax: Array<Any> = [1, "a", nil, 2]
