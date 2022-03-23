
import Foundation

// MARK: - STACKS

// A LIFO data structure. The last element added to the stack will be the first element. Think of the call stack when using recursion

// removed from the stack

// stacks are used to handle function invocations (the call stack), for operations like

// undo/redo, and for routing (remember pages you have visited and go back/forward)

// WE DO THAT WITH PUSH AND POP (INSERTING AND REMOVING FROM THE BEGINNING OF THE LIST)

// With push and pop (appending and removing from top of stack), the Big O is O(1) because we don't traverse the stack (which is a singly linked list here). If we used an array for a stack and not a linked list, we can still use push and pop, it would be really inefficient though because of the need to reindex. In this case, it would be more efficient to append and remove from the end of the array, so there is no need to reindex (when using arrays)

// MARK: - USING AN ARRAY

var stack = [String]()

stack.insert("FIRST", at: 0)
stack.insert("SECOND", at: 0)
stack.insert("THIRD", at: 0)

// removing the last thing that was added to the array -> LIFO

stack.removeFirst()
stack.removeFirst()
stack.removeFirst()

stack


// MARK: - BUILDING STACK FROM SCRATCH

class Node<T> {

    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

struct Stack<T> {

    var head: Node<T>?
    var tail: Node<T>?
    var size = 0
    
    var isEmpty: Bool { head == nil }
    
    mutating func push(_ value: T) {
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    
    mutating func pop() -> Node<T>? {
        defer {
 
            head = head?.next
            
            if isEmpty {
                tail = nil
            }
        }
        return head
    }
}

// MARK: - BIG O

// Insertion: O(1)
// Removal: O(1)
// Searching: O(N)
// Access: O(N)


