//
//  Person.swift
//  Array
//
//  Created by JIANG SHOUDONG on 2020/3/2.
//  Copyright © 2020 姜守栋. All rights reserved.
//

import Foundation

class Person: Equatable, CustomDebugStringConvertible {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.age == rhs.age
    }
    
    var debugDescription: String {
        return "{age = \(age)}"
    }
    
    
    var age = 0
    init() {
        
    }
    convenience init(age: Int) {
        self.init()
        self.age = age
    }
    
}
