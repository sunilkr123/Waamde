//
//  HomeModel.swift
//  Waamde
//
//  Created by Apple on 05/03/21.
//

import Foundation

class HomeModel:Codable {
    var sliders : [SliderModel]?
    var homeData : [HomeData]?
}

class HomeData : Codable {
    var categoryName : String?
    var categoryImage : String?
    var products : [ProductModel]?
}

class SliderModel : Codable {
    let id : String?
    let subtitle_text : String?
    let subtitle_size : String?
    let subtitle_color : String?
    let subtitle_anime : String?
    let title_text : String?
    let title_size : String?
    let title_color : String?
    let title_anime : String?
    let details_text : String?
    let details_size : String?
    let details_color : String?
    let details_anime : String?
    let photo : String?
    let position : String?
    let link : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case subtitle_text = "subtitle_text"
        case subtitle_size = "subtitle_size"
        case subtitle_color = "subtitle_color"
        case subtitle_anime = "subtitle_anime"
        case title_text = "title_text"
        case title_size = "title_size"
        case title_color = "title_color"
        case title_anime = "title_anime"
        case details_text = "details_text"
        case details_size = "details_size"
        case details_color = "details_color"
        case details_anime = "details_anime"
        case photo = "photo"
        case position = "position"
        case link = "link"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        subtitle_text = try values.decodeIfPresent(String.self, forKey: .subtitle_text)
        subtitle_size = try values.decodeIfPresent(String.self, forKey: .subtitle_size)
        subtitle_color = try values.decodeIfPresent(String.self, forKey: .subtitle_color)
        subtitle_anime = try values.decodeIfPresent(String.self, forKey: .subtitle_anime)
        title_text = try values.decodeIfPresent(String.self, forKey: .title_text)
        title_size = try values.decodeIfPresent(String.self, forKey: .title_size)
        title_color = try values.decodeIfPresent(String.self, forKey: .title_color)
        title_anime = try values.decodeIfPresent(String.self, forKey: .title_anime)
        details_text = try values.decodeIfPresent(String.self, forKey: .details_text)
        details_size = try values.decodeIfPresent(String.self, forKey: .details_size)
        details_color = try values.decodeIfPresent(String.self, forKey: .details_color)
        details_anime = try values.decodeIfPresent(String.self, forKey: .details_anime)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }

}
