//
//  NBTByte.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTByte: NBTTag {
    public let tagID: UInt8 = 1
    public var value: Int8
    
    public init(value: Int8) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        value = buffer.readInteger(endianness: .big, as: Int8.self) ?? 0
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(tagID, endianness: .big)
        buffer.writeInteger(value, endianness: .big)
    }
}
