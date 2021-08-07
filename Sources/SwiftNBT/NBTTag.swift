//
//  NBTTag.swift
//
//
//  Created by Ivan Podvorniy on 06.08.2021.
//

import NIO

public protocol NBTTag {
    var tagID: UInt8 { get }
    
    init(readFrom buffer: inout ByteBuffer)
    
    func write(to buffer: inout ByteBuffer)

}
