//
//  NBTInt.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTInt: NBTTag, Equatable {
    public let tagID: UInt8 = 3
    public var value: Int32
    
    public init(value: Int32) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        value = buffer.readInteger(endianness: .big, as: Int32.self) ?? 0
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(value, endianness: .big)
    }
}
