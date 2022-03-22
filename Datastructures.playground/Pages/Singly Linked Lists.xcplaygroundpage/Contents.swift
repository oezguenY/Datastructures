import Foundation

// Data structures are collections of values, the relationships among them, and the functions or operations that can be applied to the data

// A linked list is a list of linked Nodes. A node is a single element that contains a generic value and a reference/pointer to the next node. It is a data structure that contains a head and a tail. Linked List consist of nodes and each node has a value and a pointer to another node or nil

// Nodes must be reference types, so that is why we declare it as a class

class Node<T> {
    // generic value
    var value: T
    // reference/pointer to the next node
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

// A linked list is a value type. So we define it as a struct. By default, a linked list has three basic properties.
// -> head: the first node of the list
// -> tail: the last node of the list
// -> isEmpty: Whether or not the list is empty

// MARK: - PUSH

// By pushing data to a list, we are adding data in front of the list. This means the current head will be replaced with the new node, and the new node will become the head of the list

struct LinkedListPush<T> {
    
    mutating func push(_ value: T) {
        // we are adding data in front of the list
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool { head == nil }
}

var linkedList = LinkedListPush<Any>()

linkedList.push(3)
linkedList.head?.value
linkedList.push(4)
linkedList.head?.value
linkedList.tail?.value
linkedList.push(5)
linkedList.head?.value
linkedList.tail?.value

// once a value is assigned to tail, the value won't change. We are only pushing values to the front of the list, that means only the head changes

// MARK: - APPEND

// Similar to push, by appending data to a list, we add data to the end of the list. This means, the current tail will be replaced with the new node, the new node will become the new tail

struct LinkedListAppend<T> {
    
    mutating func append(_ value: T) {
        let node = Node(value: value)
        // creating new node at the end
        tail?.next = node
        // assigning new node to the tail
        // This time, we are only changing the tail since we are appending at the end of the list
        tail = node
        
        if head == nil {
            head = node
        }
    }
    
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool { head == nil }
    
}

var linkedListAppend = LinkedListAppend<Any>()
linkedListAppend.append(1)
linkedListAppend.append(2)
linkedListAppend.append(3)
linkedListAppend.head?.value
linkedListAppend.tail?.value


// MARK: - POP

// By popping data, we remove the head from the list, so the second node will then become the head

struct LinkedListPop<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool { head == nil }
    
    mutating func pop() -> T? {
        defer {
            // we are assigning the next node to be the head
            head = head?.next
            // if there is no head, set the tail to nil
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
}

// MARK: - LINKED LIST ALL



struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    // this property is true if head == nil
    var isEmpty: Bool { get { head == nil } }
    
    mutating func push(_ value: T) {
        // we are adding data in front of the list
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
        self.print
    }
    mutating func append(_ value: T) {
        let node = Node(value: value)
        // creating new node at the end
        tail?.next = node
        // assigning new node to the tail
        // This time, we are only changing the tail since we are appending at the end of the list
        tail = node
        
        if isEmpty {
            head = node
        }
        self.print
    }
    
    mutating func pop() -> Node<T>? {
        //... then, after the function has returned, defer is called. If the List is empty now, nil is assigned to head. And because head is nil, isEmpty is true and the tail will also be set to nil
        defer {
            // we are assigning the next node to be the head
            head = head?.next
            // if there is no head, set the tail to nil
            if isEmpty {
                tail = nil
            }
            self.print
        }
        // First, this line is called...
        return head
    }
    
    mutating func deleteNode(at position: Int) {
        
        guard position >= 0 else { return }
        
        if isEmpty { return }
        
        var temp = head
        
        if (position == 0) {
            head = temp?.next
            return
        }
        
        for _ in 0..<position-1 where temp != nil {
            temp = temp?.next
        }
        
        if temp == nil || temp?.next == nil {
            return
        }
        
        let nextToNextNode = temp?.next?.next
        temp?.next = nextToNextNode
    }
    
    mutating func removeLast() -> Node<T>? {
        // return if the list is empty (because there isnt anything to remove)
        guard let head = head else { return nil }
        // if there is just one node, that would mean head.next == nil, so we could use pop
        guard head.next != nil else { return pop() }
        
        var newTail = head
        var currentNode = head
        
        while let next = currentNode.next {
            // newTail is being set to the currentNode, thus newTail lags behind
            newTail = currentNode
            // currentNode gets set to the next node
            currentNode = next
        }
        
        newTail.next = nil
        tail = newTail
        self.print
        return currentNode
    }
    
    func node(at index: Int) -> Node<T>? {
        guard index >= 0 else { return nil }
        var currentIndex = 0
        var currentNode = head
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
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
    
    mutating func reverse() {
        guard !isEmpty else { return }
        var previousNode: Node<T>? = nil
        self.tail = self.node(at: 0)
        var currentNode = head // 1
        var nextNode = head?.next // 2
        while nextNode != nil { // 2 // 3 // 4
            // 1 -> nil // 2 -> 1 // 3 -> 2
            currentNode?.next = previousNode
            
            // pN = 1 // pN = 2 // pN = 3
            previousNode = currentNode
            
            // cN = 2 // cN = 3 // cN = 4
            currentNode = nextNode
            
            // nN = 3 // nN = 4 // nN = nil (so we break out of the loop)
            nextNode = currentNode?.next
            
            
        }
        // 4 -> 3
        currentNode?.next = previousNode
        
        head = currentNode
        
    }
    
    mutating func insert(data : T, at index : Int) {
        guard index >= 0 else { return }
        let newNode = Node(value: data)
        
        if index == 0 { self.push(data) } else {
            var previous = head
            var current = head
            for _ in 0..<index { // 0 // breaks out
                previous = current // 1
                current = current?.next // 3
            }
            
        
            newNode.next = previous?.next // newNode is 2 next is nil, previous is 1 next 3, so    2 -> 3
            if newNode.next == nil { // if there is no next node, this means we are appending at the end
                self.append(data)
                return
            }
            previous?.next = newNode // 1 -> 2
            self.print
        }
    }
    
}

var list = LinkedList<Any>()
list.append(1)
list.append(3)
list.insert(data: 2, at: 1)

// PRINTS:
// [1]
// [1, 3]
// [1, 2, 3]
