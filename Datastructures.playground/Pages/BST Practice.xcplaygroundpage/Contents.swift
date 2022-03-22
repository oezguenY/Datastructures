

import Foundation


class Node<T> {
    var value: T
    var left: Node<T>? = nil
    var right: Node<T>? = nil
    
    init(value: T) {
        self.value = value
    }
}

struct BinarySearchTree<T: Comparable> {
    var root: Node<T>? = nil
    
    mutating func insert(value: T) {
        
        var currentNode = root
        let newNode = Node(value: value)
        
        if currentNode == nil {
            root = newNode
            return
        } else {
            while true {
                guard value != currentNode!.value else { break }
                if value < currentNode!.value {
                    if currentNode?.left == nil {
                        currentNode?.left = newNode
                        break
                    } else {
                        currentNode = currentNode?.left
                    }
                } else if value > currentNode!.value {
                    if currentNode?.right == nil {
                        currentNode?.right = newNode
                        break
                    } else {
                        currentNode = currentNode?.right
                    }
                }
            }
        }
    }
    
    func findNode(_ value: T) -> Bool {
        var currentNode = root
        
        if value == currentNode?.value {
            return true
        } else {
            while true {
                if value < currentNode!.value {
                    currentNode = currentNode?.left
                    if value == currentNode?.value {
                        return true
                    }
                    guard currentNode?.left != nil else {
                        return false
                    }
                        
                } else if value > currentNode!.value {
                    currentNode = currentNode?.right
                    if value == currentNode?.value {
                        return true
                    }
                    guard currentNode?.right != nil else {
                        return false
                    }
                }
            }
        }
    }
}

var bst = BinarySearchTree<Int>()
bst.insert(value: 30)
bst.insert(value: 14)
bst.insert(value: 19)
bst.insert(value: 7)
bst.insert(value: 3)
bst.insert(value: 68)
bst.insert(value: 129)
bst.findNode(129)
bst.findNode(7)
bst.findNode(14)
bst.findNode(15)
bst.findNode(939)
bst.findNode(111)
bst.findNode(93939939)
