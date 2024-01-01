//
//  Event+Samples.swift
//  Intra42
//
//  Created by Marc Mosca on 01/01/2024.
//

import Foundation

extension Api.Types.Event
{
    
    static let sample = Self.init(
        id: 10637,
        name: "CodinGame Challenge - Green Circle",
        description: "Nouveau challenge CodinGame !\r\n\r\nVenez représenter l\'école sur le [**Green Circle**](https://www.codingame.com/contests/green-circle) !\r\n\r\n\r\nVoici les récompenses que vous et votre coalition aurez :\r\n- Ligue Bois 2 : 10 points de coalition\r\n- Ligue Bois 1 : 20 points de coalition\r\n- Ligue Bronze : 200 points de coalition\r\n- Ligue Argent : 400 points de coalition et 10 jours de BH\r\n- Ligue Or : 1000 points de coalition, 10 jours de BH et le titre CodinGame Challenger %login\r\n- Ligue Légende : 2000 points de coalition, 10 jours de BH et le titre CodinGame Challenger %login\r\n- Top 1000 : 10 wallets et 200 points de coalition\r\n- Top 100 : 40 wallets et 2000 points de coalition\r\n- Top 10 : 100 wallets et 8400 points de coalition\r\n- Top 5 42 Lyon : 20 wallets et 6000 points de coalition\r\n- Vainqueur 42 Lyon : 100 wallets et 8400 points de coalition\r\n- Top 10 Entreprises : 60 wallets et 6000 points de coalition\r\n- Coalition 1 : 100 points de coalition par participant\r\n- Coalition 2 : 200 points de coalition par participant\r\n- Coalition 3 : 300 points de coalition par participant\r\n\r\n\r\nBon courage !\r\n\r\n\r\n![](https://static.codingame.com/servlet/fileservlet?id=85384465362472)",
        location: "Z4",
        kind: "challenge",
        maxPeople: nil,
        nbrSubscribers: 44,
        beginAt: .now,
        endAt: .now
    )
    
}

extension [Api.Types.Event]
{
    
    static let sample: Self = [
        .init(id: 10637, name: "CodinGame Challenge - Green Circle", description: "Nouveau challenge CodinGame !\r\n\r\nVenez représenter l\'école sur le [**Green Circle**](https://www.codingame.com/contests/green-circle) !\r\n\r\n\r\nVoici les récompenses que vous et votre coalition aurez :\r\n- Ligue Bois 2 : 10 points de coalition\r\n- Ligue Bois 1 : 20 points de coalition\r\n- Ligue Bronze : 200 points de coalition\r\n- Ligue Argent : 400 points de coalition et 10 jours de BH\r\n- Ligue Or : 1000 points de coalition, 10 jours de BH et le titre CodinGame Challenger %login\r\n- Ligue Légende : 2000 points de coalition, 10 jours de BH et le titre CodinGame Challenger %login\r\n- Top 1000 : 10 wallets et 200 points de coalition\r\n- Top 100 : 40 wallets et 2000 points de coalition\r\n- Top 10 : 100 wallets et 8400 points de coalition\r\n- Top 5 42 Lyon : 20 wallets et 6000 points de coalition\r\n- Vainqueur 42 Lyon : 100 wallets et 8400 points de coalition\r\n- Top 10 Entreprises : 60 wallets et 6000 points de coalition\r\n- Coalition 1 : 100 points de coalition par participant\r\n- Coalition 2 : 200 points de coalition par participant\r\n- Coalition 3 : 300 points de coalition par participant\r\n\r\n\r\nBon courage !\r\n\r\n\r\n![](https://static.codingame.com/servlet/fileservlet?id=85384465362472)", location: "Z4", kind: "challenge", maxPeople: nil, nbrSubscribers: 44, beginAt: .now, endAt: .now),
        .init(id: 9764, name: "Boost Ft_containers", description: "Les tuteurs vous proposent de se rejoindre en Z4 pour travailler sur ft_containers. Tout le monde est bienvenue pour soit apporter son expérience sur le projet, soit bosser dessus !", location: "Z4", kind: "challenge", maxPeople: 45, nbrSubscribers: 6, beginAt: .now, endAt: .now),
        .init(id: 9408, name: "Session peer2peer", description: "Session P2P : 2 heures d\'entraide, de bonne humeur et de rencontre vendredi 25 mars.\r\nLes intérêts du format :\r\n- avancer sur son projet avec l\'aide de quelqu\'un\r\n- recevoir 1 heure de log\r\n- rencontrer des étudiants de différentes promotions\r\n- gagner 1 point de correction\r\n- gagner des points de coalition", location: "Z4", kind: "workshop", maxPeople: 90, nbrSubscribers: 10, beginAt: .now, endAt: .now)
    ]
    
}
