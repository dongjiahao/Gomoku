//
//  ViewController.swift
//  五子棋
//
//  Created by 董嘉豪 on 2017/2/12.
//  Copyright © 2017年 董嘉豪. All rights reserved.
//

import UIKit

var example: MyImageView? = MyImageView()
var matrix = Matrix<MyImageView>(rows: 15, columns: 15, example: example!)
var list: List = List()

class ViewController: UIViewController {
    
    var num: Int = 0  //记录走棋步数
    
    func initUIImageView() {
        for rows in 0...14 {
            for columns in 0...14 {
                let v = MyImageView()
                v.frame = CGRect(x: (24.2 * Double(columns)).dx, y: (Double(24 * rows)).dy, width: 24.2, height: 24)
                matrix[rows, columns] = v
                self.view.addSubview(v)
            }
        }
        example = nil
    }
    
    func initButton() {
        for rows in 0...14 {
            for columns in 0...14 {
                let b = MyButton(type: .system)
                b.frame = CGRect(x: (24.2 * Double(columns)).dx, y: (Double(24 * rows)).dy, width: 24.2 * 0.9, height: 24 * 0.9)
                b.row = rows
                b.column = columns
                b.addTarget(self, action: #selector(ViewController.didTouch(_ :)), for: .touchUpInside)
                self.view.addSubview(b)
            }
        }
        
        let replay = UIButton(type: .system)
        replay.frame = CGRect(x: 10, y: 531, width: 100, height: 40)
        replay.setTitle("重新开始", for: UIControlState.normal)
        replay.addTarget(self, action: #selector(ViewController.replay), for: .touchUpInside)
        self.view.addSubview(replay)
        
        let back = UIButton(type: .system)
        back.frame = CGRect(x: 10, y: 581, width: 100, height: 40)
        back.setTitle("悔棋", for: UIControlState.normal)
        back.addTarget(self, action: #selector(ViewController.back), for: .touchUpInside)
        self.view.addSubview(back)
    }
    
    func didTouch(_ button: MyButton) {
        guard Person.ending else {    //判断是否已经结束
            if matrix[button.row, button.column].flag == nil {   //防止已下的棋子更改颜色
                if Person.blackOrWhite {   //判断是哪方下的棋
                    matrix[button.row, button.column].flag = true
                    referee(button)
                    Person.blackOrWhite = false
                } else {
                    matrix[button.row, button.column].flag = false
                    referee(button)
                    Person.blackOrWhite = true
                }
                var array = [Any]()
                for i in 0...14 {    //记录棋局状态
                    for j in 0...14 {
                        if matrix[i, j].flag != nil {
                            array.append(matrix[i, j].flag!)
                        } else {    //用0来代替nil
                            array.append(0)
                        }
                    }
                }
                list.appendToHead(val: array)
                num += 1
            }
            return
        }
    }
    
    func referee(_ button: MyButton) {    //裁判
        var parallel: Int = 0
        var vertical: Int = 0
        var leftOblique: Int = 0
        var rightOblique: Int = 0
        if button.parallelLeft == true && button.parallelRight == true {
            for i in -4...4 {   //横向
                if matrix[button.row, (button.column) + i].flag == matrix[button.row, button.column].flag {
                    parallel += 1
                } else {
                    break
                }
            }
        } else if button.parallelLeft == false && button.parallelRight == true {
            for i in -button.column...4 {
                if matrix[button.row, (button.column) + i].flag == matrix[button.row, button.column].flag {
                    parallel += 1
                } else {
                    break
                }
            }
        } else if button.parallelLeft == true && button.parallelRight == false {
            for i in -4...(14 - button.column) {
                if matrix[button.row, (button.column) + i].flag == matrix[button.row, button.column].flag {
                    parallel += 1
                } else {
                    break
                }
            }
        }
        
        if button.verticalUp == true && button.verticalDown == true {
            for i in -4...4 {   //纵向
                if matrix[(button.row) + i, button.column].flag == matrix[button.row, button.column].flag {
                    vertical += 1
                } else {
                    break
                }
            }
        } else if button.verticalUp == false && button.verticalDown == true {
            for i in -button.row...4 {
                if matrix[(button.row) + i, button.column].flag == matrix[button.row, button.column].flag {
                    vertical += 1
                } else {
                    break
                }
            }
        } else if button.verticalUp == true && button.verticalDown == false {
            for i in -4...(14 - button.row) {
                if matrix[(button.row) + i, button.column].flag == matrix[button.row, button.column].flag {
                    vertical += 1
                } else {
                    break
                }
            }
        }
        
        if button.leftObliqueUp == true && button.leftObliqueDown == true {
            for i in -4...4 {   //左斜
                if matrix[(button.row) + i, (button.column) + i].flag == matrix[button.row, button.column].flag {
                    leftOblique += 1
                } else {
                    break
                }
            }
        } else if button.leftObliqueUp == false && button.leftObliqueDown == true {
            if button.row <= button.column {
                for i in -button.row...4 {
                    if matrix[(button.row) + i, (button.column) + i].flag == matrix[button.row, button.column].flag {
                        leftOblique += 1
                    } else {
                        break
                    }
                }
            } else {
                for i in -button.column...4 {
                    if matrix[(button.row) + i, (button.column) + i].flag == matrix[button.row, button.column].flag {
                        leftOblique += 1
                    } else {
                        break
                    }
                }
            }
        } else if button.leftObliqueUp == true && button.leftObliqueDown == false {
            if (14 - button.row) < (14 - button.column) {
                for i in -4...(14 - button.row) {
                    if matrix[(button.row) + i, (button.column) + i].flag == matrix[button.row, button.column].flag {
                        leftOblique += 1
                    } else {
                        break
                    }
                }
            } else {
                for i in -4...(14 - button.column) {
                    if matrix[(button.row) + i, (button.column) + i].flag == matrix[button.row, button.column].flag {
                        leftOblique += 1
                    } else {
                        break
                    }
                }
            }
        }
        
        if button.rightObliqueUp == true && button.rightObliqueDown == true {
            for i in -4...4 {   //右斜
                if matrix[(button.row) + i, (button.column) - i].flag == matrix[button.row, button.column].flag {
                    rightOblique += 1
                } else {
                    break
                }
            }
        } else if button.rightObliqueUp == false && button.rightObliqueDown == true {
            if button.row < (14 - button.column) {
                for i in -button.row...4 {
                    if matrix[(button.row) + i, (button.column) - i].flag == matrix[button.row, button.column].flag {
                        rightOblique += 1
                    } else {
                        break
                    }
                }
            } else {
                for i in -(14 - button.column)...4 {
                    if matrix[(button.row) + i, (button.column) - i].flag == matrix[button.row, button.column].flag {
                        rightOblique += 1
                    } else {
                        break
                    }
                }
            }
        } else if button.rightObliqueUp == true && button.rightObliqueDown == false {
            if button.column < (14 - button.row) {
                for i in -4...button.column {
                    if matrix[(button.row) + i, (button.column) - i].flag == matrix[button.row, button.column].flag {
                        rightOblique += 1
                    } else {
                        break
                    }
                }
            } else {
                for i in -4...(14 - button.row) {
                    if matrix[(button.row) + i, (button.column) - i].flag == matrix[button.row, button.column].flag {
                        rightOblique += 1
                    } else {
                        break
                    }
                }
            }
        }
        
        if parallel >= 5 || vertical >= 5 || leftOblique >= 5 || rightOblique >= 5 {    //判断是否存在连成五子
            if Person.blackOrWhite {
                l.text = "白方胜"
                Person.ending = true
            } else {
                l.text = "黑方胜"
                Person.ending = true
            }
        }
        
    }
    
    let l = UILabel()
    func initUILabel() {
        l.frame = CGRect(x: 10, y: 50, width: 100, height: 40)
        self.view.addSubview(l)
    }
    
    func replay() {
        l.text = ""
        for i in 0...14 {
            for j in 0...14 {
                matrix[i, j].flag = nil
                matrix[i, j].image = nil
            }
        }
        Person.blackOrWhite = false
        Person.ending = false
        list = List()
        num = 0
    }
    
    func back() {
        if num > 1 && Person.ending == false {
            for i in 0...14 {    //重载上一步棋的棋局
                for j in 0...14 {
                    if (list.head?.next?.val[(i * 15) + j])! is Bool {
                        matrix[i, j].flag! = (list.head?.next?.val[(i * 15) + j])! as! Bool
                    } else {
                        matrix[i, j].flag = nil
                    }
                }
            }
            if Person.blackOrWhite {   //改变下棋者
                Person.blackOrWhite = false
            } else {
                Person.blackOrWhite = true
            }
            list.head = list.head?.next
            num -= 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIImageView()
        initButton()
        initUILabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

