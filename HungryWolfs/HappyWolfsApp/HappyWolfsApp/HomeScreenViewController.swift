//
//  HomeScreenViewController.swift
//  HomeScreenViewController
//
//  Created by Wolfpack Digital on 03.08.2021.
//

import UIKit
import Alamofire

class HomeScreenViewController: UIViewController, UISearchBarDelegate {

    
    let arr:[String] = ["vlad", "george", "paul", "dan", "alfie", "raducu", "pablo", "gigi", "vasi", "thomas"]
    let vct:[String] = ["vlad", "dan", "pablo", "gigi", "vasi", "thomas"]
    var selectedIndexPath: IndexPath?
    //var categories:[Category] = []
    //var arra = [Category]()
    var categories = [Category]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    func getMethod() {
        let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
        AF.request(url, parameters: nil, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                
                let decoder = JSONDecoder()
                if let jsonCategories = try? decoder.decode(Categories.self, from: prettyJsonData) {
                    DispatchQueue.main.async{
                                         
                        
                                      
                          self.categories = jsonCategories.categories
                          print(self.categories.count)
                    }
                        }
                


            
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.backgroundImage = UIImage()
        let layoutCategory = categoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoutCategory.estimatedItemSize = .zero
        let layoutFood = foodCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoutFood.estimatedItemSize = .zero
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        //categoryCollectionView.allowsMultipleSelection = false
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        //getMethod()
        //fetchData()

        
        
        
        //collectionView?.addGestureRecognizer(tapGestRecognizer)

        //collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: Bool, scrollPosition: //UICollectionView.ScrollPosition)
        
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMethod()
        print("*" + String(self.categories.count))
        //getData()
        //getMethodGOOD()
        //getMethodA()
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.categoryCollectionView){
            return arr.count
        }
        else{
            return vct.count
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == self.categoryCollectionView){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? categoryCollectionViewCell

        cell?.categoryLabel.text = arr[indexPath.row]
            
            if indexPath == selectedIndexPath{
                cell?.categoryView.isHidden = false
                cell?.categoryView.backgroundColor = .orange
                cell?.categoryLabel.textColor = .orange
            }
            else{
                cell?.categoryView.isHidden = true
               //cell?.categoryView.backgroundColor = .gray
                cell?.categoryLabel.textColor = .gray
            }
        
        //cell?.line.backgroundColor = .
        
           //let model = LIST_OF_YOUR_DATA_SOURCE[indexPath.row]
           //cell.configure(model)
        
        return cell!
        }
        else{
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as? FoodCollectionViewCell

            cellA?.foodLabel.text = arr[indexPath.row]
            cellA?.foodImage.layer.cornerRadius = 70
            cellA?.foodImage.layer.shadowColor = UIColor.black.cgColor
            cellA?.foodImage.layer.shadowOpacity = 4
            cellA?.foodImage.layer.shadowOffset = .zero
            cellA?.foodImage.layer.shadowRadius = 15
            cellA?.foodImage.image = UIImage(named:"background")
            
            cellA?.foodView.layer.cornerRadius = 20
        
            
            
            
            //cell?.line.backgroundColor = .
            
               //let model = LIST_OF_YOUR_DATA_SOURCE[indexPath.row]
               //cell.configure(model)
            
            return cellA!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? categoryCollectionViewCell
        if collectionView == self.foodCollectionView{
            print("*")
        }
        else{
            if let toDeleteCell = categoryCollectionView .cellForItem(at: selectedIndexPath ?? IndexPath(   item:0, section: 0 )){
                cell?.categoryView.isHidden = true
                //cell?.categoryView.backgroundColor = .gray
                cell?.categoryLabel.textColor = .gray
                //print(selectedIndexPath)
                //categoryCollectionView.reloadItems(at: [selectedIndexPath])
                categoryCollectionView.reloadData()
                
            }
            
            cell?.categoryView.isHidden = false
            cell?.categoryView.backgroundColor = .orange
            cell?.categoryLabel.backgroundColor = .orange
            selectedIndexPath = indexPath
            categoryCollectionView.reloadItems(at: [indexPath])
            
            //cell?.categoryLabel.backgroundColor
            //categoryCollectionView.reloadData()
            print("#")
        }

    
    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yCollectionViewOffset = collectionView.contentOffset
        //print("end scroll", y)
        var offsetToInt = Int((yCollectionViewOffset.x - 30) / 100 + 1)
        let indexpath = IndexPath(item: offsetToInt, section: 0)
        let cell = self.collectionView.cellForItem(at: indexpath as IndexPath) as? categoryCollectionViewCell
        self.collectionView.visibleCells.forEach { cell in
            (cell as? categoryCollectionViewCell)?.line.backgroundColor = .gray
        }
        cell?.line.backgroundColor = .orange
        
        //collectionView.reloadItems(at: [indexpath])
        //collectionView.reloadData()
        
    }
     */
    
    
}
}
