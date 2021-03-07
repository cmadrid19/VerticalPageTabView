//
//  Home.swift
//  VerticalPageTab
//
//  Created by Maxim Macari on 7/3/21.
//

import SwiftUI

struct Home: View {
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    @State var currentPage:Int = 1
    
    var body: some View {
        
        ScrollView(.init()){
            TabView{
                GeometryReader {reader in
                    
                    
                    let screen = reader.frame(in: .global)
                    
                    //Over sliding animation
                    let offset = screen.minX
                    
                    let scale = 1 - (offset / screen.width)
                    
                    TabView(selection: $currentPage){
                        ForEach(1...4, id: \.self){ index in
                            Image("\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width)
                                .cornerRadius(1)
                                .modifier(VerticalTabBarModifier(screen: screen))
                                .tag(index)
                        }
                    }
                    //Page tab bar
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    //vertical tab bar
                    .rotationEffect(.init(degrees: 90))
                    //adjusting width
                    .frame(width: screen.width)
                    //oversliding effect
                    //limiting scale
                    .scaleEffect(scale >= 0.88 ? scale : 0.88, anchor: .center)
                    .offset(x: -offset)
                    //Blureffect
                    .blur(radius: (1 - scale) * 20)
                }
                
                DetailView(currentPage: $currentPage)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .background(Color.black.ignoresSafeArea())
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//Extending view to get reect
extension View{
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}

//Detailview...
struct DetailView: View {
    
    @Binding var currentPage: Int
    
    var body: some View{
        VStack(spacing: 20){
            Text("Details")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top, edges?.top ?? 15)
            
            Image("\(currentPage)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 250)
                .cornerRadius(20)
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text("Dark Soul")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("By Angel")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            
            
            
            
            Button(action: {
                
            }, label: {
                Text("Dowload Image")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth:  1.5)
                    )
            })
            .padding(.vertical)
            
            Button(action: {
                
            }, label: {
                Text("Report Image")
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.red, lineWidth:  1.5)
                    )
            })
            .padding(.vertical)
            
            
            Spacer()
        }
        .padding()
        .background(Color.black.opacity(0.9).ignoresSafeArea())
    }
}

struct VerticalTabBarModifier: ViewModifier {
    
    var screen: CGRect
    
    func body(content: Content) -> some View {
        return content
            //rerotating  vieew to -90 so that is will act as vertical carousel
            
            .frame(width: screen.width, height: screen.height)
            .rotationEffect(.init(degrees: -90))
            .frame(width: screen.height, height: screen.width)
    }
}

//edges
var edges = UIApplication.shared.windows.first?.safeAreaInsets
