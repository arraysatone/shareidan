//
//  DataModel.swift
//  FinalProject
//
//  Created by Xcode User on 2018-11-11.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit

struct jsonData: Decodable {
    let temp: String?
    let movement: String?
    let time: String?
    let max: String?
    let min: String?
}
