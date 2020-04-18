//
//  ContentView.swift
//  Maps
//
//  Created by 蔡佳宣 on 2020/3/22.
//  Copyright © 2020 蔡佳宣. All rights reserved.
//

import SwiftUI
import Alamofire
import Kanna

struct ContentView: View {
    
    var aLHttp = ALHttp()
 
    var body: some View {
        VStack {
            Text("Corona")
                .font(.system(size: 34, weight: .bold))
            Text("Total Deaths:")
            
            HStack {
                VStack {
                    Spacer()
                }.frame(width: 10, height: 200)
                .background(Color.red)
                
                VStack {
                    Spacer()
                }.frame(width: 10, height: 200)
                .background(Color.red)
                
                VStack {
                    Spacer()
                }.frame(width: 10, height: 200)
                .background(Color.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CaseTable {
    var country: String?
    var confirmed: String?
    var deaths: String?
}

class ALHttp {
    
    init() {
//       let url = "https://www.nbcnews.com/health/health-news/coronavirus-map-confirmed-cases-2020-n1120686"
        let tableURL = "https://dataviz.nbcnews.com/projects/20200122-coronavirus-world-count/world-table.html?initialWidth=461&amp;childId=embed-20200122-coronavirus-table-count&amp;parentTitle=Coronavirus%20map%3A%20The%20COVID-19%20virus%20is%20spreading%20across%20the%20world.%20Here%27s%20where%20cases%20have%20been%20confirmed.&amp;parentUrl=https%3A%2F%2Fwww.nbcnews.com%2Fhealth%2Fhealth-news%2Fcoronavirus-map-confirmed-cases-2020-n1120686"
        ALRequestWCookie(tableURL).responseString { [weak self](response) in
            switch response.result {
            case .success(let value):
                if let doc = try? Kanna.HTML(html: value, encoding: String.Encoding.utf8) {
//                if let doc = try? ALHtmlParser.ALHTML(html: value, encoding: String.Encoding.utf8) {
                    let pathHead = #"//*[@id="graphic"]/div/table/thead"#
//                    for url in doc.xpath(pathHead) {
//                        print("------ url = \(url.content) ------")
//                    }
//
//                    for (index, td) in doc.css("td").enumerated() {
//                        print(td.text as! String)
//                    }
                    
//                    let pathBody = "//table[@class=\"table\"]//tbody"
//                    for url in (doc.body?.xpath(pathBody))! {
//                        print(url.text)
//                        for url in url.xpath("//tr/td") {
//                            print(url.content)
//                        }
//
//                    }
                    
                    let pathBody = #"//tbody[@id='tbody']"#
                    for url in doc.xpath(pathBody) {
                        print(url.xpath("/tr")[0].content)
                        print(url.xpath("/tr/td[1]")[0].content)
                        print(url.at_xpath("//tr")?.content)

                    }
                   
                    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func ALRequest(_ url: String) {
        let request = AF.request(url)
        request.responseJSON { (data) in
        }
    }
    
    func ALRequestWCookie(_ url: String, para: [String: String]? = nil) -> DataRequest {
        return AF.request(url,
                          method: .get,
                          parameters: para,
                          encoding: URLEncoding.default,
                          headers: HTTPHeaders(dictionaryLiteral: ("Cookie", "over18=1")))
    }
    
    func covid19CasesTable(_ html: String) {
    
    }
}

class ALHtmlParser {
    
    static func ALHTML(html: String, encoding: String.Encoding) throws -> HTMLDocument {
        
        return try Kanna.HTML(html: html, encoding: encoding)
    }
}

//class Provider: NSObject {
//
//    static let shared = Provider()
//
//    func
//}
