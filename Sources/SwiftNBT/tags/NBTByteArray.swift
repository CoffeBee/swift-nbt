//
//  NBTByteArray.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTByteArray: NBTTag {
    public let tagID: UInt8 = 7
    public var value: [Int8]
    
    public init(value: [Int8]) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        let length = buffer.readInteger(endianness: .big, as: Int32.self) ?? 0
        if length <= 0 {
            value = [Int8]()
            return
        }
        self.value = (0..<length).map { _ in
            buffer.readInteger(endianness: .big, as: Int8.self) ?? 0
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
