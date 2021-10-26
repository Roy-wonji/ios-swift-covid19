//
//  CityCoviedOverview.swift
//  covid19
//
//  Created by 서원지 on 2021/10/25.
//

import Foundation

struct CityCoviedOverview: Codable{
    let korea: CoviedOverview
    let seoul: CoviedOverview
    let busan: CoviedOverview
    let daegu: CoviedOverview
    let incheon: CoviedOverview
    let gwangju: CoviedOverview
    let daejeon: CoviedOverview
    let ulsan: CoviedOverview
    let sejong: CoviedOverview
    let gyeonggi: CoviedOverview
    let gangwon: CoviedOverview
    let chungbuk: CoviedOverview
    let chungnam: CoviedOverview
    let jeonbuk: CoviedOverview
    let jeonnam: CoviedOverview
    let gyeongbuk: CoviedOverview
    let gyeongnam: CoviedOverview
    let jeju: CoviedOverview
    let quarantine: CoviedOverview
    
}

struct CoviedOverview: Codable{
    let countryName: String
    let newCase: String
    let totalCase: String
    let recovered: String
    let death: String
    let percentage: String
    let newCcase: String
    let newFcase: String
    
}
