//
//  User+CoreDataProperties.swift
//  CKCC
//
//  Created by Bun Leap on 5/24/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?

}
