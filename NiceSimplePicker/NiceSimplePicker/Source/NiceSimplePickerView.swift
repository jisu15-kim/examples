//
//  NiceSimplePicker.swift
//  NiceSimplePicker
//
//  Created by Jisu Kim on 2023/09/16.
//

import UIKit
import SnapKit

class NiceSimplePickerView: UIViewController {
    //MARK: - Public Properties
    /// picking capsule's inset
    public var contentInset: CGFloat = 10
    /// picker dataSource
    public var dataSource: [NiceSimplePickerConfig] = []
    /// tintColor
    public var tintColor: UIColor = .systemIndigo
    /// 선택된 데이터
    public var selectedData: NiceSimplePickerConfig?
    /// header text
    public var headerText: String?
    /// cell spacing
    public var cellSpacing: CGFloat = 10
    /// tag(구분자)
    public var tag = 0
    /// delegate
    weak var delegate: NiceSimplePickerDelegate?
    
    //MARK: - Private Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(NiceSimplePickerCell.self, forCellWithReuseIdentifier: NiceSimplePickerCell.identifier)
        cv.isScrollEnabled = false
        cv.contentInset = UIEdgeInsets(top: 0, left: contentInset, bottom: 0, right: contentInset)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    /// cell height
    private var cellHeight: CGFloat = 40
    
    private let emptyView = UIView()
    
    /// Datasource의 count를 기반으로 collectionView의 height를 계산해 반환
    var collectionViewHeight: CGFloat {
        // 데이터 소스 count에 기반한 line 수 구하기
        let lineCount = round(Float(dataSource.count) / 2)
        // cellheight와 line 수 더하기
        var height = cellHeight * CGFloat(lineCount)
        // cellSpacing 추가
        height += CGFloat(lineCount - 1) * cellSpacing
        return height
    }
    
    //MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.addDismissGesture()
    }
    
    //MARK: - Methods
    private func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.addSubview(titleHeaderLabel)
        titleHeaderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(contentInset)
            $0.height.equalTo(20)
            $0.top.equalToSuperview().inset(20)
        }
        
        containerView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(titleHeaderLabel.snp.top)
            $0.trailing.equalToSuperview().inset(contentInset)
            $0.width.height.equalTo(25)
        }
        
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleHeaderLabel.snp.bottom).inset(-16)
            $0.height.equalTo(collectionViewHeight)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        self.view.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.top)
        }
        
        self.titleHeaderLabel.text = self.headerText
    }
    
    /// 빈 영역 터치시 dismiss 제스처
    private func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonTapped))
        emptyView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissButtonTapped() {
        self.dismiss(animated: true)
    }
}

//MARK: - DataSource
extension NiceSimplePickerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NiceSimplePickerCell.identifier, for: indexPath) as? NiceSimplePickerCell else { return UICollectionViewCell() }
        let data = self.dataSource[indexPath.row]
        cell.cellTintColor = self.tintColor
        cell.pickerConfig = data
        
        if let selectedData = self.selectedData,
           // 선택한 데이터와 같다면, select 메소드 호출
           selectedData == data {
            self.setSelectedData(indexPath)
        }
        
        return cell
    }
    
    /// 선택한 데이터를 설정
    private func setSelectedData(_ indexPath: IndexPath) {
        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        self.collectionView.layoutIfNeeded()
    }
}

//MARK: - CollectionView Delegate
extension NiceSimplePickerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didTappedSelection(picker: self, index: indexPath.row)
        self.delegate?.didTappedSelection(picker: self, config: dataSource[indexPath.row])
        self.dismiss(animated: true)
    }
}

//MARK: - CollectionView FlowLayout
extension NiceSimplePickerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 컬렉션뷰 가로 길이에서
        var width = collectionView.frame.width
        // 좌우 inset을 빼주고
        width -= contentInset * 2
        // 가운데 spacing을 빼주고 2로 나눔
        width -= cellSpacing
        width /= 2
        return CGSize(width: width, height: cellHeight)
    }
}
