import Foundation

public final class Repo: Decodable {
    public var repoId: Int = 0
    public var repoName: String = ""
    public var ownerName: String = ""
    public var descriptionRepo: String = ""
    public var repoUrl: String = ""

    init() {}

    init(repoId: Int, repoName: String, ownerName: String, descriptionRepo: String, repoUrl: String) {
        self.repoId = repoId
        self.repoName = repoName
        self.ownerName = ownerName
        self.descriptionRepo = descriptionRepo
        self.repoUrl = repoUrl
    }
}
