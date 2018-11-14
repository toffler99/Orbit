//
//  DiaryViewController.swift
//  Orbit
//
//  Created by ilhan won on 2018. 8. 11..
//  Copyright © 2018년 orbit. All rights reserved.
//

import UIKit
import RealmSwift


class DiaryViewController: UIViewController {

   
    private var realm = try! Realm()
    var datasourece : Results<Content>!

    var dateLabel : UILabel!
    var dayOfWeek : UILabel!
    var weatherImgV : UIImageView!
    var titleLabel : UILabel!
    var contents : UITextView!
    var contentImgView : UIImageView!
    var containerView : UIView!
    var dateCollectionView : UICollectionView!
    let user = User()
    var indexPath : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realmManager = RealmManager.shared.realm
        datasourece = realmManager.objects(Content.self).sorted(byKeyPath: "createdAt", ascending: false)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 1, blue: 240/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "\(dateToString(in: datasourece[indexPath].createdAt, dateFormat: "yyyy.MM.dd eee"))"
//        let attrs = [ NSAttributedString.Key.foregroundColor : UIColor(red: 246/255, green: 252/255, blue: 226/255, alpha: 1),
//                      NSAttributedString.Key.font : UIFont(name: "system", size: 24)]
//        navigationController?.navigationBar.titleTextAttributes = attrs as [NSAttributedStringKey : Any]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        setupLayout()
        
    }
    override func viewDidLayoutSubviews() {
        dataUpdate()
    }
}

////MARK: collectionView datasource
//extension DiaryViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .yellow
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//}
extension DiaryViewController {
    fileprivate func setupLayout() {
        self.view.backgroundColor = UIColor(red: 1, green: 1, blue: 240/255, alpha: 1)
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: (self.view.frame.width / 7) - 1, height: 60)
//
//        dateCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        dateCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        dateCollectionView.dataSource = self
//        dateCollectionView.delegate = self
//
//        dateCollectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        let constDateCV : [NSLayoutConstraint] = [NSLayoutConstraint(item: dateCollectionView, attribute: .top,
//                                                                     relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
//                                                  NSLayoutConstraint(item: dateCollectionView, attribute: .leading,
//                                                                     relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0),
//                                                  NSLayoutConstraint(item: dateCollectionView, attribute: .trailing,
//                                                                     relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0),
//                                                  NSLayoutConstraint(item: dateCollectionView, attribute: .height,
//                                                                     relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 63)]
//        view.addSubview(dateCollectionView)
//        view.addConstraints(constDateCV)
//        dateCollectionView.backgroundColor = .green
//
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let consContainerV : [NSLayoutConstraint] = [
            NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide,
                               attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide,
                               attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide,
                               attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide,
                               attribute: .bottom, multiplier: 1, constant: 0)]
        
        view.addSubview(containerView)
        view.addConstraints(consContainerV)
        containerView.backgroundColor = UIColor(red: 1, green: 1, blue: 240/255, alpha: 1)
        
        weatherImgV = UIImageView()
        weatherImgV.translatesAutoresizingMaskIntoConstraints = false
        
        let consWeather : [NSLayoutConstraint] = [
            NSLayoutConstraint(item: weatherImgV, attribute: .top, relatedBy: .equal, toItem: containerView
                , attribute: .top, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: weatherImgV, attribute: .width, relatedBy: .equal, toItem: containerView,
                               attribute: .width, multiplier: 0.1, constant: 0),
            NSLayoutConstraint(item: weatherImgV, attribute: .height, relatedBy: .equal, toItem: weatherImgV,
                               attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weatherImgV, attribute: .trailing, relatedBy: .equal, toItem: containerView,
                               attribute: .trailing, multiplier: 1, constant: -4)]
        
        containerView.addSubview(weatherImgV)
        containerView.addConstraints(consWeather)
        weatherImgV.backgroundColor = .black
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let consTitleLabel : [NSLayoutConstraint] = [
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: containerView,
                               attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: weatherImgV,
                               attribute: .leading, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil,
                               attribute: .height, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: weatherImgV,
                               attribute: .bottom, multiplier: 1, constant: 0)]
        
        containerView.addSubview(titleLabel)
        containerView.addConstraints(consTitleLabel)
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        contentImgView = UIImageView()
        contentImgView.translatesAutoresizingMaskIntoConstraints = false
        
        let consContentImgV : [NSLayoutConstraint] = [
            NSLayoutConstraint(item: contentImgView, attribute: .top, relatedBy: .equal, toItem: weatherImgV,
                               attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: contentImgView, attribute: .width, relatedBy: .equal, toItem: containerView,
                               attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentImgView, attribute: .height, relatedBy: .equal, toItem: containerView,
                               attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentImgView, attribute: .centerX, relatedBy: .equal, toItem: containerView,
                               attribute: .centerX, multiplier: 1, constant: 0)]
        
        containerView.addSubview(contentImgView)
        containerView.addConstraints(consContentImgV)
        contentImgView.backgroundColor = .clear
        contentImgView.contentMode = .scaleAspectFill
        contentImgView.clipsToBounds = true
        
        contents = UITextView()
        contents.translatesAutoresizingMaskIntoConstraints = false
        
        let consContents : [NSLayoutConstraint] = [
            NSLayoutConstraint(item: contents, attribute: .top, relatedBy: .equal, toItem: contentImgView,
                               attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contents, attribute: .leading, relatedBy: .equal, toItem: containerView,
                               attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: contents, attribute: .trailing, relatedBy: .equal, toItem: containerView,
                               attribute: .trailing, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: contents, attribute: .bottom, relatedBy: .equal, toItem: containerView,
                               attribute: .bottom, multiplier: 1, constant: 0)]
        
        containerView.addSubview(contents)
        containerView.addConstraints(consContents)
        contents.backgroundColor = .clear
        contents.isEditable = false
        contents.textAlignment = .center
        contents.font = UIFont.systemFont(ofSize: 18)
    }
    
}

extension DiaryViewController {
    @objc fileprivate func pushWriteViewController() {
//        let writeViewController = WriteViewController(delegate: self)
//        navigationController?.pushViewController(writeViewController, animated: true)
    }
    
    func dataUpdate() {
       let data = datasourece[indexPath]
        titleLabel.text = data.title
        contents.text = data.body
        contentImgView.image = UIImage(data: data.image!)
    }
}
