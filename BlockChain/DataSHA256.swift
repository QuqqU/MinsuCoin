//
//  DataSHA256.swift
//  BlockChain
//
//  Created by 정기웅 on 2018. 4. 17..
//  Copyright © 2018년 정기웅. All rights reserved.
//

import Foundation


extension Data {
    func sha256() -> Data {
        guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else {
            fatalError("SHA256 fatal error")
        }
        CC_SHA256((self as NSData).bytes, CC_LONG(self.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
        return res as Data
    }
}
