// Playground - noun: a place where people can play

import Cocoa

var a : String? = nil
a == nil
!a
a = nil

NSSearchPathDirectory.DocumentDirectory
NSSearchPathDirectory.DocumentationDirectory

NSSearchPathDirectory.DocumentDirectory.hashValue
NSSearchPathDirectory.DocumentationDirectory.hashValue


NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)

urls.count
urls[urls.endIndex-1] as NSURL



