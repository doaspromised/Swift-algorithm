//
//  main.swift
//  Array
//
//  Created by JIANG SHOUDONG on 2020/3/2.
//  Copyright © 2020 姜守栋. All rights reserved.
//

import Foundation

var arr = ExpandArray<Int>(repeating: 0, count: 10)

for element in 0...6 {
    arr.add(element)
}

arr.add(at: 6, newElement: 100)
arr.add(at: 0, newElement: 200)
arr.add(at: 0, newElement: 300)
arr.add(400)
print(arr)





