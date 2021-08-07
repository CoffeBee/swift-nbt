//
//  NBTTags.swift
//  
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

public struct NBTTags {
    static let tags = [
        0x00: NBTEnd.self,
        0x01: NBTByte.self,
        0x02: NBTShort.self,
        0x03: NBTInt.self,
        0x04: NBTLong.self,
        0x05: NBTFloat.self,
        0x06: NBTDouble.self,
        0x07: NBTByteArray.self,
        0x08: NBTString.self,
        0x09: NBTList.self,
        0x0a: NBTCompound.self,
        0x0b: NBTIntArray.self,
        0x0c: NBTLongArray.self,
    ] as [UInt8 : NBTTag.Type]
}
