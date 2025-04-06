//
//  PostsView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.posts, id: \.image) { post in
                        PostView(post: post).padding(.top, 0)
                    }
                }
                
            }
        }
        .onAppear {
            let posts = [
                Post(
                    tags: ["oc", "witch"],
                    creationTime: "2025-04-05T12:21:03.759494+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreirp2car4dgrpthcjuow3ubzj7drqxsl2kqrt5mjlpchau2ugczrm",
                    alt: "",
                    nsfw: false,
                    cid: "bafyreibkowri3ivvauzn3ugqupsmo7gub67bavmnreb37o75avyz2lyb5y",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3lm2w6pjx6srx"
                ),
                Post(
                    tags: ["angel"],
                    creationTime: "2025-04-03T09:18:15.819835+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreibyax7vvure6pfdc5xv7nifjuhwdb6zdx4d2cf5wjn5jn4pjq5rtq",
                    alt: "",
                    nsfw: false,
                    cid: "bafyreifov2iv7rhcwozexfopkbvcgpggs7znrvxllc7uvzotuw7pjtiwoe",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3llvkzyn3nsct"
                ),
                Post(
                    tags: ["test"],
                    creationTime: "2025-04-03T08:38:55.871923+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreifulmqacunm6w3cikr5wofxktmytk4pen37otpfc6azs7qgqffh6y",
                    alt: "",
                    nsfw: false,
                    cid: "bafyreiat3pkc2yz55jsnnqn6j3p5wbr5omlb7jerrxtlbmjlr5g44qlj6a",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3llvito4eisqb"
                ),
                Post(
                    tags: [],
                    creationTime: "2025-04-02T07:04:37.80516+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreiakohfurieiwnh6dm5tfvnqsgjnvl2yjyj7to4cbmau4jjvasexwy",
                    alt: "",
                    nsfw: false,
                    cid: "bafyreih2up6edekl6yg3fwnftr3ynj3axmesx7w74a7widjaevfswv3fy4",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3llst44k3cszx"
                ),
                Post(
                    tags: [],
                    creationTime: "2025-04-01T03:16:48.751373+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreiabgos4s7ir4uuwv3ke3hcnvjt6zn6nsk33fryydga7aajkwgovqq",
                    alt: "",
                    nsfw: false,
                    cid: "bafyreiaq6ixme6y75xh55kvvdvkfpzvapaefa2tljwwz5s3qe4l2itzcba",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3llpvvtd7yc4n"
                ),
                Post(
                    tags: [],
                    creationTime: "2025-01-15T12:11:57.860697+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreielpypsmfnffejdmbmc3a27sve6kiegbli2kyqfyeqcexxarwew2e",
                    alt: "catgirl hanging out on a mysterious suspended structure",
                    nsfw: false,
                    cid: "bafyreieheglbsoavsk2tgaaazjrfz2im6h6hzj6vqlwsvxhh5pauw2acku",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3lfrqerxfzcek"
                ),
                Post(
                    tags: ["furry", "neko"],
                    creationTime: "2025-01-15T11:31:31.214254+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreiggmxsb7x2csest2unsywj4x4qvahum536noejdmu7sbznv5xt4g4",
                    alt: "cat furry beneath a structure",
                    nsfw: false,
                    cid: "bafyreihjva2gaq32wcvtcopyjgmb2xhwwfrwmpmdaass5cn274dpkcbjyy",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3lfro4hohqs7z"
                ),
                Post(
                    tags: [],
                    creationTime: "2025-01-14T06:56:38.672455+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreiev63iwh3shxptdzoir5soguwnezhbfdf44mhqavu3mqrc7bhcw3i",
                    alt: "horrible cat",
                    nsfw: false,
                    cid: "bafyreicp2ywcb2otef5mkrxs6pppn4s7m54isfil6zqmahvrydppxfohum",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3lfoobzr7a2wp"
                ),
                Post(
                    tags: [],
                    creationTime: "2024-12-23T01:08:50.166999+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreib7hy5itox6yoowb7r33hcg2wh6lgyw3eh6v2riwejmphga6antje",
                    alt: "",
                    nsfw: false,
                    cid: "bafyreibc5su5z43zr35mihl3xlsdagnhiktlo4q6qpxvxj7uciz5e4lkai",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3ldwqltwdf253"
                ),
                Post(
                    tags: [],
                    creationTime: "2024-12-23T00:50:14.550859+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreie7f7yvny3emwbdas7xd32dywwhbu4xya5lk3knj7zsxocgi7uxrq",
                    alt: "",
                    nsfw: false,
                    cid: "bafyreigiiaft6pxjbjjqecbrs3nokzc64lef7mh4oydffml55antuvi7ny",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3ldwpklwg6k2a"
                ),
                Post(
                    tags: [],
                    creationTime: "2024-12-23T00:30:28.262398+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreie32rbtpkstorgkiu54ynabxasf7a2qvow6n4gycxnmcfetgwadze",
                    alt: "My fursona in an abandoned steel mill",
                    nsfw: false,
                    cid: "bafyreiaee6j6bvlxjfi4zgf2yvjdosgdhjc3fabs4bvetqchfdecujl3si",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3ldwohagkssdl"
                ),
                Post(
                    tags: [],
                    creationTime: "2024-12-22T00:03:53.066382+00:00",
                    author: Author(did: "did:plc:vniq7totaxpl7bzlzt7rlhwu", handle: "jokedagger.bsky.social"),
                    image: "https://harbor.pinksea.art/did:plc:vniq7totaxpl7bzlzt7rlhwu/bafkreigj5xhnrllgrsei7itan6opves6v67rc3s7bswk7xbbg3wvxnv5iu",
                    alt: "me if i was a cat girl",
                    nsfw: false,
                    cid: "bafyreidtwbea5iazjbsw52agcfjaxouq34wsnwyav4gmffldccqopkqg6q",
                    at: "at://did:plc:vniq7totaxpl7bzlzt7rlhwu/com.shinolabs.pinksea.oekaki/3ldu4irnmqcr7"
                )
            ]
            viewModel.posts = posts
        }

    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
