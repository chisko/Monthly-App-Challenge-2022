//
//  PeopleDetailView.swift
//  StarWarsEnciclopedia
//
//  Created by Francisco Ruiz on 04/02/22.
//

import SwiftUI

struct PeopleDetailView: View {
    let person: People
    
    @StateObject var films = Films()
    @StateObject var species = Species()
    @StateObject var vehicles = Vehicles()
    @StateObject var starships = Starships()
    
    var body: some View {
        ScrollView {
            ZStack {
                Image("people\(person.number)")
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 300, alignment: .top)
                    .clipped()
                
                VStack {
                    Spacer()
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text(person.name)
                            .font(.title2)
                        
                        Spacer()
                        
                        Text(person.birth_year)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                }
            }
            .frame(height: 300)
            
            VStack(alignment: .leading) {
                Group {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ZStack {
                                VStack {
                                    Text("Gender")
                                        .font(.caption)
                                    
                                    Text(person.gender)
                                        .font(.headline)
                                }
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            
                            ZStack {
                                VStack {
                                    Text("Height")
                                        .font(.caption)
                                    
                                    Text(person.height)
                                        .font(.headline)
                                }
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            
                            ZStack {
                                VStack {
                                    Text("Mass")
                                        .font(.caption)
                                    
                                    Text(person.mass)
                                        .font(.headline)
                                }
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            
                            ZStack {
                                VStack {
                                    Text("Hair")
                                        .font(.caption)
                                    
                                    Text(person.hair_color)
                                        .font(.headline)
                                }
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            
                            ZStack {
                                VStack {
                                    Text("Skin")
                                        .font(.caption)
                                    
                                    Text(person.skin_color)
                                        .font(.headline)
                                }
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            
                            ZStack {
                                VStack {
                                    Text("Eyes")
                                        .font(.caption)
                                    
                                    Text(person.eye_color)
                                        .font(.headline)
                                }
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                }
                
                Group {
                    Text("Films")
                        .font(.title2)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(films.films, id: \.title) { film in
                                ZStack {
                                    NavigationLink {
                                        FilmDetailView(film: film)
                                    } label: {
                                        Image("film\(film.episode_id)")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 150)
                                    }
                                    
                                    VStack {
                                        Spacer()
                                        
                                        Text(film.title)
                                            .font(.caption)
                                            .padding(2)
                                            .frame(maxWidth: .infinity)
                                            .background(.regularMaterial)
                                    }
                                }
                                .frame(width: 100, height: 150)
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                
                Group {
                    Text("Species")
                        .font(.title2)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if species.species.isEmpty {
                                ZStack {
                                    VStack {
                                        Spacer()
                                        
                                        Text("Unknown")
                                            .font(.caption)
                                            .padding(2)
                                            .frame(maxWidth: .infinity)
                                            .background(.regularMaterial)
                                    }
                                }
                                .frame(width: 100, height: 150)
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(10)
                            }
                            ForEach(species.species, id: \.name) { specie in
                                ZStack {
                                    Image("specie\(specie.number)")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 150)
                                    
                                    VStack {
                                        Spacer()
                                        
                                        Text(specie.name)
                                            .font(.caption)
                                            .padding(2)
                                            .frame(maxWidth: .infinity)
                                            .background(.regularMaterial)
                                    }
                                }
                                .frame(width: 100, height: 150)
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                
                Group {
                    Text("Vehicles")
                        .font(.title2)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(vehicles.vehicles, id: \.name) { specie in
                                ZStack {
                                    Image("vehicle\(specie.number)")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 150)
                                    
                                    VStack {
                                        Spacer()
                                        
                                        Text(specie.name)
                                            .font(.caption)
                                            .padding(2)
                                            .frame(maxWidth: .infinity)
                                            .background(.regularMaterial)
                                    }
                                }
                                .frame(width: 100, height: 150)
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                
                Group {
                    Text("Starships")
                        .font(.title2)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(starships.starships, id: \.name) { starship in
                                ZStack {
                                    Image("starship\(starship.number)")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 150)
                                    
                                    VStack {
                                        Spacer()
                                        
                                        Text(starship.name)
                                            .font(.caption)
                                            .padding(2)
                                            .frame(maxWidth: .infinity)
                                            .background(.regularMaterial)
                                    }
                                }
                                .frame(width: 100, height: 150)
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            Task {
                if films.films.isEmpty { await films.loadFilms(urls: person.films) }
                if species.species.isEmpty { await species.loadSpecies(urls: person.species) }
                if vehicles.vehicles.isEmpty { await vehicles.loadVehicles(urls: person.vehicles) }
                if starships.starships.isEmpty { await starships.loadStarships(urls: person.starships) }
            }
        }
    }
}

/*
struct PeopleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetailView()
    }
}
*/
