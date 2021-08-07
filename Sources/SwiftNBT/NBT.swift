//
//  NBT.swift
//  
//
//  Created by Ivan Podvorniy on 07.08.2021.
//

import NIO

public struct NBT {
    public var rootTagName: String
    public var rootTag: NBTTag
    
    init(readFrom buffer: inout ByteBuffer, gzip: Bool = true) throws {
        if gzip {
            var decompressed = try buffer.decompress(with: .gzip)
            let rootTagID = decompressed.readInteger(endianness: .big, as: UInt8.self) ?? 0
            let rootTagNameLength = decompressed.readInteger(endianness: .big, as: UInt16.self) ?? 0
            rootTagName = decompressed.readString(length: Int(rootTagNameLength)) ?? ""
            rootTag = NBTTags.tags[rootTagID]!.init(readFrom: &decompressed)
        }
        else {
            let rootTagID = buffer.readInteger(endianness: .big, as: UInt8.self) ?? 0
            let rootTagNameLength = buffer.readInteger(endianness: .big, as: UInt16.self) ?? 0
            rootTagName = buffer.readString(length: Int(rootTagNameLength)) ?? ""
            rootTag = NBTTags.tags[rootTagID]!.init(readFrom: &buffer)
        }
    }
}
