//
//  ContentView.swift
//  Gosync
//
//  Created by 褚翊喨 on 2024/5/28.
//

import SwiftUI

struct ContentView: View {
    @State private var credit_score = 100
    @State private var name = ""
    @State private var nickname = ""
    @State private var passwd = ""
    @State private var phone = ""
    @State private var wellcome = ""
    var body: some View {
        ZStack {
            VStack {
                
                Text("Sign Up")
                    .font(.title)
                    .padding(100)
                
                
                TextField("Enter your name", text: $name)
                    .multilineTextAlignment(.center)
                    .padding(10)
                
                TextField("Enter your nickname", text: $nickname)
                    .multilineTextAlignment(.center)
                    .padding(10)
                
                TextField("Enter your password", text: $passwd)
                    .multilineTextAlignment(.center)
                    .padding(10)
                
                TextField("Enter your phone number", text: $phone)
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .padding(.bottom,20)
                
                Button(action: {
                    apiCall()
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(Color.blue
                            .cornerRadius(10))
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                })
                
                Text(wellcome)
                Spacer()
            }
        }
    }
    
    func apiCall() {
        guard let url = URL(string: "https://0260-211-75-210-244.ngrok-free.app/ios") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "credit_score" : self.credit_score,
            "name": self.name,
            "nickname":self.nickname,
            "passwd" : self.passwd,
            "phone" : self.phone
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                print("success: \(response)")
                wellcome = "name: \(response.name)"
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}

struct Response: Codable {
    let credit_score: Int
    let name: String
    let nickname: String
    let passwd: String
    let phone: String
}
#Preview {
    ContentView()
}
