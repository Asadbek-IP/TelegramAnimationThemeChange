//
//  ContentView.swift
//  AnimationThemeChange
//
//  Created by Mac Mini 1 on 21/02/24.
//

import SwiftUI




@available(iOS 17.0, *)
struct ContentView: View {
    @State var toggleDarkMode = false
    @AppStorage("isDarkMode") var activeDarkMode = false
    @AppStorage("locale") var locale: String = "uz"
    
    @State private var buttonReact: CGRect = .zero
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false
    
    var body: some View {
        VStack{
           
            
            Spacer()
            
            
            Image("logo")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                .padding(.bottom, 24)
            
            Text("Foydalanishda davom etish uchun iltimos tilni tanlang")
                .font(.custom("Manrope-SemiBold", size: 24))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom,-4)
            
            Text("Please select a language to continue using")
                .font(.custom("Manrope-Medium", size: 14))
                .foregroundStyle(Color.gray)
                .padding(4)
            
            Text("Пожалуйста, выберите язык, чтобы продолжить использование")
                .multilineTextAlignment(.center)
                
                .font(.custom("Manrope-Medium", size: 14))
                .foregroundStyle(Color.gray)
                .padding(.horizontal)
            
            Spacer()
            
            HStack{
                Text("O‘zbekcha")
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.textFielt))
            .onTapGesture {
                locale = "uz"
              
            }
            .padding(.horizontal)
            HStack{
                Text("English")
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.textFielt))
            .onTapGesture {
                locale = "en"
                
            }
            .padding(.horizontal)
            HStack{
                Text("Русский")
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.textFielt))
            .onTapGesture {
                locale = "ru"
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            
        }
        .createImages(toggleDarkMode: toggleDarkMode, currentImage: $currentImage, previousImage: $previousImage, activateDarkMode: $activeDarkMode)
       
        .overlay(content: {
            GeometryReader(content: { geometry in
                let size = geometry.size
                
                if let previousImage, let currentImage {
                    ZStack{
                        Image(uiImage: previousImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                        Image(uiImage: currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                            .mask(alignment: .topLeading) {
                                Circle()
                                    
                                    .frame(width: buttonReact.width * (maskAnimation ? 80 : 1), height: buttonReact.height  * (maskAnimation ? 80 : 1), alignment: .bottomLeading)
                                    .frame(width: buttonReact.width, height: buttonReact.height)
                                    .offset(x: buttonReact.minX, y: buttonReact.minY)
                                    .ignoresSafeArea()
                                    
                            }
                    }
                    .task {
                        guard !maskAnimation else {return}
                        withAnimation(.easeInOut(duration: 0.9), completionCriteria: .logicallyComplete){
                            maskAnimation = true
                        } completion: {
                            self.currentImage = nil
                            self.previousImage = nil
                            maskAnimation = false
                        }
                    }
                }
            })
            .ignoresSafeArea()
        })
        .overlay(alignment: .topTrailing) {
            Button(action: {
                toggleDarkMode.toggle()
            }, label: {
                Image(systemName: activeDarkMode ? "sun.max.fill" : "moon.fill")
                    
                    .resizable()
                    .foregroundStyle(activeDarkMode ? .white : .black)
                    .frame(width: 20,height: 20)
                    .padding(12)
                    .background(Circle().stroke(.textFielt, lineWidth: 1).foregroundStyle(.clear))
                    .symbolEffect(.bounce, value: toggleDarkMode)
                    
            })
           
            .rect{ rect in
                
                buttonReact = rect
                
            }
            .padding(10)
            .disabled( currentImage != nil || previousImage != nil || maskAnimation)
        }
        
        
        .preferredColorScheme(activeDarkMode ? .dark : .light)
    }
}


