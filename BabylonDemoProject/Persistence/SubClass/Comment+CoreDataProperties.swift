//
//  Comment+CoreDataProperties.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 11/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//
//

import CoreData
import Foundation

extension Comment {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var comments: String
    @NSManaged public var postId: Int16
    @NSManaged public var commentId: Int16
}
