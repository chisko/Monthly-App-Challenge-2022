//
//  FilmDetailView.swift
//  StarWarsEnciclopedia
//
//  Created by Francisco Ruiz on 06/02/22.
//

import SwiftUI
/*
 It is a period of civil war.
 Rebel spaceships, striking
 from a hidden base, have won
 their first victory against
 the evil Galactic Empire.
 
 During the battle, Rebel
 spies managed to steal secret
 plans to the Empire's
 ultimate weapon, the DEATH
 STAR, an armored space
 station with enough power
 to destroy an entire planet.
 
 Pursued by the Empire's
 sinister agents, Princess
 Leia races home aboard her
 starship, custodian of the
 stolen plans that can save her
 people and restore
 freedom to the galaxy....
 */

struct FilmDetailView: View {
    let film: Film
    
    @State private var animationStart = false
    //@State private var animationEnd = false
    
    private let startAnimationDuration = 30.0
    //private let endAnimationDuration = 1.5
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center) {
                Spacer()
                
                Text("\(film.opening_crawl)\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .lineSpacing(10)
                    //.fixedSize(horizontal: false, vertical: true)
                    //.padding(.horizontal, 50)
                    .rotation3DEffect(.degrees(60), axis: (x: 2, y: 0, z: 0))
                    //.scaleEffect(animationStart ? 1 : 5)
                    .shadow(color: .gray, radius: 2, x: 0, y: 10)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: animationStart ? 650 : 0)
                    
                    
                    //.rotation3DEffect(.degrees(60), axis: (x: 0, y: 0, z: animationStart ? 750 : 0))
                    //.background(Color.red)
                    //.animation(Animation.linear(duration: startAnimationDuration))
            }
            .frame(maxWidth: .infinity)
            //.background(Color.blue)
            /*
            VStack(alignment: .leading) {
                Text(film.title)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
             */
        }
        .navigationTitle("Episode \(film.episode_id)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            withAnimation(.linear(duration: startAnimationDuration)) {
                self.animationStart.toggle()
            }
        }
    }
}
/*
struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView()
    }
}
*/
