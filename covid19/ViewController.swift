//
//  ViewController.swift
//  covid19
//
//  Created by 서원지 on 2021/10/25.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var totalCaseLabel: UILabel!
    @IBOutlet var newCaseLabel: UILabel!
    @IBOutlet var labelStackView: UIStackView!
    @IBOutlet var IndicatorView: UIActivityIndicatorView!
    @IBOutlet var pieChartView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.IndicatorView.startAnimating()
        self.fetchCoviedOvervie(completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.IndicatorView.stopAnimating()
            self.IndicatorView.isHidden = true
            self.labelStackView.isHidden = false
            self.pieChartView.isHidden = false
            switch result{
            case let .success(result):
                self.configureStackView(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.congigureChartView(covidOverviewList: covidOverviewList)
            case let .failure(error):
                debugPrint("error \(error)")
            }
        } )
        // Do any additional setup after loading the view.
    }
    func makeCovidOverviewList(
        cityCovidOverview: CityCoviedOverview
    ) -> [CoviedOverview] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju,
        ]
    }
    
    func congigureChartView(covidOverviewList: [CoviedOverview]){
        self.pieChartView.delegate = self
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else{ return nil }
            return PieChartDataEntry(value: self.removerFormatString(string: overview.newCase),
            label: overview.countryName,
            data: overview )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.material()
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rawRotationAngle, toAngle: self.pieChartView.rawRotationAngle + 80)
    }
    
    func removerFormatString(string: String) -> Double{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    func configureStackView(koreaCovidOverview: CoviedOverview){
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase)명"
    }

    func fetchCoviedOvervie(
        completionHandler: @escaping (Result<CityCoviedOverview, Error>) -> Void
    ){
    let url = "https://api.corona-19.kr/korea/country/new/"
    let param = [
        "serviceKey" : "MVSon7tQsNF49bgWjwCUBGu3dRXyaTLEc"
    ]
        
        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { response in
                switch response.result {
                case let.success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCoviedOverview.self, from: data)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
                
    })
 }
}

extension ViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let CovidDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailViewController") as?  CovidDetailViewController else { return }
        guard let covidOverview = entry.data as? CoviedOverview else { return }
        CovidDetailViewController.covidOverview = covidOverview
        self.navigationController?.pushViewController(CovidDetailViewController, animated: true)
    }
}
