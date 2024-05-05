//
//  Berries.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct Berries: Codable {
    var id: Int
    var name: String
    var growthTime: Int
    var maxHarvest: Int
    var naturalGiftPower: Int
    var size: Int
    var smoothness: Int
    var soilDryness: Int
    var firmness: BerryFirmness
    var flavors: BerryFlavorMap
    var item: NamedAPIResource
    var naturalGiftType: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case growthTime = "growth_time"
        case maxHarvest = "max_harvest"
        case naturalGiftPower = "natural_gift_power"
        case size, smoothness
        case soilDryness = "soil_dryness"
        case firmness, flavors, item
        case naturalGiftType = "natural_gift_type"
    }
}
