//
//  CommentView.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI

struct CommentView: View {
    let post: Post
    let last: Bool
    @State private var size: CGFloat = 0
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            //Timeline
            ZStack(alignment: .trailing) {
                VStack(spacing: 0) {
                    Color(UIColor(named: "Foreground")!).frame(width: 3)
                        .frame(height: size/2)
                    if(!last){
                        Color(UIColor(named: "Foreground")!).frame(width: 3)
                            .frame(height: size/2)
                    } else {
                        Spacer()
                    }
                }.frame(width: 30)
                Color(UIColor(named: "Foreground")!)
                    .frame(width: 16.5, height: 3, alignment: .trailing)
                
            }
            .frame(width: 30, height: size)
            .fixedSize()
            
            //Body
            VStack(alignment: .leading) {
                    //Info
                HStack() {
                    Image("apple")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("@\(post.author.handle)")
                        .bold()
                        .font(.system(size: 11, weight: .bold, design: .default))
                    Spacer()
                    Text(post.getFormattedDate() ?? "")
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .padding(.trailing, 10)
                }
                .padding(.leading, 12)
                .frame(alignment: .leading)
                //Image
                AsyncImage(url: post.getUrl()) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .padding(60)
                                .foregroundColor(.gray)
                            Text(post.alt)
                        }
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .overlay(
                ZStack {
                    GeometryReader { geometry in
                        VStack {}.onChange(of: geometry.size.height) {old, new in
                            size = new
                        }
                    }
                    HStack(spacing: 0) {
                        Color(UIColor(named: "Foreground")!).frame(width: 10) // Left
                        VStack(spacing: 0) {
                            Spacer()
                            Color(UIColor(named: "Foreground")!).frame(height: 3) // Left
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    CommentView(post: comments[1], last: true)
}
