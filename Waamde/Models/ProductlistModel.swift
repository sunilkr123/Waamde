

import Foundation
struct ProductlistModel : Decodable {
    let id : Int?
    let sku : String?
    let product_type : String?
    let affiliate_link : String?
    let user_id : String?
    let category_id : String?
    let subcategory_id : String?
    let childcategory_id : String?
    let attributes : String?
    let name : String?
    let slug : String?
    let photo : String?
    let thumbnail : String?
    let file : String?
    let size : [String]?
    let size_qty : [String]?
    let size_price : [String]?
    let color : [String]?
    let price : String?
    let previous_price : String?
    let details : String?
    let stock : String?
    let policy : String?
    let status : String?
    let views : String?
    let tags : [String]?
    let features : [String]?
    let colors : [String]?
    let product_condition : String?
    let ship : String?
    let is_meta : String?
    let meta_tag : [String]?
    let meta_description : String?
    let youtube : String?
    let type : String?
    let license : [String]?
    let license_qty : [String]?
    let link : String?
    let platform : String?
    let region : String?
    let licence_type : String?
    let measure : String?
    let featured : String?
    let best : String?
    let top : String?
    let hot : String?
    let latest : String?
    let big : String?
    let trending : String?
    let sale : String?
    let created_at : String?
    let updated_at : String?
    let is_discount : String?
    let discount_date : String?
    let whole_sell_qty : [String]?
    let whole_sell_discount : [String]?
    let is_catalog : String?
    let catalog_id : String?
    let wish_list: Int?
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case sku = "sku"
        case product_type = "product_type"
        case affiliate_link = "affiliate_link"
        case user_id = "user_id"
        case category_id = "category_id"
        case subcategory_id = "subcategory_id"
        case childcategory_id = "childcategory_id"
        case attributes = "attributes"
        case name = "name"
        case slug = "slug"
        case photo = "photo"
        case thumbnail = "thumbnail"
        case file = "file"
        case size = "size"
        case size_qty = "size_qty"
        case size_price = "size_price"
        case color = "color"
        case price = "price"
        case previous_price = "previous_price"
        case details = "details"
        case stock = "stock"
        case policy = "policy"
        case status = "status"
        case views = "views"
        case tags = "tags"
        case features = "features"
        case colors = "colors"
        case product_condition = "product_condition"
        case ship = "ship"
        case is_meta = "is_meta"
        case meta_tag = "meta_tag"
        case meta_description = "meta_description"
        case youtube = "youtube"
        case type = "type"
        case license = "license"
        case license_qty = "license_qty"
        case link = "link"
        case platform = "platform"
        case region = "region"
        case licence_type = "licence_type"
        case measure = "measure"
        case featured = "featured"
        case best = "best"
        case top = "top"
        case hot = "hot"
        case latest = "latest"
        case big = "big"
        case trending = "trending"
        case sale = "sale"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case is_discount = "is_discount"
        case discount_date = "discount_date"
        case whole_sell_qty = "whole_sell_qty"
        case whole_sell_discount = "whole_sell_discount"
        case is_catalog = "is_catalog"
        case catalog_id = "catalog_id"
        case wish_list = "wish_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        product_type = try values.decodeIfPresent(String.self, forKey: .product_type)
        affiliate_link = try values.decodeIfPresent(String.self, forKey: .affiliate_link)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        subcategory_id = try values.decodeIfPresent(String.self, forKey: .subcategory_id)
        childcategory_id = try values.decodeIfPresent(String.self, forKey: .childcategory_id)
        attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        size = try values.decodeIfPresent([String].self, forKey: .size)
        size_qty = try values.decodeIfPresent([String].self, forKey: .size_qty)
        size_price = try values.decodeIfPresent([String].self, forKey: .size_price)
        color = try? values.decodeIfPresent([String].self, forKey: .color)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        previous_price = try values.decodeIfPresent(String.self, forKey: .previous_price)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
        policy = try values.decodeIfPresent(String.self, forKey: .policy)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        views = try? values.decodeIfPresent(String.self, forKey: .views)
        tags = try? values.decodeIfPresent([String].self, forKey: .tags)
        features = try values.decodeIfPresent([String].self, forKey: .features)
        colors = try values.decodeIfPresent([String].self, forKey: .colors)
        product_condition = try values.decodeIfPresent(String.self, forKey: .product_condition)
        ship = try values.decodeIfPresent(String.self, forKey: .ship)
        is_meta = try values.decodeIfPresent(String.self, forKey: .is_meta)
        meta_tag = try values.decodeIfPresent([String].self, forKey: .meta_tag)
        meta_description = try values.decodeIfPresent(String.self, forKey: .meta_description)
        youtube = try values.decodeIfPresent(String.self, forKey: .youtube)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        license = try values.decodeIfPresent([String].self, forKey: .license)
        license_qty = try values.decodeIfPresent([String].self, forKey: .license_qty)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        platform = try values.decodeIfPresent(String.self, forKey: .platform)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        licence_type = try values.decodeIfPresent(String.self, forKey: .licence_type)
        measure = try values.decodeIfPresent(String.self, forKey: .measure)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        best = try values.decodeIfPresent(String.self, forKey: .best)
        top = try values.decodeIfPresent(String.self, forKey: .top)
        hot = try values.decodeIfPresent(String.self, forKey: .hot)
        latest = try values.decodeIfPresent(String.self, forKey: .latest)
        big = try values.decodeIfPresent(String.self, forKey: .big)
        trending = try values.decodeIfPresent(String.self, forKey: .trending)
        sale = try values.decodeIfPresent(String.self, forKey: .sale)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        is_discount = try? values.decodeIfPresent(String.self, forKey: .is_discount)
        discount_date = try values.decodeIfPresent(String.self, forKey: .discount_date)
        whole_sell_qty = try values.decodeIfPresent([String].self, forKey: .whole_sell_qty)
        whole_sell_discount = try values.decodeIfPresent([String].self, forKey: .whole_sell_discount)
        is_catalog = try values.decodeIfPresent(String.self, forKey: .is_catalog)
        catalog_id = try values.decodeIfPresent(String.self, forKey: .catalog_id)
        wish_list = try values.decodeIfPresent(Int.self, forKey: .wish_list)
    }

}
