//
//  Customer.swift
//  VRWaivers
//
//  Created by Chris Slowik on 7/16/16.
//  Copyright © 2016 VRLab. All rights reserved.
//

import Foundation
import RealmSwift

class Customer: Object {
    
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var phoneNumber: String = ""
    dynamic var emailAddress: String = ""
    dynamic var signature: NSData? = nil
    
    static let current = Customer()
    
// Specify properties to ignore (Realm won't persist these)
    
  override static func ignoredProperties() -> [String] {
    return ["current"]
  }
}
