//
//  ContentView.swift
//  Shared
//
//  Created by Francisco Ruiz on 03/02/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var peopleResponse: PeopleRes
    
    @State private var search = ""
    /*
    var filteredPeople: [People] {
        if search.isEmpty {
            return peopleResponse.people
        } else {
            return peopleResponse.people.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
    }
    */
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(peopleResponse.people, id: \.name) { person in
                        NavigationLink {
                            PeopleDetailView(person: person)
                        } label: {
                            HStack {
                                VStack {
                                    Image("people\(person.number)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 75)
                                        .frame(maxWidth: 50)
                                        .cornerRadius(10)
                                }
                                .frame(width: 75)
                                
                                    
                                
                                Text(person.name)
                            }
                            
                        }
                    }
                }
                
                Section {
                    Text("\(peopleResponse.count) \(peopleResponse.count > 1 ? "people" : "person" )")
                }
            }
            .searchable(text: $search, prompt: "Search...")
            .onSubmit(of: .search) {
                print("search submit")
                Task {
                    await peopleResponse.search(search)
                }
            }
            .onChange(of: search, perform: { _ in
                if search.isEmpty {
                    Task {
                        await peopleResponse.clearSearch()
                    }
                }
            })
            .navigationBarTitle("Star Wars")
            .navigationBarItems(
                leading:
                    HStack {
                        Button {
                            Task {
                                await self.peopleResponse.previosPage()
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        .disabled(peopleResponse.disablePrevious)
                    },
                trailing:
                    HStack {
                        Button {
                            Task {
                                await self.peopleResponse.nextPage()
                            }
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                        .disabled(peopleResponse.disableNext)
                    }
            )
        }
        .task {
            await peopleResponse.loadPeople()
        }
    }
    
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
