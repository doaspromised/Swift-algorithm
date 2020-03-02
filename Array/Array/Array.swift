//
//  Array.swift
//  Array
//
//  Created by JIANG SHOUDONG on 2020/3/2.
//  Copyright © 2020 姜守栋. All rights reserved.
//

import Foundation

@discardableResult
prefix func ++(value: inout Int) -> Int {
    value += 1
    return value
}

@discardableResult
postfix func ++(value: inout Int) -> Int {
    let oldValue = value
    value += 1
    return oldValue
}

@discardableResult
prefix func --(value: inout Int) -> Int {
    value -= 1
    return value
}

@discardableResult
postfix func --(value: inout Int) -> Int {
    let oldValue = value
    value -= 1
    return oldValue
}


public struct ExpandArray<T: Equatable>: CustomDebugStringConvertible {

    private var size: Int
    private var elements: [T]
    private var defaultValue: T
    private let DEFAULT_CAPACITY = 10
    private let ELEMENT_NOT_FOUND = -1
    
    public var debugDescription: String {
        var desc = "size = \(size), elements = ["
        
        for index in 0..<size {
            if index == size - 1 {
                desc += "\(elements[index])"
            } else {
                desc += "\(elements[index]), "
            }
            
        }
        desc += "]"
        
        return desc
    }
}

// MARK: - public
extension ExpandArray {
    
    /// 初始化一个数组
    /// - Parameter repeatedValue: 数组元素的默认值
    init(repeating repeatedValue: T) {
        defaultValue = repeatedValue
        elements = [T](repeating: repeatedValue, count: DEFAULT_CAPACITY)
        size = 0
    }
    /// 初始化一个数组
    /// - Parameters:
    ///   - repeatedValue: 数组元素的默认值
    ///   - count: 数组的初始化容量
    init(repeating repeatedValue: T, count: Int) {
        let capacity = count > DEFAULT_CAPACITY ? count : DEFAULT_CAPACITY
        defaultValue = repeatedValue
        elements = [T](repeating: repeatedValue, count: capacity)
        size = 0
    }
    /// 清除所有元素
    mutating func clear() {
        size = 0
    }
    /// 数组长度
    var count: Int {
        get {
            size
        }
    }
    /// 是否为空
    var isEmpty: Bool {
        get {
            size == 0
        }
    }
    /// 是否包含元素
    /// - Parameter element: 元素值
    func contains(_ element: T) -> Bool {
        return indexOf(element) != ELEMENT_NOT_FOUND
    }
    
    @discardableResult
    mutating func set(at index: Int, newElement: T) -> T {
        let oldElement = elements[index]
        elements[index] = newElement
        return oldElement
    }
    
    func getElement(at index: Int) -> T {
//        try! checkIndex(index)
        return elements[index]
    }
    
    subscript(index: Int) -> T {
        set {
            elements[index] = newValue
        }
        get {
            elements[index]
        }
    }
    
    /// 添加元素
    /// - Parameter newElement
    mutating func add(_ newElement: T) {
        add(at: size, newElement: newElement)
    }
    
    /// 指定位置添加元素
    /// - Parameters:
    ///   - index: 位置
    ///   - newElement: 元素
    mutating func add(at index: Int, newElement: T) {
//        try? checkIndex(index)
        ensureCapacity(capacity: size + 1)
        if index == size {
            elements[size++] = newElement
        } else {
            for idx in (index..<size).reversed() {
                elements[idx+1] = elements[idx]
            }
            elements[index] = newElement
            size++
        }
    }
    
    @discardableResult
    mutating func remove(_ element: T) -> T {
        remove(at: indexOf(element))
    }
    
    @discardableResult
    mutating func remove(at index: Int) -> T {
        if index == size - 1 {
            return elements[--size]
        }
        let oldElement = elements[index]
        for idx in index+1..<size {
            elements[idx-1] = elements[idx]
        }
        size--
        return oldElement
    }
}

// MARK: - Private Helpers
extension ExpandArray {
    enum ArrayError: Error {
        case msg(String)
    }
    
    private func checkIndex(_ index: Int) throws {
        if !(0...size).contains(index)  {
            throw ArrayError.msg("数组越界, Index = \(index)")
        }
    }
    
    /// 动态扩容
    /// - Parameter capacity:
    private mutating func ensureCapacity(capacity: Int) {
        let oldCapacity = elements.count
        if capacity > oldCapacity {
            let oldElements = elements
            let newCapacity = oldCapacity + (oldCapacity >> 1)
            elements = [T](repeating: defaultValue, count: newCapacity)
            for (idx, item) in oldElements.enumerated() {
                elements[idx] = item
            }
        }
        
    }
    
    /// 查找元素在数组中的索引
    /// - Parameter element: 元素
    private func indexOf(_ element: T) -> Int {
        for idx in 0..<size where element == elements[idx] {
            return idx
        }
        return ELEMENT_NOT_FOUND
    }
}
