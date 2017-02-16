//
//  File.swift
//  五子棋
//
//  Created by 董嘉豪 on 2017/2/14.
//  Copyright © 2017年 董嘉豪. All rights reserved.
//

import UIKit

extension Double {
    //将中心坐标转换成左上顶点坐标 以棋盘第一个格为坐标原点
    var dx: Double { return self - 12.1 + 18 }
    var dy: Double { return self - 12 + 19 + 146 }
}

class Person {
    //判断该谁走棋的标志 黑方为false 白方为true
    static var blackOrWhite: Bool = false
    static var ending: Bool = false
}

class MyImageView: UIImageView {
    //可以记录自己颜色的UIImageView
    var flag: Bool?
        {
        didSet
            {
                if self.flag != nil {
                    if self.flag! {
                        self.image = UIImage(named: "白")
                    } else if self.flag == false {
                        self.image = UIImage(named: "黑")
                    }
                } else {
                    self.image = nil
                }
        }
    }
    
}

class MyButton: UIButton {
    //可以记录自己坐标的UIButton
    var row: Int = 0
    var column: Int = 0
    var verticalUp: Bool {
        if row >= 4 {
            return true
        }
        return false
    }
    var verticalDown: Bool {
        if row <= 10 {
            return true
        }
        return false
    }
    var parallelRight: Bool {
        if column <= 10 {
            return true
        }
        return false
    }
    var parallelLeft: Bool {
        if column >= 4 {
            return true
        }
        return false
    }
    var leftObliqueUp: Bool {
        if row >= 4 && column >= 4 {
            return true
        }
        return false
    }
    var leftObliqueDown: Bool {
        if row <= 10 && column <= 10 {
            return true
        }
        return false
    }
    var rightObliqueUp: Bool {
        if row >= 4 && column <= 10 {
            return true
        }
        return false
    }
    var rightObliqueDown: Bool {
        if row <= 10 && column >= 4 {
            return true
        }
        return false
    }
}

struct Matrix<Element> {
    //任意元素类型二维矩阵
    let rows: Int, columns: Int
    var grid: [Element]
    var example: Element
    init(rows: Int, columns: Int, example: Element) {
        self.rows = rows
        self.columns = columns
        self.example = example
        grid = Array<Element>(repeating: example, count: rows * columns)
    }
    func indexIsValidForRow(_ row: Int, _ column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Element {
        get {
            assert(indexIsValidForRow(row, column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

class ListNode {
    //定义节点
    var val: Array<Any>
    var next: ListNode?
    init(_ val: Array<Any>) {
        self.val = val
        self.next = nil
    }
}

class List {
    //定义链表
    var head: ListNode?
    var tail: ListNode?
    // 尾插法
    func appendToTail(val: Array<Any>) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    // 头插法
    func appendToHead(val: Array<Any>) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
}



































/*
 */
