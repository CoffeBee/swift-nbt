//
//  NBTString.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTString: NBTTag, Equatable {
    public let tagID: UInt8 = 8
    public var value: String
    
    public init(value: String) {
        self.value = value
    }
    
    public init(readFrom buffer: inout ByteBuffer) {
        let length = buffer.readInteger(endianness: .big, as: UInt16.self) ?? 0
        value = buffer.readString(length: Int(length)) ?? ""
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(UInt16(value.count), endianness: .big, as: UInt16.self)
        buffer.writeString(value)
    }
}
