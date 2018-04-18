//
//  Block.swift
//  BlockChain
//
//  Created by 정기웅 on 2018. 4. 17..
//  Copyright © 2018년 정기웅. All rights reserved.
//

import Foundation


struct Block : Codable {
    let index: Int // order of block
    let timeStamp: Double//
    let transactions: [Transaction]
    let previousBlockHash: Data
    var nounce: Int // mining
    var difficultyOfProblem: Int

    func hash() -> Data {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(self)
        return jsonData.sha256()
    }
}


