//
//  RowView.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct RowView: View {
    
    @ObservedObject var entry: Entry
   
    var timeFormatter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let dateString = formatter.string(from: entry.timeStamp ?? Date())
        
        let returnString = "\(dateString)"
        return returnString
    }
    
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.white).frame(width: UIScreen.main.bounds.width - 32, height: 100).cornerRadius(10).shadow(color: .gray, radius: 4)
        VStack(alignment: .leading) {
        HStack {
            Text(entry.title ?? "There is no title")
            Spacer()
            Text(timeFormatter)

        }.padding(.bottom)
            Text(entry.entryDescription ?? "No description").font(.title)
        }.padding()
    
        }
        
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(entry: Entry(title: "Test", entryDescription: "This is a test"))
    }
}
