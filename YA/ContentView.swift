//
//  ContentView.swift
//  YA
//
//  Created by 邱宏宇 on 2021/9/2.
//

import SwiftUI

struct ContentView: View {
    
    //@State var amount: Int = 0
    @State private var cantbezero = false
    @ObservedObject var amount = NumbersOnly()
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                VStack{
                    ZStack(alignment: .trailing){
                        
                        VStack
                        {
                            TextField("enter", text: $amount.value)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.white)
                                .cornerRadius(30)
                                .padding()
                                .keyboardType(.numberPad)
                                
                                
                                .onDisappear(){
                                    if (amount.value == "0" || amount.value == "")
                                    {
                                        cantbezero.toggle()
                                    }
                                }
                            
                                .alert(isPresented: $cantbezero) {
                                        Alert(
                                            title: Text("Input can't be zero or empty")
                                        )
                                    }
                            
                                
                            NavigationLink(
                                destination: result_Page(choose: String(amount.value)),
                                label: {
                                Text("Count")
                                    .font(.system(.largeTitle, design: .rounded))
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(.black)
                                    .background(Color("LightGreen"))
                                    .cornerRadius(30)
                                    .shadow(radius: 30)
                                    
                            })
                        }
                        
                    }
                    
                }
                
                
            }
            
        }
    }
}
class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

struct result_Page: View{
    
    var choose = ""
    
    var body: some View{
        ZStack{
            Color("background")
            .ignoresSafeArea()
            
            ZStack {
                Color(.white)
                Text(choose)
                        HStack {
                            VStack(alignment: .leading) {
                                Text(choose)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Text("No No")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundColor(.primary)
                                    .lineLimit(3)
                                Text("Hi".uppercased())
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .layoutPriority(100)
                            Spacer()
                        }
                        .padding()
                    }
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    )
                    .padding([.top, .horizontal])
//            Text(choose)
//                .font(.system(.title2, design: .rounded))
//                .fontWeight(.medium)
//                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 300)
//                .padding()
//                .foregroundColor(.black)
//                .cornerRadius(50)
//                .shadow(radius: 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
