//
//  CommentsViewController.swift
//  Album
//
//  Created by Hüseyin HÖBEK on 14.01.2023.
//

import UIKit

class CommentsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var comments: [CommentElement] = []
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
        tableView.delegate = self
        tableView.dataSource = self
        self.commentTextField.delegate = self
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.isEnabled = false
        commentTextField.backgroundColor = .placeholderText
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        tapGesture.isEnabled = true
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        tapGesture.isEnabled = false
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    func registerTableViewCell() {
        self.tableView.register(UINib.init(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        if commentTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "You did not write a comment!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            let successMessage = "Your comment has been saved."
            let alert = UIAlertController(title: "Success", message: successMessage, preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                alert.dismiss(animated: true, completion: nil)
                self.commentTextField.text = ""
                
            })
        }
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                self.stackView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            self.stackView.frame.origin.y = 0
        }
    }
    
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        let comment = self.comments[indexPath.row]
        cell.comment = comment
        return cell
    }
}

