//
//  ContentView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/10/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   // @Environment(\.managedObjectContext) var moc
  //  @FetchRequest(entity: Entry.entity(), sortDescriptors: []) var entries: FetchedResults<Entry>
    @ObservedObject var entryController = EntryController()
    @State private var showing: Bool = false
    
    
    var body: some View {
        NavigationView {
            List {
            ForEach(entryController.entries, id: \.id) { entry in
                NavigationLink(destination: DetailView(entryController: self.entryController, entry: entry)) {
                RowView(entry: entry)
                }
            }.onDelete(perform: self.entryController.deleteEntry)
                
            }.navigationBarTitle("Journal Entries").navigationBarItems(trailing: Button(action: {
            self.showing = true
        }, label: {
            Image(systemName: "plus.circle").font(.largeTitle).foregroundColor(.green)
        }).sheet(isPresented: $showing, content: {
            AddEntryView(entryController: self.entryController)
                }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
