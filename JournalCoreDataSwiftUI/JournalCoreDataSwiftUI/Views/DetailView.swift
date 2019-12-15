//
//  DetailView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var entryController: EntryController
    @State var entry: Entry
    @State var entryDescription = ""
    
    var timeFormatter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let dateString = formatter.string(from: entry.timeStamp ?? Date())
        
        let returnString = "\(dateString)"
        return returnString
    }
    
    @State private var showing: Bool = false
    
    var body: some View {
        NavigationView {
           
            VStack {
                HStack {
                    Text(entry.title ?? "There is no title")
                    Spacer()
                    Text(timeFormatter).font(.footnote)
                    
                }.padding(.bottom)
                Text(entry.entryDescription ?? "No description").font(.title).padding()
                
               
                    Button(action: {
                        self.showing = true
                    }) {
                        Text("Edit")
                    }.frame(width: 90).padding().background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white).shadow(color: Color.gray, radius: 5).sheet(isPresented: $showing) {
                        EditView(entryController: self.entryController, entry: self.entry, description: self.$entryDescription)
                        
                }
                
               
                Spacer()
                }.padding().background(Color(red: 239/255, green: 243/255, blue: 244/255)).onAppear {
                self.entryDescription = self.entry.entryDescription ?? ""
            }.navigationBarTitle(Text(entry.title ?? "There is no title."), displayMode: .inline)
        
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(entryController: EntryController(), entry: Entry(title: "Test", entryDescription: "Testing description"))
    }
}
