
import Foundation

class Node<T> {
    var value: T
    var left: Node<T>? = nil
    var right: Node<T>? = nil
    
    init(value: T) {
        self.value = value
    }
}

struct BinarySearchTree<T: Comparable & CustomStringConvertible> {
    var root: Node<T>? = nil
    
    // MARK: INSERT
 
    mutating func insert(value: T) {
        let newNode = Node(value: value)
        if root == nil {
            root = newNode
            return
        } else {
            var current = root
            while true {
                guard value != current!.value else { return }
                if (value < current!.value) {
                    if (current?.left == nil) {
                        current?.left = newNode
                        return
                    } else {
                        current = current?.left
                    }
                } else if (value > current!.value) {
                    if current?.right == nil {
                        current?.right = newNode
                        return
                    } else {
                        current = current?.right
                    }
                }
            }
        }
    }
    
    // MARK: - FIND
    
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
    
    // MARK: - BIG O OF BST
    
    // INSERTION: O(log n)
    // SEARCHING: O(log n)
}

var tree = BinarySearchTree<Int>()
tree.root = Node(value: 10)
tree.insert(value: 5)
tree.insert(value: 19)
tree.insert(value: 12)
tree.insert(value: 3)
tree.insert(value: 9)
tree.root?.right?.left
tree.root?.left?.right
tree.root?.left?.left
