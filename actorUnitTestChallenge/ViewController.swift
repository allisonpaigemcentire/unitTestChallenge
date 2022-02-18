
import UIKit

class ViewController: UIViewController {

    let manager = ArticleManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        sendableExampleButtonTapped()
    }

    func sendableExampleButtonTapped() {

        let articleTitle = "Swift Senpai Article 01"

        // Create a parent task
        Task {

            // Create a task group
            await withTaskGroup(of: Void.self, body: { taskGroup in

                // Create 3000 child tasks to like
                for _ in 0..<3000 {
                    taskGroup.addTask {
                        await self.manager.like(articleTitle)
                    }
                }

                // Create 1000 child tasks to dislike
                for _ in 0..<1000 {
                    taskGroup.addTask {
                        await self.dislike(articleTitle: articleTitle)
                    }
                }
            })

            print("👍🏻 Like count: \(await manager.getArticle(with: articleTitle)!.likeCount)")
        }
    }

    /// Access article outside of the actor and reduces its like count by 1
    func dislike(articleTitle: String) async {

        guard var article = await manager.getArticle(with: articleTitle) else {
            return
        }

        // Reduce like count
        article.likeCount -= 1

        await manager.updateArticle(article)
    }

}



