import UIKit
//
//struct ArticleSummary: Codable {
//    var id: String;
//    var title: String;
//    var previewContent: String;
//    var thumbnail: String;
//    var date: String;
//    var author: String;
//    var link: String;
//    //    var headers = [String]();
//    //    var paragraphs = [String]();
//    //    var images = [String]();
//}
//
//struct ArticleDetail: Codable {
//    var id: String;
//    var date: String;
//    var author: String;
//    var link: String;
//    var title: String;
////    var headers = [String]();
////    var paragraphs = [String]();
////    var images = [String]();
//}
//
//struct ArticleInfo: Codable {
//    var summary: ArticleSummary;
//    var detail: ArticleDetail;
//}
//
//class ArticleList: NSObject {
//    static let session = URLSession(configuration: URLSessionConfiguration.default);
//    static var articleDict = [String : Any]();
//    static let urlStr = "http://thejamesyip.com/apis/"
//    static var articleSummaries = [ArticleSummary]()
//    static var articleDetails = [ArticleDetail]()
//
//    class func getArticles(_ theFunc:@escaping (_ books: [ArticleSummary])->Void){
//        var arr = [ArticleSummary]();
//        var arrDetail = [ArticleDetail]();
//        if let url = URL(string: urlStr) {
//            let dataTask = session.dataTask(with: URLRequest(url: url), completionHandler: {
//                (data, response, err) in
//                if let data = data {
//                    if let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any] {
//                        self.articleDict = dict;
//
//                        if let items = dict["items"] as? [[String: Any]] {
//                            for item in items {
//                                var title = "";
//                                var previewContent = "";
//                                var thumbnail = "";
//                                var id = "";
//                                if let _id = item["id"] as? String {
//                                    id = _id
//                                }
//
//                                if let _title = item["title"] as? String {
//                                    title = _title
//                                    print(title)
//                                }
//
//                                if let _previewContent = item["previewContent"] as? String {
//                                    previewContent = _previewContent
//                                }
//
//                                if let _thumbnail = item["thumbnail"] as? String {
//                                    thumbnail = _thumbnail
//                                }
//
//                                var date = "";
//                                var author = "";
//                                var link = "";
////                                let headers = [String]();
////                                let paragraphs = [String]();
////                                let images = [String]();
//                                if let details = item["details"] as? [String:Any] {
//                                    if let _date = details["date"] as? String {
//                                        date = _date
//                                    }
//                                    if let _author = details["author"] as? String {
//                                        author = _author
//                                    }
//                                    if let _link = details["link"] as? String {
//                                        link = _link
//                                    }
//
//                                    let articleSummary = ArticleSummary(
//                                        id: id, title: title, previewContent: previewContent, thumbnail: thumbnail
//                                    );
//                                    arr.append(articleSummary);
//
//                                    let articleDetail = ArticleDetail(
//                                        id: id, date: date, author: author, link: link, title: title
////                                        headers: headers, paragraphs: paragraphs, images: images
//                                    );
//                                    arrDetail.append(articleDetail);
//                                }
//
//                            }
//                        }
//                    }
//                }
//                articleDetails = arrDetail;
//                articleSummaries = arr;
//                theFunc(articleSummaries);
//            })
//            dataTask.resume();
//        } else {
//            articleDetails = arrDetail;
//            articleSummaries = arr;
//            theFunc(articleSummaries);
//        }
//    }
//
//    class func getArticle(_ id:String, completion:(_ result: ArticleDetail)->Void){
//        for articleDetail in articleDetails {
//            if id == articleDetail.id{
//                completion(articleDetail);
//            }
//        }
//    }
//}
//
//
