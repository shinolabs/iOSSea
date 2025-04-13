//
//  SearchResultView.swift
//  iOSSea
//
//  Created by makrowave on 13/04/2025.
//

import SwiftUI

//Can be used as search result universally
//title - nick/#tag, subtitle - @handle/number of posts
struct SearchResultView<Destination: View>: View {
    let url: String
    let title: String
    let subtitle: String
    let destination: () -> Destination
    
    init(
            url: String,
            title: String,
            subtitle: String,
            @ViewBuilder destination: @escaping () -> Destination
        ) {
            self.url = url
            self.title = title
            self.subtitle = subtitle
            self.destination = destination
        }
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 0) {
                HStack {
                    CachedImageView(url: url)
                        .frame(width: 80, height: 80)
                        .cornerRadius(22)
                        .padding(.leading)
                    VStack(alignment: .leading) {
                        Text(title).font(.title2).bold()
                        Text(subtitle).fontWeight(.thin)
                    }
                    Spacer()
                }.padding(.vertical, 10)
                Color.foreground
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    SearchResultView(url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                     title: "#pc",
                     subtitle: "1 post", destination: {EmptyView()})
}
 
