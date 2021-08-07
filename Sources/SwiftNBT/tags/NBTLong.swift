//
//  NBTLong.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTLong: NBTTag {
    public let tagID: UInt8 = 4
    public var value: Int64
    
    public init(value: Int64) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        value = buffer.readInteger(endianness: .big, as: Int64.self) ?? 0
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(tagID, endianness: .big)
        buffer.writeInteger(value, endianness: .big)
    }
}
