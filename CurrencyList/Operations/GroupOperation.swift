//
//  GroupOperation.swift
//  UltimateGuitar
//
//  Created by ANDREY KLADOV on 30/11/2016.
//
//

import Foundation

open class GroupOperation: ConcurrentOperation {
    
    public let operationQueue: OperationQueue
    private(set) public var operations: [Operation]
    
    public init(operationQueue: OperationQueue = OperationQueue(), operations: [Operation]) {
        self.operationQueue = operationQueue
        self.operations = operations
        super.init()
    }
    
    open override func cancel() {
        super.cancel()
        operationQueue.cancelAllOperations()
    }
    
    open override func main() {
        
        guard !isCancelled else {
            finish()
            return
        }
        
        let finishing = BlockOperation {}
        finishing.completionBlock = finish
        finishing.addDependencies(operations)
        operationQueue.addOperations(operations+[finishing])
    }
}
