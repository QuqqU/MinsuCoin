//
//  Transaction.swift
//  BlockChain
//
//  Created by 정기웅 on 2018. 4. 17..
//  Copyright © 2018년 정기웅. All rights reserved.
//

import Foundation


struct Transaction: Codable {
    let sender: String
    let recipient: String
    let amount: UInt
}
