//
//  NBTLongArray.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTLongArray: NBTTag {
    public let tagID: UInt8 = 12
    public var value: [Int64]
    
    public init(value: [Int64]) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        let length = buffer.readInteger(endianness: .big, as: Int32.self) ?? 0
        if length <= 0 {
            value = [Int64]()
            return
        }
        self.value = (0..<length).map { _ in
            buffer.readInteger(endianness: .big, as: Int64.self) ?? 0
        }
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(tagID, endianness: .big)
        buffer.writeInteger(value.count, endianness: .big)
        value.map {
            buffer.writeInteger($0, endianness: .big)
        }
    }
}
