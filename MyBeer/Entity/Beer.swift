//
//  Beer.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import Foundation

struct Beer: Codable, Equatable, Identifiable, Hashable {
    let id: Int
    let name, tagline, firstBrewed, beerDescription: String
    let imageURL: String?
    let abv: Double
    let ibu: Double?
    let targetFg: Int?
    let targetOg: Double?
    let ebc, srm, ph: Double?
    let attenuationLevel: Double?
    let volume, boilVolume: BoilVolume
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case beerDescription = "description"
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable, Equatable, Hashable {
    let value: Double?
    let unit: String
}

// MARK: - Ingredients
struct Ingredients: Codable, Equatable, Hashable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String?
}

// MARK: - Hop
struct Hop: Codable, Equatable, Hashable {
    let name: String
    let amount: BoilVolume
    let add: String
    let attribute: String
}

// MARK: - Malt
struct Malt: Codable, Equatable, Hashable {
    let name: String
    let amount: BoilVolume
}

// MARK: - Method
struct Method: Codable, Equatable, Hashable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

// MARK: - Fermentation
struct Fermentation: Codable, Equatable, Hashable {
    let temp: BoilVolume
}

// MARK: - MashTemp
struct MashTemp: Codable, Equatable, Hashable {
    let temp: BoilVolume
    let duration: Int?
}
