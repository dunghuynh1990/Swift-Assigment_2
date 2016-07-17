//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//  TODO: add no network error label


/*
- [ ] Search results page
 - [x] Table rows should be dynamic height according to the content height.
 - [x] Custom cells should have the proper Auto Layout constraints.
 - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
 
- [ ] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
 - [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
 - [x] The filters table should be organized into sections as in the mock.
 - [x] You can use the default UISwitch for on/off states.
 - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
 - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

Search results page
 - [ ] Ntwork detection
 - [ ] Infinite scroll for restaurant results.
 - [ ] Implement map view of restaurant results.
Filter page
 - [ ] Implement a custom switch instead of the default UISwitch.
 - [x] Distance filter should expand as in the real Yelp app
 - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
 - [ ] Implement the restaurant detail page.
 - [ ] Reset all values
 - [ ] Save results from last search
*/

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {


    @IBOutlet weak var noResultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var businesses: [Business]!
    var totalResult = 0
    let meterConst: Float = 1609.344
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Find your restaurants..."
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        doSearch()
        tableView.tableFooterView = UIView()
    }
    
    // Perform the search.
    private func doSearch() {
        noResultLabel.hidden = true
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        tableView.hidden = true
        Business.searchWithTerm(searchBar.text!, completion: { (result:SearchResult!, error: NSError!) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if result != nil {
                self.totalResult = result.total!
                if self.totalResult != 0 {
                    self.businesses = result.businesses
                    self.tableView.reloadData()
                    self.tableView.hidden = false
                    self.noResultLabel.hidden = true
                    self.noResultLabel.text = ""
                }
                else {
                    self.totalResult = 0
                    self.noResultLabel.text = "No Results"
                    self.tableView.hidden = true
                    self.noResultLabel.hidden = false
                }
            }
        })
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filterViewController = navigationController.topViewController as! FilterViewController
        
        filterViewController.delegate = self
    }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }

}

extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        businesses.removeAll()
        searchBar.resignFirstResponder()
        doSearch()
    }
}

extension BusinessesViewController: FilterViewControllerDelegate {
    func filterViewControllerDelegate(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject], withSortMode sortMode: Int, withDistance distance:Float, withDeal deal:Bool) {
        //term
        var term: String?
        if !searchBar.text!.isEmpty {
            term = searchBar.text
        }
        let categories  = filters["categories"] as? [String]
        let meterConst: Float = 1609.344
        let radiusValue = distance * meterConst
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        tableView.hidden = true
        Business.searchWithTermAndFilters(term, sort: sortMode, radius:radiusValue, categories: categories, deals: deal, offset:nil) { (result:SearchResult!, error:NSError!) in
            self.noResultLabel.hidden = true
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if result != nil {
                self.totalResult = result.total!
                if self.totalResult != 0 {
                    self.businesses = result.businesses
                    self.tableView.reloadData()
                    self.tableView.hidden = false
                    self.noResultLabel.hidden = true
                    self.noResultLabel.text = ""
                }
                else {
                    self.totalResult = 0
                    self.noResultLabel.text = "No Results"
                    self.tableView.hidden = true
                    self.noResultLabel.hidden = false
                }
            }
            }
    }
}