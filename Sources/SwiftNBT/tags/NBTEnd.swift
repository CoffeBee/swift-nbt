//
//  NBTEnd.swift
//  
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTEnd: NBTTag {
    public let tagID: UInt8 = 0
    
    public init(readFrom buffer: inout ByteBuffer) {
        
    }
    
    public init() {}
    
    public func write(to buffer: inout ByteBuffer) {
        
    }
}
