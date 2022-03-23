

import Foundation


import UIKit


class Node<T> {
    var value: T
    var left: Node<T>?
    var right: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct BinarySearchTree<T: Comparable> {
    var root: Node<T>?
    
     /*
      We are building the following tree: (look into insert calls)
      
                           Tree
                            10
                   6                  15
             3          8                     20
      
      With dfsPreOrder, we are first traversing through the left side of the tree. this means 10 - 6 - 3.
      Then, we work our way up from the bottom: we add 8 so -> 10 - 6 - 3 - 8 we complete the left side. After this is done, we traverse the right side -> 15 - 20. Both 15 and 20 do not have left nodes so our end result of dfsPreOrder should be -> 10 - 6 - 3 - 8 - 15 - 20
      
      */

    
    func dfsPreOrder() -> [Node<T>?] {
        let root = self.root
        var data = [Node<T>?]()
        
        func traverse(node: Node<T>?) {
            data.append(node)
            if let leftNode = node?.left {
                traverse(node: leftNode)
            }
            if let rightNode = node?.right {
                traverse(node: rightNode)
            }
        }
        traverse(node: root)
        let nodeValues = data.compactMap({$0?.value})
        print(nodeValues)
        return data
    }
    
    func bfs() -> [Node<T>?] {
        var node = self.root // 10
        var data = [Node<T>?]()
        var queue = [Node<T>?]()
        queue.append(node) // [10]
        
        while !queue.isEmpty {
            // FIFO Approach; The first element in the array is removed
            node = queue.removeFirst() // 10, 6, 15, 3, 8
            data.append(node) // [10], [10,6], [10,6,15], [10,6,15,3] ,[10,6,15,3,8], [10,6,15,3,8,20]
            if let leftNode = node?.left {
                queue.append(leftNode) // [6], [15,3]
            }
            if let rightNode = node?.right {
                queue.append(rightNode) // [6,15], [15,3,8], [3,8,20]
            }
        }
        // check whether the sequence of the array is correct
        let nodeValues = data.compactMap { $0?.value }
        print(nodeValues)
        return data
    }
    
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
}

var bst = BinarySearchTree<Int>()
bst.insert(value: 10)
bst.insert(value: 6)
bst.insert(value: 8)
bst.insert(value: 3)
bst.insert(value: 15)
bst.insert(value: 20)
bst.bfs()
bst.dfsPreOrder()

            
