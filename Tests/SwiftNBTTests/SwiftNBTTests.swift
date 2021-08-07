import XCTest
import NIO
import Foundation
@testable import SwiftNBT

final class SwiftNBTTests: XCTestCase {
    func testHelloWorld() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let threadPool = NIOThreadPool(numberOfThreads: 2)
        threadPool.start()
        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 2).next()
        let allocator = ByteBufferAllocator()
        let reader = try! NBTFileReader(io: NonBlockingFileIO(threadPool: threadPool), bufferAllocator: allocator)
        
        let helloWorldNBT = try! reader.read(path: Bundle.module.path(forResource: "hello_world", ofType: "nbt") ?? "", eventLoop: eventLoop, gzip: false).wait()
        checkHellowWorld(nbt: helloWorldNBT)
        var gzipedNBTBuffer = allocator.buffer(capacity: 0)
        XCTAssertNoThrow(try helloWorldNBT.write(to: &gzipedNBTBuffer))
        let compressHelloWorldNBT = try! NBT(readFrom: &gzipedNBTBuffer)
        checkHellowWorld(nbt: compressHelloWorldNBT)
    }
    
    
    func checkHellowWorld(nbt: NBT) {
        XCTAssertEqual(nbt.rootTagName, "hello world")
        XCTAssertTrue(nbt.rootTag is NBTCompound)
        XCTAssertNotNil((nbt.rootTag as! NBTCompound).value["name"])
        XCTAssertTrue((nbt.rootTag as! NBTCompound).value["name"] is NBTString)
        XCTAssertEqual(((nbt.rootTag as! NBTCompound).value["name"] as! NBTString).value, "Bananrama")
    }

    static var allTests = [
        ("testHelloWorld", testHelloWorld),
    ]
}
