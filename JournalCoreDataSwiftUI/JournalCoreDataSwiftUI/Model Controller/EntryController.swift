//
//  EntryController.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/10/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData
import Combine

class EntryController: ObservableObject {

   // MARK: - Properties
   // all computed properties have to return something!
   @Published var entries: [Entry] = []
   
   init() {
       getEntries()
   }
   
    
   func saveToPersistentStore() {
       let moc = CoreDataStack.shared.mainContext
       do {
           try moc.save()
           getEntries()
        
       } catch {
           NSLog("Error saving managed object context: \(error)")
       }
   }
   
   func getEntries() {
       let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
       let moc = CoreDataStack.shared.mainContext

       do {
           entries = try moc.fetch(fetchRequest)
            
       } catch {
           NSLog("Error fetching tasks: \(error)")

       }
   }

   // MARK: - CRUD Methods

   // Create
   func createEntry(title: String, entryDescription: String) {
       _ = Entry(title: title, entryDescription: entryDescription)
       saveToPersistentStore()
   }

   // Read

   // Update
   func updateEntry(entry: Entry, title: String, entryDescription: String) {
       entry.title = title
       entry.entryDescription = entryDescription
    
       saveToPersistentStore()
   }

   // Delete
   func deleteEntry(entry: Entry) {
       let mainC = CoreDataStack.shared.mainContext
       mainC.delete(entry)
       saveToPersistentStore()    }
    
    func deleteEntry(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        
        let entry = self.entries[index]
        
        deleteEntry(entry: entry)
        
    }


}

