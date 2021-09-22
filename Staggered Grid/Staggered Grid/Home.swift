//
//  Home.swift
//  Staggered Grid
//
//  Created by Nerimene on 6/9/2021.
//

import SwiftUI

struct Home: View {
    
    @State var posts: [Post] = []
    @State var columns: Int = 2
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            StaggeredGrid(columns: columns, list: posts, content: { post in
                CardPostView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
                    .onAppear {
                        print(post.imgUrl)
                    }
            })
            .padding(.horizontal)
            .navigationTitle("Staggered Grid")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        columns += 1
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        columns = max(columns - 1, 1)
                    } label: {
                        Image(systemName: "minus")
                    }
                }
            }.animation(.easeInOut, value: columns)
        }.onAppear {
            for index in 1...10 {
                posts.append(Post(imgUrl: "post\(index)"))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct CardPostView: View {
    var post: Post
    var body: some View {
        Image(post.imgUrl)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
