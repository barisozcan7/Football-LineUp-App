//
//  FourTwoThreeOneViewController.swift
//  Comp319_Project
//
//  Created by Barıs Ozcan on 1.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString6: String) {
        let hex = hexString6.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension FourTwoThreeOneViewController : PlayerDataSourceDelegate {
    func playerListLoaded(playerList: [Player]) {
        self.playerArray = playerList.sorted { $0.overallRating > $1.overallRating }
        self.one = playerArray.filter {
            $0.positionID == 19
            }[0]
        self.four = playerArray.filter {
            $0.positionID == 20
            }[0]
        self.two = playerArray.filter {
            $0.positionID == 20
            }[1]
        self.five = playerArray.filter {
            $0.positionID == 20
            }[2]
        self.three = playerArray.filter {
            $0.positionID == 20
            }[3]
        self.six = playerArray.filter {
            $0.positionID == 21
            }[0]
        self.eight = playerArray.filter {
            $0.positionID == 21
            }[1]
        self.seven = playerArray.filter {
            $0.positionID == 22
            }[0]
        self.nine = playerArray.filter {
            $0.positionID == 22
            }[1]
        self.ten = playerArray.filter {
            $0.positionID == 22
            }[2]
        self.eleven = playerArray.filter {
            $0.positionID == 22
            }[3]
        
        self.tableView.reloadData()
    }
    
    func playerListLoadedFor4231(playerList: [Player]) {
        self.playerArray = playerList
        self.one = playerArray[0]
        self.two = playerArray[1]
        self.three = playerArray[2]
        self.four = playerArray[3]
        self.five = playerArray[4]
        self.six = playerArray[5]
        self.seven = playerArray[6]
        self.eight = playerArray[7]
        self.nine = playerArray[8]
        self.ten = playerArray[9]
        self.eleven = playerArray[10]
        self.tableView.reloadData()
    }
}

extension FourTwoThreeOneViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "4231Cell", for: indexPath) as! FourTwoThreeOneTableViewCell
        if let one = one{
            cell.oneNameLabel.text = "\(one.name)"
            cell.oneRatingLabel.text = "\(one.overallRating)"
            if (UIImage(named: "player\(one.playerID)") != nil) {
                cell.oneImageView.image = UIImage(named: "player\(one.playerID)")
            }
            else {
                cell.oneImageView.image = UIImage(named: "emptyFace")
            }
            
            if(one.overallRating == 0){
                cell.oneNameLabel.isHidden = true
                cell.oneRatingLabel.isHidden = true
            }
            else{
                cell.oneNameLabel.isHidden = false
                cell.oneRatingLabel.isHidden = false
            }
        }
        if let two = two{
            cell.twoNameLabel.text = "\(two.name)"
            cell.twoRatingLabel.text = "\(two.overallRating)"
            if (UIImage(named: "player\(two.playerID)") != nil) {
                cell.twoImageView.image = UIImage(named: "player\(two.playerID)")
            }
            else {
                cell.twoImageView.image = UIImage(named: "emptyFace")
            }
            
            if(two.overallRating == 0){
                cell.twoNameLabel.isHidden = true
                cell.twoRatingLabel.isHidden = true
            }
            else{
                cell.twoNameLabel.isHidden = false
                cell.twoRatingLabel.isHidden = false
            }
        }
        if let three = three{
            cell.threeNameLabel.text = "\(three.name)"
            cell.threeRatingLabel.text = "\(three.overallRating)"
            if (UIImage(named: "player\(three.playerID)") != nil) {
                cell.threeImageView.image = UIImage(named: "player\(three.playerID)")
            }
            else {
                cell.threeImageView.image = UIImage(named: "emptyFace")
            }
            if(three.overallRating == 0){
                cell.threeNameLabel.isHidden = true
                cell.threeRatingLabel.isHidden = true
            }
            else{
                cell.threeNameLabel.isHidden = false
                cell.threeRatingLabel.isHidden = false
            }
        }
        if let four = four{
            cell.fourNameLabel.text = "\(four.name)"
            cell.fourRatingLabel.text = "\(four.overallRating)"
            if (UIImage(named: "player\(four.playerID)") != nil) {
                cell.fourImageView.image = UIImage(named: "player\(four.playerID)")
            }
            else {
                cell.fourImageView.image = UIImage(named: "emptyFace")
            }
            if(four.overallRating == 0){
                cell.fourNameLabel.isHidden = true
                cell.fourRatingLabel.isHidden = true
            }
            else{
                cell.fourNameLabel.isHidden = false
                cell.fourRatingLabel.isHidden = false
            }
        }
        if let five = five{
            cell.fiveNameLabel.text = "\(five.name)"
            cell.fiveRatingLabel.text = "\(five.overallRating)"
            if (UIImage(named: "player\(five.playerID)") != nil) {
                cell.fiveImageView.image = UIImage(named: "player\(five.playerID)")
            }
            else {
                cell.fiveImageView.image = UIImage(named: "emptyFace")
            }
            if(five.overallRating == 0){
                cell.fiveNameLabel.isHidden = true
                cell.fiveRatingLabel.isHidden = true
            }
            else{
                cell.fiveNameLabel.isHidden = false
                cell.fiveRatingLabel.isHidden = false
            }
        }
        if let six = six{
            cell.sixNameLabel.text = "\(six.name)"
            cell.sixRatingLabel.text = "\(six.overallRating)"
            if (UIImage(named: "player\(six.playerID)") != nil) {
                cell.sixImageView.image = UIImage(named: "player\(six.playerID)")
            }
            else {
                cell.sixImageView.image = UIImage(named: "emptyFace")
            }
            
            if(six.overallRating == 0){
                cell.sixNameLabel.isHidden = true
                cell.sixRatingLabel.isHidden = true
            }
            else{
                cell.sixNameLabel.isHidden = false
                cell.sixRatingLabel.isHidden = false
            }
            
        }
        if let seven = seven{
            cell.sevenNameLabel.text = "\(seven.name)"
            cell.sevenRatingLabel.text = "\(seven.overallRating)"
            if (UIImage(named: "player\(seven.playerID)") != nil) {
                cell.sevenImageView.image = UIImage(named: "player\(seven.playerID)")
            }
            else {
                cell.sevenImageView.image = UIImage(named: "emptyFace")
            }
            
            if(seven.overallRating == 0){
                cell.sevenNameLabel.isHidden = true
                cell.sevenRatingLabel.isHidden = true
            }
            else{
                cell.sevenNameLabel.isHidden = false
                cell.sevenRatingLabel.isHidden = false
            }
        }
        if let eight = eight{
            cell.eightNameLabel.text = "\(eight.name)"
            cell.eightRatingLabel.text = "\(eight.overallRating)"
            if (UIImage(named: "player\(eight.playerID)") != nil) {
                cell.eightImageView.image = UIImage(named: "player\(eight.playerID)")
            }
            else {
                cell.eightImageView.image = UIImage(named: "emptyFace")
            }
            if(eight.overallRating == 0){
                cell.eightNameLabel.isHidden = true
                cell.eightRatingLabel.isHidden = true
            }
            else{
                cell.eightNameLabel.isHidden = false
                cell.eightRatingLabel.isHidden = false
            }
        }
        if let nine = nine{
            cell.nineNameLabel.text = "\(nine.name)"
            cell.nineRatingLabel.text = "\(nine.overallRating)"
            if (UIImage(named: "player\(nine.playerID)") != nil) {
                cell.nineImageView.image = UIImage(named: "player\(nine.playerID)")
            }
            else {
                cell.nineImageView.image = UIImage(named: "emptyFace")
            }
            if(nine.overallRating == 0){
                cell.nineNameLabel.isHidden = true
                cell.nineRatingLabel.isHidden = true
            }
            else{
                cell.nineNameLabel.isHidden = false
                cell.nineRatingLabel.isHidden = false
            }
        }
        if let ten = ten{
            cell.tenNameLabel.text = "\(ten.name)"
            cell.tenRatingLabel.text = "\(ten.overallRating)"
            if (UIImage(named: "player\(ten.playerID)") != nil) {
                cell.tenImageView.image = UIImage(named: "player\(ten.playerID)")
            }
            else {
                cell.tenImageView.image = UIImage(named: "emptyFace")
            }
            if(ten.overallRating == 0){
                cell.tenNameLabel.isHidden = true
                cell.tenRatingLabel.isHidden = true
            }
            else{
                cell.tenNameLabel.isHidden = false
                cell.tenRatingLabel.isHidden = false
            }
        }
        if let eleven = eleven{
            cell.elevenNameLabel.text = "\(eleven.name)"
            cell.elevenRatingLabel.text = "\(eleven.overallRating)"
            if (UIImage(named: "player\(eleven.playerID)") != nil) {
                cell.elevenImageView.image = UIImage(named: "player\(eleven.playerID)")
            }
            else {
                cell.elevenImageView.image = UIImage(named: "emptyFace")
            }
            if(eleven.overallRating == 0){
                cell.elevenNameLabel.isHidden = true
                cell.elevenRatingLabel.isHidden = true
            }
            else{
                cell.elevenNameLabel.isHidden = false
                cell.elevenRatingLabel.isHidden = false
            }
        }
        cell.oneImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.oneTapped)))
        cell.oneImageView.isUserInteractionEnabled = true;
        cell.twoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.twoTapped)))
        cell.twoImageView.isUserInteractionEnabled = true;
        cell.threeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.threeTapped)))
        cell.threeImageView.isUserInteractionEnabled = true;
        cell.fourImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.fourTapped)))
        cell.fourImageView.isUserInteractionEnabled = true;
        cell.fiveImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.fiveTapped)))
        cell.fiveImageView.isUserInteractionEnabled = true;
        cell.sixImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.sixTapped)))
        cell.sixImageView.isUserInteractionEnabled = true;
        
        cell.sixImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.sixTapped)))
        cell.sixImageView.isUserInteractionEnabled = true;
        cell.sevenImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.sevenTapped)))
        cell.sevenImageView.isUserInteractionEnabled = true;
        cell.eightImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.eightTapped)))
        cell.eightImageView.isUserInteractionEnabled = true;
        cell.nineImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.nineTapped)))
        cell.nineImageView.isUserInteractionEnabled = true;
        cell.tenImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tenTapped)))
        cell.tenImageView.isUserInteractionEnabled = true;
        cell.elevenImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.elevenTapped)))
        cell.elevenImageView.isUserInteractionEnabled = true;
        
        cell.backgroundView = UIImageView(image: UIImage(named: "background")!)
        return cell
    }
    
}

class FourTwoThreeOneViewController: UIViewController {
    var playerArray: [Player] = []
    @IBOutlet weak var tableView: UITableView!
    let playerDataSource = PlayerDataSource()
    var one : Player?
    var two : Player?
    var three : Player?
    var four : Player?
    var five : Player?
    var six : Player?
    var eight : Player?
    var ten : Player?
    var seven : Player?
    var eleven : Player?
    var nine : Player?
    var selectedPlayer : Player?
    var selectedOwnOrBest: Int?
    var selectedPosition: Int?
    let myGreen = UIColor(hexString3: "#2d7205")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerDataSource.delegate = self
        self.view.backgroundColor = myGreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selected = selectedOwnOrBest{
            if(selected == 1){
                playerDataSource.loadListOfPlayers()
            }
            else{
                playerDataSource.loadListOfPlayersFor4231()
            }
        }
        setBackground()
    }
    
    func setBackground(){
        self.tableView.backgroundColor = myGreen
        self.tableView.alwaysBounceVertical = false
        self.tableView.allowsSelection = false
        self.navigationController!.navigationBar.tintColor = UIColor.black;
    }
    
    @objc func oneTapped(){
        self.selectedPlayer = one
        self.selectedPosition = 1
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }
    }
    @objc func twoTapped(){
        self.selectedPlayer = two
        self.selectedPosition = 2
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }   }
    @objc func threeTapped(){
        self.selectedPlayer = three
        self.selectedPosition = 3
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }  }
    @objc func fourTapped(){
        self.selectedPlayer = four
        self.selectedPosition = 4
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }   }
    @objc func fiveTapped(){
        self.selectedPlayer = five
        self.selectedPosition = 5
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }    }
    @objc func sixTapped(){
        self.selectedPlayer = six
        self.selectedPosition = 6
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }    }
    @objc func sevenTapped(){
        self.selectedPlayer = seven
        self.selectedPosition = 7
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }  }
    @objc func eightTapped(){
        self.selectedPlayer = eight
        self.selectedPosition = 8
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }   }
    @objc func nineTapped(){
        self.selectedPlayer = nine
        self.selectedPosition = 9
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }   }
    @objc func tenTapped(){
        self.selectedPlayer = ten
        self.selectedPosition = 10
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }    }
    @objc func elevenTapped(){
        self.selectedPlayer = eleven
        self.selectedPosition = 11
        
        if(selectedOwnOrBest == 1){
            self.performSegue(withIdentifier: "showPlayerDetails", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "selectPlayer", sender: self)
        }    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showPlayerDetails"){
            
            if(selectedOwnOrBest == 1){
                let destination = segue.destination as! PlayerDetailsViewController
                self.dismiss(animated: true)
                
                destination.selectedPlayer = self.selectedPlayer
                destination.fromFormations = -1
            }
        }
            
        else if (segue.identifier == "selectPlayer"){
            let destination = segue.destination as! PlayerSelectionViewController
            self.dismiss(animated: true)
            destination.selectedPosition = self.selectedPosition
            destination.lineUpOrComparison = 0
            destination.selectedFormation = "SelectedFourTwoThreeOne"
        }
    }
    @IBAction func homeButtonTapped(_ sender: Any) {
        let  vc =  self.navigationController?.viewControllers.filter({$0 is MainScreenViewController}).first
        self.navigationController?.popToViewController(vc!, animated: true)
    }
}



