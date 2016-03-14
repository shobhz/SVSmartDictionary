//
//  OrderedDictionary.swift
//  ZohoBooks
//
//  Created by shobhan.vijay on 3/8/16.
//  Copyright © 2016 Zoho. All rights reserved.
//

import Foundation

public class SVSmartDictionary : NSObject {
    
    var orderedDict = NSDictionary?()
    var array = NSArray?()
    
    public override init() {
    }
    
    public convenience init(objects: UnsafePointer<AnyObject?>, forKeys keys: UnsafePointer<NSCopying?>, count cnt: Int) {
        self.init()
        orderedDict = NSDictionary(objects: objects, forKeys: keys, count: cnt)
        setUpArray()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(object: AnyObject, forKey key: NSCopying) {
        self.init()
        orderedDict = NSDictionary(object: object, forKey: key)
        setUpArray()
    }
    
    public convenience init(dictionary otherDictionary: [NSObject : AnyObject]) {
        self.init()
        orderedDict = NSDictionary(dictionary: otherDictionary)
        setUpArray()
    }
    
    public convenience init(dictionary otherDictionary: [NSObject : AnyObject], copyItems flag: Bool) {
        self.init()
        orderedDict = NSDictionary(dictionary: otherDictionary, copyItems: flag)
        setUpArray()
    }
    
    public convenience init(objects: [AnyObject], forKeys keys: [NSCopying]) {
        self.init()
        orderedDict = NSDictionary(objects: objects, forKeys: keys)
        array = NSArray(array: keys)
    }
    
    public convenience init?(contentsOfFile path: String) {
        self.init()
        orderedDict = NSDictionary(contentsOfFile: path)!
        setUpArray()
    }
    
    public convenience init?(contentsOfURL url: NSURL) {
        self.init()
        orderedDict = NSDictionary(contentsOfURL: url)
        setUpArray()
    }
    
    func setUpArray() {
        if(orderedDict != nil) {
            array = NSArray(array: orderedDict!.allKeys)
        }
    }

    public func objectForKey(aKey: AnyObject) -> AnyObject? {
        if(orderedDict == nil || orderedDict!.objectForKey(aKey) == nil) {
            return nil
        }
        return orderedDict!.objectForKey(aKey)
    }
    
    public override func valueForKey(key: String) -> AnyObject? {
        if(orderedDict == nil || orderedDict!.objectForKey(key) == nil) {
            return nil
        }
        return orderedDict!.objectForKey(key)
    }
    
    func containsObject(object: AnyObject) -> Bool{
        for currObject in orderedDict!.allValues {
            if (currObject.isEqual(object)) {
                return true
            }
        }
        return false
    }
    
    func containsKey(key: NSCopying) -> Bool {
        for currKey in orderedDict!.allKeys {
            if (currKey.isEqual(key)) {
                return true
            }
        }
        return false
    }
    
    func keyAtIndex(index: NSInteger) -> AnyObject {
        return array![index]
    }
    
    func indexForKey(key: NSCopying) -> NSInteger {
        return array!.indexOfObject(key)
    }
    
    func objectAtIndex(index: NSInteger) -> AnyObject? {
        return self.objectForKey(array![index])
    }
    
    public func keyEnumerator() -> NSEnumerator {
        return array!.objectEnumerator()
    }
    
    public var allKeys : [AnyObject]? {
        if(array == nil) {
            return nil
        }
        return array as? [AnyObject]
    }
    
    public var allValues : [AnyObject]? {
        if(orderedDict == nil) {
            return nil
        }
        return (orderedDict?.allValues)!
    }
    
    public var count : Int {
        if(array == nil) {
            return 0
        }
        return array!.count
    }
    
}


public class SVMutableSmartDictionary: SVSmartDictionary {
    
    var canHaveNillObjects = false
    
    NSOrderedSet()
    
    func checkForNull(var object: AnyObject?) -> AnyObject? {
        if(object == nil && canHaveNillObjects) {
            object = NSNull()
        }
        
        return object
    }
    
    public func setObject(anObject: AnyObject?, forKey aKey: NSCopying) {
        if(orderedDict != nil && orderedDict![aKey] == nil) {
            array.addObject(aKey)
        }
        
        orderedDict[aKey] = self.checkForNull(anObject)
    }
    
    override public func setValue(value: AnyObject?, forKey key: String) {
        if(orderedDict[key] == nil) {
            array.addObject(key)
        }
        
        orderedDict[key] = self.checkForNull(value)
    }
    
    override public func removeObjectForKey(aKey: AnyObject) {
        orderedDict.removeObjectForKey(aKey)
        array.removeObject(aKey)
    }
    
    override public func objectForKey(aKey: AnyObject) -> AnyObject? {
        if(orderedDict.objectForKey(aKey) == nil) {
            return nil
        }
        return orderedDict.objectForKey(aKey)
    }
    
    override public func valueForKey(key: String) -> AnyObject? {
        if(orderedDict[key]!.isKindOfClass(NSNull)) {
            return nil
        }
        return orderedDict[key]
    }
    
    func insert(object object: AnyObject?, forKey akey :NSCopying, var atIndex index: NSInteger? = nil) {
        if(index == nil) {
            index = array.count
        }
        
        if(orderedDict[akey] == nil) {
            array.insertObject(akey, atIndex: index!)
        }
        
        orderedDict.setObject(object!, forKey: akey)
    }
    
    func containsObject(object: AnyObject) -> Bool{
        for currObject in orderedDict.allValues {
            if (currObject.isEqual(object)) {
                return true
            }
        }
        return false
    }
    
    func containsKey(key: NSCopying) -> Bool {
        for currKey in orderedDict.allKeys {
            if (currKey.isEqual(key)) {
                return true
            }
        }
        return false
    }
    
    func removeObjectAtIndex(index : NSInteger) {
        self.removeObjectForKey(array[index])
    }
    
    func keyAtIndex(index: NSInteger) -> AnyObject {
        return array[index]
    }
    
    func indexForKey(key: NSCopying) -> NSInteger {
        return array.indexOfObject(key)
    }
    
    func objectAtIndex(index: NSInteger) -> AnyObject? {
        return self.objectForKey(array[index])
    }
    
    override public func keyEnumerator() -> NSEnumerator {
        return array.objectEnumerator()
    }
    
    override public var allKeys : [AnyObject] {
        return array as [AnyObject]
    }
    
    override public var count : Int {
        return array.count
    }
    
}
