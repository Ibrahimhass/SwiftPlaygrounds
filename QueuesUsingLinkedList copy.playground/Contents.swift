//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"

//: Advantage of node over arrays is that it is more efficient while removing and inserting elements as compared to array

class Node {
    
    var value : Int
    var next : Node?
    
    init(value: Int) {
        self.value = value
    }
}

class LinkedList {
    
    var head : Node?
    
    init(head: Node?) {
        self.head = head
    }
    
//: Append data to linked List
    
    func append(_ node : Node) {
        //Check for empty Linked List and assign the node to head if empty
        guard head != nil else {
            head = node
            return
        }
        
        var current = head
        // Loop to the last element in the Linked List
        while let _ = current?.next {
            current = current?.next
        }
        // Retrieved the last element
        current?.next = node
    }
    
//: Get Node at Index
 
    func getNode(atPosition position: Int) -> Node? {
        guard position > 0 else {
            return nil
        }
        
        var counter = 1
        var current = head
        
        while current != nil && counter <= position {
            if counter == position {
                return current
            }
            current = current?.next
            counter += 1
        }
        return nil
    }
    
//: Insert Node at Index
    
    func insertNode(_ node: Node, at position: Int) {
        guard position > 0 else {
            return
        }
        
        var counter = 1
        var current = head
        
        if position > 1 {
            while current != nil && counter < position {
                if counter == position - 1 {
                    node.next = current?.next
                    current?.next = node
                    break
                }
                current = current?.next
                counter += 1
            }
        } else if position == 1 {
            node.next = head
            head = node
        }
    }
    
//: Delete Node at Value
    
    func deleteNode(withValue value: Int) {
        var current = head
        var previous: Node?
        
        while current?.value != value && current?.next != nil {
            previous = current
            current = current?.next
        }
        
        if current?.value == value {
            if previous != nil {
                previous?.next = current?.next
            } else {
                head = current?.next
            }
        }
    }
    
}

//: Stack Implementation

class Stack {
    
    var ll: LinkedList
    
    init(top: Node?) {
        self.ll = LinkedList(head: top)
    }
    
//: Naive Solution
    // add a node to the top of the stack
    func push(_ node: Node) {
        ll.insertNode(node, at: 1)
//        guard ll.head != nil else {
//            ll.head = node
//            return
//        }
//
//        var current = ll.head
//        while let _ = current?.next {
//            current = current?.next
//        }
//        current?.next = node
    }
    
    // remove and return the topmost node from the stack
//: Naive Solution
    func pop() -> Node? {
        let deletedNode = ll.getNode(atPosition: 1)
        if let value = deletedNode?.value {
            ll.deleteNode(withValue: value)
        }
        return deletedNode
//        guard ll.head != nil else  {
//            return nil
//        }
//
//        var current = ll.head
//        var tempVal : Node?
//        var previousNode : Node?
//        while let _ = current?.next {
//            previousNode = current
//            current = current?.next
//        }
//        tempVal = current
//        if ll.head?.next == nil {
//            ll.head = nil
//            tempVal = current
//        } else {
//            previousNode?.next = nil
//        }
//        return tempVal
    }

//: Better Implementation
    
    

}

//: Test

let n1 = Node(value: 1)
let n2 = Node(value: 2)
let n3 = Node(value: 3)
let n4 = Node(value: 4)

let stack = Stack(top: n1)
stack.push(n2)
stack.push(n3)
stack.push(n4)
print (stack.pop()?.value ?? "Empty")
print (stack.pop()?.value ?? "Empty")
print (stack.pop()?.value ?? "Empty")
print (stack.pop()?.value ?? "Empty")


