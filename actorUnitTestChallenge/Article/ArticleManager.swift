import Foundation

actor ArticleManager {

    private var articles: Set<Article> = [
        Article(title: "Swift Senpai Article 01"),
        Article(title: "Swift Senpai Article 02"),
        Article(title: "Swift Senpai Article 03"),
    ]

    /// Increase like count by 1
    func like(_ articleTitle: String) {

        guard var article = getArticle(with: articleTitle) else {
            return
        }

        article.likeCount += 1

        // Update array after increased like count
        updateArticle(article)
    }

    /// Get article based on article title
    func getArticle(with articleTitle: String) -> Article? {
        return articles.filter({ $0.title == articleTitle }).first
    }

    /// Update articles in Article Manager
    func updateArticle(_ article: Article) {
        articles.update(with: article)
    }
}
