//
//  NBTList.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTList: NBTTag {
    public let tagID: UInt8 = 9
    public var elementTypeID: UInt8
    public var value: [NBTTag]
    
    public init(elementTypeID: UInt8, value: [NBTTag]) {
        self.elementTypeID = elementTypeID
        self.value = value
    }
    
    
    public init(readFrom buffer: inout ByteBuffer) {
        let elementTypeID = buffer.readInteger(endianness: .big, as: UInt8.self) ?? 0
        self.elementTypeID = elementTypeID
        let length = buffer.readInteger(endianness: .big, as: Int32.self) ?? 0
        if length <= 0 {
            value = [NBTTag]()
            return
        }
        self.value = (0..<length).map { _ in
            NBTTags.tags[elementTypeID]!.init(readFrom: &buffer)
        }
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(elementTypeID, endianness: .big)
        buffer.writeInteger(value.count, endianness: .big)
        value.map {
            $0.write(to: &buffer)
        }
    }
}
