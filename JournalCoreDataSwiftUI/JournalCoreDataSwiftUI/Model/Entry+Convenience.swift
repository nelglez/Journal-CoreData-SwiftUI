//
//  Entry+Convenience.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/10/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData

extension Entry {

   @discardableResult convenience init(title: String, timeStamp: Date = Date(), id: UUID = UUID(), entryDescription: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
       self.title = title
       self.timeStamp = timeStamp
       self.entryDescription = entryDescription
   }
}
