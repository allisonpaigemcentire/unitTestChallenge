import Foundation

struct Article: Sendable, Hashable {

    let title: String
    var likeCount = 0

    init(title: String) {
        self.title = title
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
