//
//  EditView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var entryController: EntryController
    @State var entry: Entry
    @State private var title = ""
    @Binding var description: String
    @State private var isShowingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
          
            VStack {
                TextField("\(entry.title ?? "No title.")", text: $title).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))//.textFieldStyle(RoundedBorderTextFieldStyle())

                MultiLineTextField(txt: $description).frame(height: 200).padding(.bottom)
                
                Button(action: {
                    if !self.title.isEmpty && !self.description.isEmpty {
                        self.entryController.updateEntry(entry: self.entry, title: self.title, entryDescription: self.description)
                        
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isShowingAlert = true
                    }
                }) {
                    Text("Save")
                }.frame(width: 90).padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).shadow(color: Color.gray, radius: 5)
                Spacer()
            }.onAppear {
                self.title = self.entry.title!
                self.description = self.entry.entryDescription!
            }.padding().navigationBarTitle("Edit entry", displayMode: .inline).alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Warning"), message: Text("Please make sure both the title and the description aren't empty!"), dismissButton: .default(Text("OK!")))
            }
            
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(entryController: EntryController(), entry: Entry(title: "Test", entryDescription: "Testing..."), description: .constant("Testing..."))
    }
}
