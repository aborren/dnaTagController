import UIKit
import XCTest
import dnaTagController

class Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testTagControllerGetElements() {
        var dataSource: [Taggable] = []
        XCTAssert(dataSource.isEmpty)
        
        let e1 = TaggableTestObject(id: "1", tags: ["a"])
        let e2 = TaggableTestObject(id: "2", tags: ["b"])
        let e3 = TaggableTestObject(id: "3", tags: ["a", "b"])
        let e4 = TaggableTestObject(id: "4", tags: ["a", "a"])
        
        dataSource = [e1, e2, e3, e4]
        XCTAssert(dataSource.count == 4)
        
        let controller = TagController(with: dataSource)
        
        // MARK: Single tag
        let elementsWithA: [TaggableTestObject] = controller.getElements(tagged: "a") as! [TaggableTestObject]
        print("ELEMENTS TAGGED WITH a:\n \(elementsWithA)\n")
        XCTAssert(Set(elementsWithA) == [e1, e3, e4])
        
        let elementsWithB: [TaggableTestObject] = controller.getElements(tagged: "b") as! [TaggableTestObject]
        print("ELEMENTS TAGGED WITH a:\n \(elementsWithB)\n")
        XCTAssert(Set(elementsWithB) == [e2, e3])
        
        // MARK: Multiple tags
        let elementsWithAB: [TaggableTestObject] = controller.getElements(tagged: ["a", "b"]) as! [TaggableTestObject]
        print("ELEMENTS TAGGED WITH a + b:\n \(elementsWithAB)\n")
        XCTAssert(Set(elementsWithAB) == [e3])
        
        let elementsWithNothing = controller.getElements(tagged: []) as! [TaggableTestObject]
        print("NO ELEMENTS:\n \(elementsWithNothing)")
        XCTAssert(elementsWithNothing.isEmpty)
        
        let elementsWithC = controller.getElements(tagged: "c") as! [TaggableTestObject]
        print("ELEMENTS TAGGED WITH c:\n \(elementsWithC)")
        XCTAssert(elementsWithC.isEmpty)
        
        let elementsWithCapitalA = controller.getElements(tagged: "A") as! [TaggableTestObject]
        print("ELEMENTS TAGGED WITH A:\n \(elementsWithCapitalA)")
        XCTAssert(elementsWithCapitalA.isEmpty)
    }
    
    func testTagControllerSearch() {
        var dataSource: [Taggable] = []

        let e1 = TaggableTestObject(id: "1", tags: ["a"])
        let e2 = TaggableTestObject(id: "2", tags: ["b"])
        let e3 = TaggableTestObject(id: "3", tags: ["a", "b"])
        let e4 = TaggableTestObject(id: "4", tags: ["a", "a"])
        let e5 = TaggableTestObject(id: "5", tags: [])
        let e6 = TaggableTestObject(id: "6", tags: ["A"])
        let e7 = TaggableTestObject(id: "7", tags: ["aa", "A"])
        let e8 = TaggableTestObject(id: "8", tags: ["AA", "1A"])
        let e9 = TaggableTestObject(id: "9", tags: ["1A"])
        
        let controller1 = TagController(with: dataSource)
        
        let result1: [TaggableTestObject] = controller1.searchForElementsWithTags(containing: "") as! [TaggableTestObject]
        XCTAssert(result1.isEmpty)
        
        dataSource = [e1, e2, e3, e4, e5, e6, e7, e8, e9]
        let controller2 = TagController(with: dataSource)
        
        let result2: [TaggableTestObject] = controller2.searchForElementsWithTags(containing: "") as! [TaggableTestObject]
        XCTAssert(result2.isEmpty)
        
        let result3: [TaggableTestObject] = controller2.searchForElementsWithTags(containing: "a") as! [TaggableTestObject]
        XCTAssert(Set(result3) == [e1, e3, e4, e6, e7, e8, e9])
        
        let result4: [TaggableTestObject] = controller2.searchForElementsWithTags(containing: "aa") as! [TaggableTestObject]
        XCTAssert(Set(result4) == [e7, e8])
        
        let result5: [TaggableTestObject] = controller2.searchForElementsWithTags(containing: "1") as! [TaggableTestObject]
        XCTAssert(Set(result5) == [e8, e9])
        
        let result6: [TaggableTestObject] = controller2.searchForElementsWithTags(containing: "b") as! [TaggableTestObject]
        XCTAssert(Set(result6) == [e2, e3])
    }
    
    func testTagControllerAllElements() {
        var dataSource: [Taggable] = []
        XCTAssert(dataSource.isEmpty)
        
        let e1 = TaggableTestObject(id: "1", tags: ["a"])
        let e2 = TaggableTestObject(id: "2", tags: ["b"])
        let e3 = TaggableTestObject(id: "3", tags: ["a", "b"])
        let e4 = TaggableTestObject(id: "4", tags: ["a", "a"])
        
        dataSource = [e1, e2, e3, e4]
        XCTAssert(dataSource.count == 4)
        
        let controller1 = TagController(with: dataSource)
        
        var allTags: [String] = controller1.getAllTags()
        print(allTags)
        XCTAssert(Set(allTags) == Set(["a", "b"]))
        
        let e5 = TaggableTestObject(id: "5", tags: [])
        let e6 = TaggableTestObject(id: "6", tags: ["A"])
        let e7 = TaggableTestObject(id: "7", tags: ["aa", "A"])
        let e8 = TaggableTestObject(id: "8", tags: ["AA", "1A"])
        
        dataSource = dataSource + [e5, e6, e7, e8]
        
        let controller2 = TagController(with: dataSource)
        allTags = controller2.getAllTags()
        print(allTags)
        XCTAssert(Set(allTags) == Set(["a", "b", "A", "aa", "AA", "1A"]))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
