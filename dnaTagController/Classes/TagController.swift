import Foundation

public struct TagController {
    
    typealias Tag = String
    
    private var dictionary: [Tag: [TaggableBox]]
    
    /// Used so we can easily convert between sets/arrays for Taggable objects (without forcing the Taggable protocol to implement Hashable)
    private struct TaggableBox: Hashable {
        var hash: Int
        var content: Taggable
        
        var hashValue: Int { return hash }
        
        static func ==(lhs: TaggableBox, rhs: TaggableBox) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }
    
    public init(with dataSource: [Taggable]) {
        
        dictionary = [:]
        var hash: Int = 0
        
        /// Wrap each Taggable in a box and add it into the dictionary for the given tag.
        dataSource.forEach { item in
            let box = TaggableBox(hash: hash, content: item)
            item.tags.forEach { tag in
                if dictionary[tag] != nil {
                    dictionary[tag]?.append(box)
                } else {
                    dictionary[tag] = [box]
                }
            }
            
            hash += 1
        }
        
    }
    
    public func getAllTags() -> [String] {
        return Array(dictionary.keys)
    }
    
    private func getBoxedElements(tagged with: String) -> [TaggableBox] {
        return dictionary[with] ?? []
    }
    
    /// Case sensitive get method
    public func getElements(tagged with: String) -> [Taggable] {
        return getBoxedElements(tagged: with).map { $0.content }
    }
    
    /// Case sensitive get method
    public func getElements(tagged with: [String]) -> [Taggable] {
        guard with.count > 0 else { return [] }
        
        var boxedElementSets: [Set<TaggableBox>] = []
        
        with.forEach { tag in
            boxedElementSets.append(Set(getBoxedElements(tagged: tag)))
        }
        
        guard var boxedElementIntersection: Set<TaggableBox> = boxedElementSets.first else { return [] }
        
        for i in 1..<boxedElementSets.count {
            boxedElementIntersection = boxedElementIntersection.intersection(boxedElementSets[i])
        }
        
        return boxedElementIntersection.map { $0.content }
    }
    
    /// Case insensitive search for elements whose tags contain the given search string.
    public func searchForElementsWithTags(containing: String) -> [Taggable] {
        var boxedElements: Set<TaggableBox> = []
        
        for (key, value) in dictionary {
            if key.lowercased().contains(containing.lowercased()) {
                boxedElements = boxedElements.union(value)
            }
        }
        
        return boxedElements.map { $0.content }
    }
    
}
