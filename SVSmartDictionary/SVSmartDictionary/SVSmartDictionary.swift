//
//  OrderedDictionary.swift
//  ZohoBooks
//
//  Created by shobhan.vijay on 3/8/16.
//  Copyright © 2016 Zoho. All rights reserved.
//

import Foundation

class SVSmartDictionary: NSMutableDictionary {
    
    var orderedDict = NSMutableDictionary()
    var array = NSMutableArray()
    var canHaveNillObjects = false
    
    
    func checkForNull(var object: AnyObject?) -> AnyObject? {
        if(object == nil && canHaveNillObjects) {
            object = NSNull()
        }
        
        return object
    }

    override func setObject(anObject: AnyObject?, forKey aKey: NSCopying) {
        if(orderedDict[aKey] == nil) {
            array.addObject(aKey)
        }
        
        orderedDict[aKey] = self.checkForNull(anObject)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if(orderedDict[key] == nil) {
            array.addObject(key)
        }
        
        orderedDict[key] = self.checkForNull(value)
    }
    
    override func removeObjectForKey(aKey: AnyObject) {
        orderedDict.removeObjectForKey(aKey)
        array.removeObject(aKey)
    }
    
    override func objectForKey(aKey: AnyObject) -> AnyObject? {
        if(orderedDict.objectForKey(aKey) == nil) {
            return nil
        }
        return orderedDict.objectForKey(aKey)
    }
    
    override func valueForKey(key: String) -> AnyObject? {
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
    
    override func keyEnumerator() -> NSEnumerator {
        return array.objectEnumerator()
    }
    
    override var allKeys : [AnyObject] {
        return array as [AnyObject]
    }
    
    override var count : Int {
        return array.count
    }

}
