//
//  NBTShort.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTShort: NBTTag {
    public let tagID: UInt8 = 2
    public var value: Int16
    
    public init(value: Int16) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        value = buffer.readInteger(endianness: .big, as: Int16.self) ?? 0
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(value, endianness: .big)
    }
}
