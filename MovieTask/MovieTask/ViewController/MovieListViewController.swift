//
//  MovieListViewController.swift
//  MovieTask
//
//  Created by Mina Thabet on 04/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import UIKit
import MBProgressHUD

class MovieListViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Constant
    let viewModel: MovieSearchViewModel = MovieSearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
}

//MARK:- Helpers
extension MovieListViewController {
    func initView() {
        setupNavigationBar()
        initCommonTableView()
        viewModel.getMoviesList()
        bindViewModel()
    }
    
    // add search controller to navigation bar
    private func setupNavigationBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        //indicating whether the underlying content is obscured during a search
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    func bindViewModel() {
        
        viewModel.moviesCells.bindAndFire() { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.moviesSearchCells.bindAndFire() { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.showLoading.bind { [weak self] show in
            if self != nil  {
                if show {
                    MBProgressHUD.showAdded(to: self!.view, animated: true)
                }else {
                    MBProgressHUD.hide(for: self!.view, animated: true)
                }
            }
        }
    }
    
    func initCommonTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(cell: MovieCell.self)
    }
}


//MARK:- UI Table View Delegate, datasource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewModel.dataSourceMode {
        case .anyOrder:
            return 1
        case .search:
            return viewModel.moviesSearchCells.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch viewModel.dataSourceMode {
        case .anyOrder:
            return nil
        case .search:
            switch viewModel.moviesSearchCells.value[section] {
            case .search(let viewModel):
                return "\(viewModel.year)"
            default:
                return nil
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.dataSourceMode {
        case .anyOrder:
            return 0.00001
        case .search:
            return 44
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.dataSourceMode {
        case .anyOrder:
            return viewModel.moviesCells.value.count
        case .search:
            switch viewModel.moviesSearchCells.value[section] {
            case .search(let viewModel):
                return viewModel.movies.count
            default:
                return 1
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.dataSourceMode {
        case .anyOrder:
            switch viewModel.moviesCells.value[indexPath.row] {
            case .normal(let viewModel):
                let cell = tableView.dequeue() as MovieCell
                cell.viewModel = viewModel
                return cell
            case .error(let error):
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = error
                return cell
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = "No Result Found"
                return cell
            }
        case .search:
            switch viewModel.moviesSearchCells.value[indexPath.section] {
            case .search(let viewModel):
                 let cell = tableView.dequeue() as MovieCell
                 cell.viewModel = viewModel.movies[indexPath.row]
                 return cell
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = "No Result Found"
                return cell
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch viewModel.dataSourceMode {
        case .anyOrder:
            switch viewModel.moviesCells.value[indexPath.row] {
            case .normal(let viewModel):
                let main = UIStoryboard(name: "Main", bundle: nil)
                let vc = main.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
                vc.movieViewModel = viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("No Action")
            }
            
        case .search:
            switch viewModel.moviesSearchCells.value[indexPath.section] {
            case .search(let viewModel):
                let main = UIStoryboard(name: "Main", bundle: nil)
                let vc = main.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
                vc.movieViewModel = viewModel.movies[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("No Action")
            }
        }
        

    }
    
    
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterSearch(searchText: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
    }
    
    private func resetData() {
        self.navigationItem.searchController?.searchBar.text = nil
        self.navigationItem.searchController?.resignFirstResponder()
        self.viewModel.resetData()
    }
}

