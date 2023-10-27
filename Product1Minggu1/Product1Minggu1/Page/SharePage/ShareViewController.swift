//
//  ShareViewController.swift
//  Product1Minggu1
//
//  Created by Eky on 26/10/23.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let sectionData: [SectionData] = [
        SectionData<SosialMediaItem>(
            titleSection: "Media 1", 
            data: [
                SosialMediaItem(label: "Facebook", imagePath: "img/to/facebook.png", url: "facebook.com"),
                SosialMediaItem(label: "Twitter", imagePath: "img/to/twitter.png", url: "twitter.com"),
                SosialMediaItem(label: "Instagram", imagePath: "img/to/instagram.png", url: "instagram.com"),
                SosialMediaItem(label: "Tiktok", imagePath: "img/to/tiktok.png", url: "tiktok.com"),
                SosialMediaItem(label: "WhatsApp", imagePath: "img/to/WhatsApp.png", url: "whatsApp.com")
            ]
        ),
        SectionData<SosialMediaItem>(
            titleSection: "Media 2",
            data: [
                SosialMediaItem(label: "Facebook", imagePath: "img/to/facebook.png", url: "facebook.com"),
                SosialMediaItem(label: "Twitter", imagePath: "img/to/twitter.png", url: "twitter.com"),
                SosialMediaItem(label: "Instagram", imagePath: "img/to/instagram.png", url: "instagram.com"),
                SosialMediaItem(label: "Tiktok", imagePath: "img/to/tiktok.png", url: "tiktok.com"),
                SosialMediaItem(label: "WhatsApp", imagePath: "img/to/WhatsApp.png", url: "whatsApp.com"),
            ]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellWithNib(ShareCell.self)
    }
}

extension ShareViewController: UITableViewDelegate, UITableViewDataSource {
    
    // set section length
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].data.count
    }
    
    // set Cell props
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = sectionData[indexPath.section].data
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath ) as ShareCell
        cell.cellButton.setTitle(data[indexPath.row].label, for: .normal)
        return cell
    }
    
    // set total of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    // add section title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section].titleSection
    }
}
