//
//  MiscFuncs.swift
//  Music Player
//
//  Created by Sem on 9/13/15.
//  Copyright (c) 2015 Sem. All rights reserved.
//

import Foundation
public class MiscFuncs{
    
    //convert double to format : hh:mm:ss
    public class func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    //convert double to format : xh xm
    public class func hrsAndMinutes(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02dh %02dm", hours, minutes)
    }
    
    //shuffle int array
    public class func shuffle<C: MutableCollectionType where C.Index == Int>(inout list: C) {
            let c = list.count
            for i in 0..<(c - 1) {
                let j = Int(arc4random_uniform(UInt32(c - i))) + i
                if (i != j){
                    swap(&list[i], &list[j])
                }
            }
        
    }
    
    //delay execution, taken from : http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
    public class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    public class func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    //get id of youtube url
    public class func parseID(url : String) -> String{
        
        if let index = url.characters.indexOf("=") {
            return url.substringFromIndex(index.advancedBy(1))
        }

        let ndx = url.rangeOfString("youtu.be/",
            options: NSStringCompareOptions.LiteralSearch,
            range: url.startIndex..<url.endIndex,
            locale: nil)
        
        if let range = ndx {
            return url[range.startIndex.advancedBy(9)..<url.endIndex]
        }
        
        return url
    }
    
    
    public class func parseIDs(url url: String) -> (videoId: String?, playlistId: String?) {

        var videoId: String? = nil
        var playlistId: String? = nil

        if let url: NSURL = NSURL(string: url) {
            if let comp = NSURLComponents(URL: url, resolvingAgainstBaseURL: true) {
                if let queryItems = comp.queryItems {
                    queryItems.forEach { item in
                        switch item.name {
                        case "list": playlistId = item.value
                        case "v"   : videoId    = item.value
                        default    : break
                        }
                    }
                }
            }
        }

        return (videoId: videoId, playlistId: playlistId)
    }

}













