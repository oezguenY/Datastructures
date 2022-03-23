
import Foundation

// MARK: - QUEUES

// A FIFO datastructure (First In First Out)

// An analogy is a queue of people: the person first in line will be the first one out
// contrast that with a stack of books (LIFO), where you pick up the last book you put on top

// use APPEND + POP

// MARK: - BIG O OF QUEUES
/*
 Insertion O(1)
 Removal O(1)
 Searching O(N)
 Access O(N)
 */


// MARK: - USING ARRAYS

var queue = [String]()

queue.append("FIRST")
queue.append("SECOND")
queue.append("THIRD")

// removing the first thing that was added to the array -> FIFO

queue.removeFirst()
queue.removeFirst()
queue.removeFirst()

queue

// MARK: - CREATING OWN QUEUE FROM SCRATCH

class Node<T> {

    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}


// MARK: - PUSH

struct Queue<T> {

    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool { head == nil }
    
    mutating func enqueue(_ value: T) {
        let node = Node(value: value)
        // creating new node at the end
        tail?.next = node
        // assigning new node to the tail
        // This time, we are only changing the tail since we are appending at the end of the list
        tail = node
        
        if isEmpty {
            head = node
        }
    }
    
    mutating func dequeue() -> Node<T>? {
        //... then, after the function has returned, defer is called. If the List is empty now, nil is assigned to head. And because head is nil, isEmpty is true and the tail will also be set to nil
        defer {
            // we are assigning the next node to be the head
            head = head?.next
            // if there is no head, set the tail to nil
            if isEmpty {
                tail = nil
            }
        }
        // First, this line is called...
        return head
    }
}

