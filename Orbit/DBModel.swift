//
//  DBModel.swift
//  Orbit
//
//  Created by David Koo on 01/09/2018.
//  Copyright © 2018 orbit. All rights reserved.
//

import RealmSwift

class User: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    let contents: List<Content> = List<Content>()
    let settingData : List<Settings> = List<Settings>()
    override class func primaryKey() -> String? {
        return "id"
    }
}

class Content: Object {
    
    @objc dynamic var type : String = ""
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var createdAtMonth : String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var weather: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var contentsAlignment : String = ""
    @objc dynamic var image: Data? = nil
    
    convenience init(type : String, createdAt : Date, createdAtMonth : String, title : String, weather : String, body : String, contentsAlignment: String,
                     image : Data?) {
        self.init()
        self.type = type
        self.createdAt = createdAt
        self.createdAtMonth = createdAtMonth
        self.title = title
        self.weather = weather
        self.body = body
        self.contentsAlignment = contentsAlignment
        if image == nil {
            self.image = nil
        } else {
            self.image = image
        }
    }
    
    
}

class Settings: Object {
    @objc dynamic var naviTitleFont : String = ""
    @objc dynamic var contentTitleFont : String = ""
    @objc dynamic var contentsFont : String = ""
    @objc dynamic var contentsFontSize : Int = 0
    @objc dynamic var collectionFilter : Int = 0
    
    convenience init(categoryFont : String, titleFont : String, contentsFont : String, fontSize : Int, collectionFilter : Int) {
        self.init()
        self.naviTitleFont = categoryFont
        self.contentTitleFont = titleFont
        self.contentsFont = contentsFont
        self.contentsFontSize = fontSize
        self.collectionFilter = collectionFilter
    }
}
