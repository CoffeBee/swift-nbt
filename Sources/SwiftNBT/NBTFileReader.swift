//
//  NBTFileReader.swift
//
//
//  Created by Ivan Podvorniy on 07.08.2021.
//

import NIO
import CompressNIO

public class NBTFileReader {
    let io: NonBlockingFileIO
    var byteBuffer: ByteBuffer
    let bufferAllocator: ByteBufferAllocator
    
    init(io: NonBlockingFileIO, bufferAllocator: ByteBufferAllocator) throws {
        self.io = io
        self.bufferAllocator = bufferAllocator
        self.byteBuffer = bufferAllocator.buffer(capacity: 0)
    }
    
    func read(path: String, eventLoop: EventLoop, gzip: Bool = true) -> EventLoopFuture<NBT> {
        return io.openFile(path: path, eventLoop: eventLoop).flatMap { fileHandle, fileRegion in
            return self.io.readChunked(fileRegion: fileRegion, allocator: self.bufferAllocator, eventLoop: eventLoop) { nextPart in
                self.byteBuffer.writeImmutableBuffer(nextPart)
                return eventLoop.makeSucceededVoidFuture()
            }.flatMapThrowing {
                try fileHandle.close()
                return try NBT(readFrom: &self.byteBuffer, gzip: gzip)
            }
        }
    }
}
