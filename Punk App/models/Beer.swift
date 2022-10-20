import Foundation

// MARK: - BeeerElement
struct Beer: Decodable {
    let id: Int
    let name, tagline, first_brewed, description: String
    let image_url: String
    let abv, ibu, target_fg, target_og: Double?
    let ebc: Int?
    let srm, ph, attenuation_level: Double?
    let volume, boil_volume: MeasureUnit?
    let method: Method?
    let ingredients: Ingredients?
    let food_pairing: [String]?
    let brewers_tips, contributed_by: String?
}

// MARK: - BoilVolume
struct MeasureUnit: Decodable {
    let value: Double?
    let unit: String?
}

// MARK: - Ingredients
struct Ingredients: Decodable {
    let malt: [Malt]?
    let hops: [Hop]?
    let yeast: String?
}

// MARK: - Hop
struct Hop: Decodable {
    let name: String?
    let amount: MeasureUnit?
    let add, attribute: String?
}

// MARK: - Malt
struct Malt: Decodable {
    let name: String?
    let amount: MeasureUnit?
}

// MARK: - Method
struct Method: Decodable {
    let mash_temp: [MashTemp]?
    let fermentation: Fermentation?
    let twist: String?
}

// MARK: - Fermentation
struct Fermentation: Decodable {
    let temp: MeasureUnit?
}

// MARK: - MashTemp
struct MashTemp: Decodable {
    let temp: MeasureUnit?
    let duration: Int?
}
