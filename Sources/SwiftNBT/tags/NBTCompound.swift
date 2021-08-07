//
//  NBTCompound.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public struct NBTCompound: NBTTag {
    public let tagID: UInt8 = 10
    public var value: [String: NBTTag]
    
    public init(value: [String: NBTTag]) {
        self.value = value
    }
    
    
    public init(readFrom buffer: inout ByteBuffer) {
        self.value = [String: NBTTag]()
        while (true) {
            let newTagID = buffer.readInteger(endianness: .big, as: UInt8.self) ?? 0
            if (newTagID == 0) {
                break
            }
            let newNameLength = buffer.readInteger(endianness: .big, as: UInt16.self) ?? 0
            let newTagName = buffer.readString(length: Int(newNameLength)) ?? ""
            value[newTagName] = NBTTags.tags[newTagID]!.init(readFrom: &buffer)
        }
    }
    
    public func write(to buffer: inout ByteBuffer) {
        buffer.writeInteger(tagID, endianness: .big)
        for (name, tag) in self.value {
            buffer.writeInteger(tag.tagID, endianness: .big)
            buffer.writeInteger(UInt16(name.count), endianness: .big, as: UInt16.self)
            buffer.writeString(name)
            tag.write(to: &buffer)
        }
        NBTEnd().write(to: &buffer)
    }
}
