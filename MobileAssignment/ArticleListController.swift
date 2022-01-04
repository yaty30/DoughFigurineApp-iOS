//
//  ArticleListController.swift
//  MobileAssignment
//
//  Created by James Yip on 2/1/2022.
//

import UIKit

class ArticleListController: UIViewController {
    struct Result: Codable {
        let data: [ArticleInformation]
    }

    struct ArticleInformation: Codable {
        var id: String;
        var title: String;
        var previewContent: String;
        var thumbnail: String;
        var date: String;
        var author: String;
        var link: String;
        var headers: [String];
        var paragraphs: [String];
        var images: [String];
    }
    
    var detailedArticleTitleLabelText: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        createArticles()
        detailedArticleTitle?.text = getDataSet(index: 0).title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var result: Result?
    private func parseJSON() {
        guard let path = Bundle.main.path(forResource: "Articles", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Result.self, from: jsonData)
            
            if result != nil {
                print()//result)
            } else {
                print("FAILED")
            }
            return
        }
        catch {
            print(error)
        }
        
    }
    
    func getDataSet(index: Int) -> ArticleInformation {
        return (result?.data[index])!
    }
    
    @IBOutlet weak var articleFirstContainer: UIView!
    @IBOutlet weak var articleFirstThumbnail: UIImageView!
    @IBOutlet weak var articleFirstTitle: UILabel!
    @IBOutlet weak var articleFirstPreviewContent: UILabel!
    
    @IBOutlet weak var articleSecContainer: UIView!
    @IBOutlet weak var articleSecThumbnail: UIImageView!
    @IBOutlet weak var articleSecTitle: UILabel!
    @IBOutlet weak var articleSecPreviewContent: UILabel!
    
    @IBOutlet weak var articleThirdContainer: UIView!
    @IBOutlet weak var articleThirdThumbnail: UIImageView!
    @IBOutlet weak var articleThirdTitle: UILabel!
    @IBOutlet weak var articleThirdPreviewContent: UILabel!
    
    func createArticles() {
        articleFirstThumbnail?.image = UIImage(named: "article_1_icon")
        articleFirstThumbnail?.layer.cornerRadius = articleFirstThumbnail.bounds.width / 2;
        articleFirstTitle?.text = getDataSet(index: 0).title
        articleFirstPreviewContent?.text = getDataSet(index: 0).previewContent
        
        articleSecThumbnail?.image = UIImage(named: "article_2_icon")
        articleSecThumbnail?.layer.cornerRadius = articleSecThumbnail.bounds.width / 2;
        articleSecTitle?.text = getDataSet(index: 1).title
        articleSecPreviewContent?.text = getDataSet(index: 1).previewContent
        
        articleThirdThumbnail?.image = UIImage(named: "article_3_icon")
        articleThirdThumbnail?.layer.cornerRadius = articleThirdThumbnail.bounds.width / 2;
        articleThirdTitle?.text = getDataSet(index: 2).title
        articleThirdPreviewContent?.text = getDataSet(index: 2).previewContent
        
        
        return
    }
    
    
    @IBOutlet weak var detailedArticleTitle: UILabel!
    
    @IBAction func firstArticleButton(_ sender: Any) {
        showArticleDetails(index: 0)
    }
    
    func showArticleDetails(index: Int) {
        let title = getDataSet(index: index).title
        self.detailedArticleTitle?.text = "1231231"
        
        print(title)
        
        return
    }
    
}

