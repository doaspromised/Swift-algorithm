//
//  main.swift
//  Array
//
//  Created by JIANG SHOUDONG on 2020/3/2.
//  Copyright © 2020 姜守栋. All rights reserved.
//

import Foundation

var arr = ExpandArray<Int>(repeating: 0, count: 10)

for element in 0...5 {
    arr.add(element)
}
arr.add(at: 1, newElement: 11)
arr.remove(0)
arr[0] = 13
print(arr)
print(arr.contains(4))





