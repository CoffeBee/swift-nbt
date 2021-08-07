//
//  NBTFloat.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTDouble: NBTTag {
    public let tagID: UInt8 = 6
    public var value: Float64
    
    public init(value: Float64) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        value = Float64(bitPattern: buffer.readInteger(endianness: .big, as: UInt64.self) ?? 0)
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(tagID, endianness: .big)
        buffer.writeInteger(value.bitPattern, endianness: .big)
    }
}
