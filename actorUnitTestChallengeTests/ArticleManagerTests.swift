import XCTest
@testable import actorUnitTestChallenge

class ArticleManagerTests: XCTestCase {

    let SUT = ArticleManager()
    let articleTitle = "Swift Senpai Article 01"

    func test_dislikeUpdatesArticleCount() async {

        guard var article = await SUT.getArticle(with: articleTitle) else {
            return
        }

        let currentArticleCount = article.likeCount

        // Reduce like count
        article.likeCount -= 1
        await SUT.updateArticle(article)

        article = await SUT.getArticle(with: articleTitle) ?? Article(title: articleTitle)

        XCTAssertNotEqual(currentArticleCount, article.likeCount)
    }

    func test_sendableTappedUpdatesArticleCount() async {

        guard var article = await SUT.getArticle(with: articleTitle) else {
            return
        }

        let currentArticleCount = article.likeCount

        // Create a task group
        await withTaskGroup(of: Void.self, body: { taskGroup in

            // Create 3000 child tasks to like
            for _ in 0..<3000 {
                taskGroup.addTask {
                    await self.SUT.like(self.articleTitle)
                }
            }

            for _ in 0..<3000 {
                article = await SUT.getArticle(with: articleTitle) ?? Article(title: articleTitle)
                XCTAssertNotEqual(currentArticleCount, article.likeCount)
            }
        })

    }

    func test_getArticleReturnsNilWhenNoStringPassed() async {
        let value = await SUT.getArticle(with: "")
        XCTAssertNil(value)
    }

    func test_getArticleReturnsValueWhenStringPassed() async {
        let value = await SUT.getArticle(with: articleTitle)
        XCTAssertNotNil(value)
        XCTAssertEqual(value?.title, articleTitle)
    }

    func test_getArticleReturnsCorrectValueWhenStringPassed() async {
        let value = await SUT.getArticle(with: "Swift Senpai Article 02")
        XCTAssertNotNil(value)
        XCTAssertNotEqual(value?.title, articleTitle)
        XCTAssertEqual(value?.title, "Swift Senpai Article 02")
    }

}
