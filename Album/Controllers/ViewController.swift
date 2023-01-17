//
//  ViewController.swift
//  Album
//
//  Created by Hüseyin HÖBEK on 8.01.2023.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: AlbumViewModel?
    let menuView = UIView(frame: CGRect(x: 0, y: 100, width: 250, height: 718))
    let aboutMeButton = UIButton(frame: CGRect(x: 50, y: 650, width: 150, height: 40))
    let commentsButton = UIButton(frame: CGRect(x: 40, y: 300, width: 150, height: 30))
    //MARK: açılır pencerenin backgroundu açılış logosu yap
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AlbumViewModel(webService: WebService())
        tableView.delegate = self
        tableView.dataSource = self
        fetchAlbumList()
        view.addSubview(menuView)
        // MARK: HamburgerMenu
        menuView.backgroundColor = UIColor.lightGray
        menuView.isHidden = true
        aboutMeButton.backgroundColor = UIColor.blue
        aboutMeButton.setTitle("About Me", for: .normal)
        aboutMeButton.setTitleColor(UIColor.white, for: .normal)
        menuView.addSubview(aboutMeButton)
        aboutMeButton.addTarget(self, action: #selector(goToAboutMePage), for: .touchUpInside)
        commentsButton.backgroundColor = .clear
        commentsButton.setTitle("Comments", for: .normal)
        commentsButton.setTitleColor(UIColor.systemBlue, for: .normal)
        menuView.addSubview(commentsButton)
        
    }
    
    @objc func goToAboutMePage() {
        guard let url = URL(string: "https://github.com/huseyinhobek") else { return }
        UIApplication.shared.open(url)
    }
    
    private func fetchAlbumList() {
        
        guard let viewModel = viewModel else {return}
        viewModel.fetchData(completion: { result in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func menuButton(_ sender: Any) {
        if menuView.isHidden {
            menuView.isHidden = false
        } else {
            menuView.isHidden = true
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.albums[section].title
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.red
        label.textAlignment = .center
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.albumList.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        let album = viewModel?.albumList[indexPath.row]
        cell.configCell(model: album!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let commentsVC = storyboard.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsViewController
        
        let selectedAlbum = self.viewModel?.albumList[indexPath.row]
        commentsVC.comments = selectedAlbum?.comments ?? []
        
        self.navigationController?.pushViewController(commentsVC, animated: true)
    }
    
}
