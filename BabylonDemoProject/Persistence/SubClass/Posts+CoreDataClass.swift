//
//  Title+CoreDataClass.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 11/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//
//

import CoreData
import Foundation

@objc(Posts)
public class Posts: NSManagedObject {}

extension Posts {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }
    
    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var postId: Int16
    @NSManaged public var userID: Int16
}
