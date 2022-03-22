
import Foundation


class Node<T> {
    
    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool { head == nil }
    
    mutating func push(_ value: T) {
        // suppose your list is empty. You feed next with head, which is nil at this point
        // (your list is empty, meaning head has no value). So head will have a value you feed
        // it with, but its next property will be nil
        // suppose you pushed(1) and now you want to push(2). The next property will be 1 (your old head), and the new head will have a value of 2.
        // this means, your head now is 2 and its next property is 1 so 2 -> 1
        // our tail stays unchanged. It's still 1, which is correct. Even if we pushed 100 more
        // nodes, our tail will always be 1 (unless we use other functions like append, but then
        // will have to deal with this change in those functions)
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
        self.print
    }
    
    mutating func append(_ value: T) {
        let node = Node(value: value)
        tail?.next = node
        tail = node
        
        if isEmpty {
            head = tail
        }
        self.print
    }
    
    mutating func removeLast() -> Node<T>? {
        guard !isEmpty else { return nil }
        var current = head
        var previous: Node<T>?
        
        if current?.next == nil {
            head = nil
            tail = nil
        }
        
        while current?.next != nil {
            previous = current
            current = current?.next
        }
        
        previous?.next = nil
        tail = previous
        self.print
        return tail
        
    }
    
    mutating func pop() -> Node<T>? {
        guard !isEmpty else { return nil }
        let nextHead = head?.next
        head?.next = nil
        head = nextHead
        if isEmpty {
            tail = nil
        }
        self.print
        return head
    }
    
    func node(at index: Int) -> Node<T>? {
        guard index >= 0 else { return nil }
        var current = head // 1
        var counter = 0 // 0
        
        while current?.next != nil && counter != index { // not nil, counter == 0, index == 2
            current = current?.next // current == 2
            counter += 1 // counter == 1
        }
        
        if counter != index {
            return nil
        }
        Swift.print(current?.value ?? "")
        return current
    }
    
    mutating func delete(at index: Int) -> Node<T>? {
        guard index >= 0 else { return nil }
        if index == 0 { return pop() }
        var previous: Node<T>?
        var current = head // 1
        var counter = 0 // 0
        
        while current?.next != nil && counter < index { // not nil, counter == 0, index == 1
            previous = current // 1
            current = current?.next // current == 2
            counter += 1 // counter == 1
        }
        
        if current?.next == nil {
            return removeLast()
        }
        
        previous?.next = current?.next
        
        self.print
        return current
    }
    
    mutating func insert(at index: Int, value: T) {
        guard index >= 0 else { return }
        guard index != 0 else { self.push(value)
            return
        }
        //        let current = head
        var next = head
        var node = head
        var counter = 0
        let anotherOne = Node(value: value)
        // 1. c.next -> value
        // 2. v.next -> n
        // index == 3
        // 1 -> 2 -> 3 -> nil
        // no   ne
        while node?.next != nil && counter != index { // c==0,c==1,c==2,c==3
            node = next // 1 // 2 // 3
            next = next?.next // 2 // 3 // nil
            counter += 1 // 1 // 2 // 3
        }
        
        if counter != index { return }
        
        if node?.next == nil {
            self.append(value)
            return
        }
        
        node?.next = anotherOne
        anotherOne.next = next
        
        self.print
        
    }
    
    // 1 -> 2 -> 3
//     p    c    p
    mutating func reverse() {
        var previous: Node<T>? = nil
        self.tail = self.node(at: 0)
        var current = head
        var next = head?.next
        
        while next != nil  { // not nil // not nil // nil BREAKS OUT
            current?.next = previous // 1 -> nil // 2 -> 1
            previous = current // 1 // 2
            current = next // 2 // 3
            next = current?.next // 3 // nil
        }
        
        current?.next = previous // 3 -> 2
        
        head = current
        self.print
    }
    
    mutating func reverseTwo() {
            var previousNode: Node<T>? = nil
            self.tail = self.node(at: 0)
            var currentNode = head
            var nextNode = head?.next
            
            while nextNode != nil  {
                currentNode?.next = previousNode
                previousNode = currentNode
                currentNode = nextNode
                nextNode = currentNode?.next
            }
            currentNode?.next = previousNode
            
            head = currentNode
            self.print
        }
    
    public var print: String {
        var stringArray = "["
        guard var node = head else {
            Swift.print(stringArray + "]")
            return stringArray + "]" }
        while let next = node.next {
            stringArray += "\(node.value), "
            node = next
        }
        stringArray += "\(node.value)"
        Swift.print(stringArray + "]")
        return stringArray + "]"
    }
}


var list = LinkedList<Any>()
list.append(1)
list.append(2)
list.append(3)
list.reverseTwo()


// MARK: - DOUBLY LINKED LISTS

class Node2<T> {
    
    var value: T
    var next: Node2<T>?
    var previous: Node2<T>?
    
    init(value: T, next: Node2<T>? = nil, previous: Node2<T>? = nil) {
        self.value = value
        self.next = next
        self.previous = previous
    }
}

struct LinkedList2<T> {
    
    var head: Node2<T>?
    var tail: Node2<T>?
    var size = 0
    
    var isEmpty: Bool { head == nil }
    
    public var print: String {
        var stringArray = "["
        guard var node = head else {
            Swift.print(stringArray + "]")
            return stringArray + "]" }
        while let next = node.next {
            stringArray += "\(node.value), "
            node = next
        }
        stringArray += "\(node.value)"
        Swift.print(stringArray + "]")
        return stringArray + "]"
    }
    
    mutating func push(value: T) {
        
        let newHead = Node2(value: value, next: head)
        
        head?.previous = newHead
        
        head = newHead
        
        if tail == nil {
            tail = head
        }
        self.size += 1
        self.print
    }
    
    mutating func removeLast() {
        guard head?.next != nil else {
            head = nil
            tail = nil
            self.size = 0
            self.print
            return
        }
        tail?.previous?.next = nil
        tail = tail?.previous
        self.size -= 1
        self.print
    }
    
    mutating func pop() {
        guard head?.next != nil else {
            head = nil
            tail = nil
            self.size = 0
            self.print
            return
        }
        head = head?.next
        head?.previous = nil
        self.size -= 1
        self.print
    }
    
    mutating func append(value: T) {
        guard !isEmpty else { self.push(value: value)
            return }
        let newNode = Node2(value: value, previous: tail)
        tail?.next = newNode
        tail = newNode
        self.size += 1
        self.print
    }
    
    func getAtIndex(_ index: Int) -> T? {
        guard index >= 0 && index <= self.size else {
            return nil
        }
        
        var curr = self.head
        for _ in 0..<index {
            curr = curr?.next
        }
        
        return curr?.value
    }
}

var linkedList2 = LinkedList2<Any>()
