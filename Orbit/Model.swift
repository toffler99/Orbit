//
//  Model.swift
//  Orbit
//
//  Created by ilhan won on 2018. 8. 30..
//  Copyright © 2018년 orbit. All rights reserved.
//

import UIKit

struct Model {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
}

extension Model {
    
    struct Contents {
        var createdAt : Date?
        var title : String?
        var weather : String?
        var content : String?
        var image : Data?
    }
    struct User {
        var id : UUID
        var contents : [Model.Contents]
    }
}

//extension Model {
//    mutating func saveData(createdAt : Date, title : String, weather : String, content : String, image : Data) {
//        
//       let data =  Model.Contents(createdAt: createdAt, title: title, weather: weather, content: content, image: image)
//       
//    }
//}

extension Model {
//    struct Weather: Codable {
//
//        var response: Response
//
//        struct Response: Codable {
//
//            var body: Body
//
//            struct Body: Codable {
//
//                var items: Items
//
//                struct Items: Codable {
//
//                    var item: [Item]
//
//                    struct Item: Codable {
//                        var announceTime: Int
//                        var announceNum: Int
//                        var temp: Int?
//                        var descript: String
//                        var rain: String?
//
//                        enum CodingKeys: String, CodingKey {
//                            case announceTime
//                            case announceNum = "numEf"
//                            case temp = "ta"
//                            case descript = "wfCd"
//                            case rain = "mYn"
//                        }
//                    }
//                }
//            }
//        }
//    }
}


extension Model {
    struct WeatherModel : Codable {
        var weather: [Weather]
        struct Weather : Codable {
            var id : Int
            var main : String
            var description : String
            var icon : String
        }
        
    }
}
