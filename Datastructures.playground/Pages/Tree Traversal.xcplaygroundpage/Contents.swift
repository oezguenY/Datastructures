
import Foundation


class Node<T> {
    var value: T
    var left: Node<T>?
    var right: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct BinarySearchTree<T: Comparable> {
    var root: Node<T>? = nil
    
    
    func bfs() -> [Node<T>?] {
        var node = self.root
        var data = [Node<T>?]()
        var queue = [Node<T>?]()
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
