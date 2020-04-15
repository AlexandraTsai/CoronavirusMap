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
        
        //*[@id="mapGraphic"]/g
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ALHttp {
    
    init() {
       let url = "https://www.nbcnews.com/health/health-news/coronavirus-map-confirmed-cases-2020-n1120686"
        ALRequestWCookie(url).responseString { [weak self](response) in
            switch response.result {
            case .success(let value):
                if let doc = try? ALHtmlParser.ALHTML(html: value, encoding: String.Encoding.utf8) {
                    print(doc)
//                    let path = #"//*[@id="content"]/div/div[5]/div/div/div/article/div/div[6]/div/div/section/div/div/html/body/*[@id="graphic"]"#
                    let path = #"//*[@id="content"]/div/div[5]/div/div/div/article/div/div[6]/div/div/section/div/div"#
                    for url in doc.xpath(path) {
//                        /html/body
//                        *[@id="graphic"]
//                        /html/body/div
                        ///html/body/div[2]/div/div[6]/div/div/div/article/div/div[7]/div[1]/div[1]/section[1]/div/div/iframe
                        print("------ url = \(url.content) ------")
                    }
                }
                print("====== success ======")
                print(value)
            case .failure(let error):
                print("====== failure ======")
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
