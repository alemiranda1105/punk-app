//
//  MockData.swift
//  Punk App
//
//  Created by Alejandro Miranda on 20/10/22.
//

import Foundation

let mockBeer = Beer(id: 1,
                    name: "Test",
                    tagline: "A Real Bitter Experience",
                    first_brewed: "09/2007",
                    description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                    image_url: "https://images.punkapi.com/v2/keg.png",
                    abv: 4.5,
                    ibu: 60,
                    target_fg: 1010,
                    target_og: 1044,
                    ebc: 20,
                    srm: 10,
                    ph: 4.4,
                    attenuation_level: 75,
                    volume: MeasureUnit(value: 20, unit: "litres"),
                    boil_volume: MeasureUnit(value: 25, unit: "litres"),
                    method: Method(
                        mash_temp: [MashTemp(
                            temp: MeasureUnit(
                                value: 64,
                                unit: "celsius"),
                            duration: 75)],
                        fermentation: Fermentation(
                            temp: MeasureUnit(
                                value: 19,
                                unit: "celsius")),
                            twist: ""),
                    ingredients: Ingredients(
                        malt: [Malt(name: "Maris Otter Extra Pale", amount: MeasureUnit(value: 3.3, unit: "kilograms"))],
                        hops: [Hop(name: "Fuggles", amount: MeasureUnit(value: 25, unit: "grams"), add: "start", attribute: "bitter")],
                        yeast: "Wyeast 1056 - American Ale™"),
                        food_pairing: ["Spicy chicken tikka masala"],
                        brewers_tips: "The earthy and floral aromas from the hops can be overpowering. Drop a little Cascade in at the end of the boil to lift the profile with a bit of citrus.",
                        contributed_by: "Sam Mason <samjbmason>"
                    )

