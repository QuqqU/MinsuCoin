//
//  BlockChain.swift
//  BlockChain
//
//  Created by 정기웅 on 2018. 4. 17..
//  Copyright © 2018년 정기웅. All rights reserved.
//

import Foundation

protocol NodeProtocol {
    associatedtype T
    
    func makeBlock(nounce: Int, isGenesisBlock: Bool) -> Block
    func makeTransaction(_ transaction: Transaction)
    func proofOfWork() -> Int
    func isValidBlock(_ block: Block) -> Bool
    func isValidTransaction(_ transaction: Transaction) -> Bool
}



class Node {
    var difficultyOfProblem = 1
    var blockChain: [Block] = []
    var unconfirmedTransactions: [Transaction] = []
    
    init() {
        do {
            try addBlock(isGenesisBlock: true)
        }
        catch { print(error.localizedDescription.debugDescription) }
    }

    func addBlock(isGenesisBlock: Bool = false) throws {
        guard checkValidOfTransactions() else { throw Error.invalidTransaction }
    
        let nounce = proofOfWork()
        let newBlock = makeBlock(nounce: nounce, isGenesisBlock: isGenesisBlock)
        guard isValidBlock(newBlock) else { throw Error.invalidBlock }
        blockChain.append(newBlock)
        unconfirmedTransactions.removeAll()
    
    }
    
    func makeBlock(nounce: Int, isGenesisBlock: Bool) -> Block {
        let prevBlockHash: Data
        if isGenesisBlock { prevBlockHash = "1".data(using: .utf8)! }
        else { prevBlockHash = blockChain.last!.hash() }
        

        let block = Block(index: blockChain.count,
                          timeStamp: Date().timeIntervalSince1970,
                          transactions: unconfirmedTransactions,
                          previousBlockHash: prevBlockHash,
                          nounce: nounce,
                          difficultyOfProblem: difficultyOfProblem)
        return block
    }
    
    func isValidBlock(_ block: Block) -> Bool {
        for block in blockChain {
            //check nounce is valid
            //prevhash value
            //order of timestamp
        }
        return true
    }
    
    func isVaildTransaction(_ transaction: Transaction) -> Bool {
        //public key
        
        //private key
        
        return true
    }
    func checkValidOfTransactions() -> Bool {
        for transaction in unconfirmedTransactions {
            if !isVaildTransaction(transaction) { return false }
        }
        return true
    }
    
    func makeTransaction(_ transaction: Transaction) throws {
        guard isVaildTransaction(transaction) else { throw Error.invalidTransaction }
        unconfirmedTransactions.append(transaction)
    }
    
    func setdifficultyOfProblem(numberOfBlocks num: Int) {
        difficultyOfProblem = num / 100
    }
    
    func proofOfWork() -> Int {
        setdifficultyOfProblem(numberOfBlocks: blockChain.count)
        var nounce: Int = 0
        while !validProof(nounce: nounce) { nounce += 1 }
        return nounce
    }
    
    func validProof(nounce: Int) -> Bool {
        guard let guess = String("\(blockChain.last!.nounce)\(nounce)").data(using: .utf8) else {
            fatalError()
        }
        var numOfLeadingZero: String = ""
        for _ in 0..<difficultyOfProblem { numOfLeadingZero += "0" }
        return guess.sha256().prefix(difficultyOfProblem).description == numOfLeadingZero
    }
    
}

extension Node {
    enum Error : Swift.Error {
        case invalidTransaction
        case invalidBlock
        case lastBlockChanged
    }
}





