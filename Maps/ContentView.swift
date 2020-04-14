//
//  ContentView.swift
//  Maps
//
//  Created by 蔡佳宣 on 2020/3/22.
//  Copyright © 2020 蔡佳宣. All rights reserved.
//

import SwiftUI
import Alamofire

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
    
    
}
