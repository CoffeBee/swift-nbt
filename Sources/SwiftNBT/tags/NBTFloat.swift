//
//  NBTFloat.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTFloat: NBTTag {
    public let tagID: UInt8 = 5
    public var value: Float32
    
    public init(value: Float32) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        value = Float32(bitPattern: buffer.readInteger(endianness: .big, as: UInt32.self) ?? 0)
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(value.bitPattern, endianness: .big)
    }
}
