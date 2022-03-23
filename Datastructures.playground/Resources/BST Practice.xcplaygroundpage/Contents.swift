

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
    
    func bfs() -> [Node<T>?] {
        var node = root
        var queue = [Node<T>?]()
        var data = [Node<T>?]()
        queue.append(node)
        
        while !queue.isEmpty {
            node = queue.removeFirst()
            data.append(node)
            
            if let leftNode = node?.left {
                queue.append(leftNode)
            }
            if let rightNode = node?.right {
                queue.append(rightNode)
            }
        }
        
        let nodeValues = data.compactMap { $0?.value }
        print(nodeValues)
        return data
    }
}



var bst = BinarySearchTree<Int>()
bst.insert(value: 10)
bst.insert(value: 6)
bst.insert(value: 8)
bst.insert(value: 3)
bst.insert(value: 15)
bst.insert(value: 20)
bst.bfs()
