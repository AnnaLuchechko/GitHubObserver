//
//  DetailView.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 29.01.2022.
//

import SwiftUI

struct DetailView: View {
    let repository: GitHubRepository
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                AsyncImage(url: repository.owner.avatarUrl,
                    content: { image in
                       image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 16, maxHeight: 16)
                    },
                    placeholder: {
                       ProgressView()
                    }
                )
                Text(repository.owner.login)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 16))
                Spacer()
            }
            HStack {
                Link(repository.name, destination: repository.url)
                    .font(.system(size: 24))
                Spacer()
            }
            HStack {
                Text(repository.isPrivate ? "Private" : "Public")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 12))
                Spacer()
            }
            HStack(spacing: 4) {
                Image("star")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text(String(repository.stargazersCount))
                Text("stars")
                Spacer()
            }
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: "https://cataas.com/cat"),
                    content: { image in
                       image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: .infinity)
                    },
                    placeholder: {
                       ProgressView()
                    }
                )
            }
        }.padding(.horizontal)
        Spacer()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(repository: GitHubRepository(
            id: 1,
            name: "Repository",
            stargazersCount: 1111,
            description: "Lorem ipsum",
            url: URL(string: "https://github.com/AnnaLuchechko/GitHubObserver")!,
            isPrivate: false,
            owner: GitHubRepository.GitHubOwner(
                login: "AnnaLuchechko",
                avatarUrl: URL(string:"https://cataas.com/cat")!
            )
        ))
    }
}
