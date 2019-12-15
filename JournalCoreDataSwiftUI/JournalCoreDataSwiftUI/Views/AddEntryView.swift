//
//  AddEntryView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct AddEntryView: View {
    @ObservedObject var entryController: EntryController
    @State private var title = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert = false
   
    
    var body: some View {
        NavigationView {
            Form {
        VStack {
            TextField("Entry title...", text: $title).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))//.textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Entry description...", text: $description).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
            Button(action: {
                if !self.title.isEmpty && !self.description.isEmpty {
                self.entryController.createEntry(title: self.title, entryDescription: self.description)
                    self.title = ""
                    self.description = ""
                                  
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.isShowingAlert = true
                }
                  
            }) {
                Text("Add Entry")
                }.padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).shadow(color: Color.gray, radius: 5)
            Spacer()
        }.padding().navigationBarTitle("Add Entry", displayMode: .inline).alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Warning"), message: Text("Please make sure both the title and the description aren't empty!"), dismissButton: .default(Text("OK!")))
            }
            }
    }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView(entryController: EntryController())
    }
}
