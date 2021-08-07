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
        let reader = try! NBTFileReader(io: NonBlockingFileIO(threadPool: threadPool), bufferAllocator: ByteBufferAllocator())
        
        let helloWorldNBT = try! reader.read(path: Bundle.module.path(forResource: "hello_world", ofType: "nbt") ?? "", eventLoop: eventLoop, gzip: false).wait()
        XCTAssertEqual(helloWorldNBT.rootTagName, "hello world")
        XCTAssertTrue(helloWorldNBT.rootTag is NBTCompound)
        XCTAssertNotNil((helloWorldNBT.rootTag as! NBTCompound).value["name"])
        XCTAssertTrue((helloWorldNBT.rootTag as! NBTCompound).value["name"] is NBTString)
        XCTAssertEqual(((helloWorldNBT.rootTag as! NBTCompound).value["name"] as! NBTString).value, "Bananrama")
    }

    static var allTests = [
        ("testHelloWorld", testHelloWorld),
    ]
}
