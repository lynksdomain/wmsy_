//
//  DBService+Get.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {
    
    
    
    // GET ALL WHIMS
    public func getAllWhims(completion: @escaping (_ whims: [Whim]) -> Void) {
        whimsRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            var whims: [Whim] = []
            
            guard let whimSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for whimSnapshot in whimSnapshots {
                guard let whimDict = whimSnapshot.value as? [String: Any] else { return }
                guard
                let id = whimDict["id"] as? String,
                let category = whimDict["category"] as? String,
                let title = whimDict["title"] as? String,
                let description = whimDict["description"] as? String,
                let hostID = whimDict["hostID"] as? String,
                let approxLocation = whimDict["approxLocation"] as? String,
                let location = whimDict["location"] as? String,
                let duration = whimDict["duration"] as? Int,
                let expiration = whimDict["expiration"] as? String,
                let finalized = whimDict["finalized"] as? Bool,
                let timestamp = whimDict["timestamp"] as? String
                    else {
                        print("Couldn't get post")
                        return
                }
                let whimChats = [Message]()
                let whim = Whim(id: id, category: category, title: title, description: description, hostID: hostID, approxLocation: approxLocation, location: location, duration: duration, expiration: expiration, finalized: finalized, timestamp: timestamp, whimChats: whimChats)
                whims.append(whim)
            }
            completion(whims.sortedByTimestamp())
        }
    
    }
    
    
    // GET SUBSET OF WHIMS BASED ON CATEGORY
    public func getCategoryWhims(fromCategory category: String, completion: @escaping ([Whim]) -> Void) {
        getAllWhims { (whims) in
            let categoryWhims = whims.filter{$0.category == category}
            completion(categoryWhims.sortedByTimestamp())
        }
    }
    
    
    
}
