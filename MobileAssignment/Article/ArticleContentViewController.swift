//
//  ArticleContentViewController.swift
//  MobileAssignment
//
//  Created by James Yip on 13/1/2022.
//

import UIKit

class ArticleContentViewController: UIViewController {

    let db = firebase.db
    
    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var pTitleOne: UILabel!
    @IBOutlet weak var pOne: UILabel!
    
    @IBOutlet weak var pTitleTwo: UILabel!
    @IBOutlet weak var pTwo: UILabel!
    
    @IBOutlet weak var pTitleThree: UILabel!
    @IBOutlet weak var pThree: UILabel!
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var source: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.isHidden = false
        self.loading.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        articleTitle.text = selectedArticle.title
        fetch(done: {})
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.0...1.4)) {
            self.loadingView.isHidden = true
        }
    }
    
    func fetch(done: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.fetchArray("paragraphTitle", self.pTitleOne, 0, "title")
            self.fetchArray("paragraphTitle", self.pTitleTwo, 1, "title")
            self.fetchArray("paragraphTitle", self.pTitleThree, 2, "title")
            
            self.fetchArray("paragraphs", self.pOne, 0, "para")
            self.fetchArray("paragraphs", self.pTwo, 1, "para")
            self.fetchArray("paragraphs", self.pThree, 2, "para")
            
            self.fetchContent("author", self.author)
            self.fetchContent("date", self.date)
            self.fetchContent("source", self.source)
            
            done()
        }
    }
    
    func fetchContent(_ field: String, _ label: UILabel) {
        let docRef = db.document("articles/\(selectedArticle.doc)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            
            DispatchQueue.main.async {
                label.text = field == "date" ? "Date: \(res as? String == "" ? "---" : res)" : field == "author" ? "Author: \(res)" : "Source: \(res)"
                
            }
        }
    }
    
    func fetchArray(_ field: String, _ label: UILabel, _ index: Int, _ type: String) {
        let docRef = db.document("articles/\(selectedArticle.doc)")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let res = data[field] else { return }
            let arr = res as? NSArray
            DispatchQueue.main.async {
                label.text = "\(arr![index])"
            }
        }
    }
    

}


/*
 source
 author
 date
 [paragraphs]
 [paragraphsTitle]
 */
