//import Foundation
//import UIKit
//import SnapKit
//
//final class DrinkCell: UITableViewCell {
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .bold)
//        return label
//    }()
//    
//    private let priceLabel: UILabel = {
//        let label = UILabel()
//        
//        label.font = .systemFont(ofSize: 16, weight: .heavy)
//        label.textColor = .orange
//        
//        return label
//    }()
//    
//    private let currencyLabel: UILabel = {
//        let label = UILabel()
//        
//        label.font = .systemFont(ofSize: 16, weight: .heavy)
//        label.textColor = .orange
//        
//        return label
//    }()
//    
//    private let ingredientsLabel: UILabel = {
//        let label = UILabel()
//        
//        return label
//    }()
//    
//    private let sizeIcon: UIImageView = {
//        let imageView = UIImageView()
//        
//        imageView.tintColor = .gray
//        
//        return imageView
//    }()
//    
//    private let sizeLabel: UILabel = {
//        let label = UILabel()
//        
//        label.textColor = .gray
//        
//        return label
//    }()
//    
//    private let imagePlaceHolder: UIView = {
//        let view = UIView()
//        
//        return view
//    }()
//    
//    public static let identifier = "drink"
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        currencyLabel.text = "UAH"
//        sizeIcon.image = UIImage.init(systemName: "flask.fill")
//        
//        setupView()
//        setupLayout()
//    }
//    
//    init() {
//        super.init(style: .default, reuseIdentifier: DrinkCell.identifier)
//        
//        currencyLabel.text = "UAH"
//        sizeIcon.image = UIImage.init(systemName: "flask.fill")
//        
//        setupView()
//        setupLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        titleLabel.text = nil
//        priceLabel.text = nil
//        ingredientsLabel.text = nil
//        sizeLabel.text = nil
//    }
//    
//    private func setupLayout() {
//        imagePlaceHolder.snp.makeConstraints {
//            $0.top.trailing.bottom.equalToSuperview().inset(6)
//            $0.width.equalTo(138)
//        }
//        
//        titleLabel.snp.makeConstraints {
//            $0.top.leading.equalToSuperview().inset(6)
//        }
//        
//        priceLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
//            $0.leading.equalTo(titleLabel)
//        }
//        
//        currencyLabel.snp.makeConstraints {
//            $0.leading.equalTo(priceLabel.snp.trailing).offset(3)
//            $0.bottom.equalTo(priceLabel)
//        }
//        
//        ingredientsLabel.snp.makeConstraints {
//            $0.top.equalTo(priceLabel.snp.bottom).offset(6)
//            $0.leading.equalTo(titleLabel)
//        }
//        
//        sizeIcon.snp.makeConstraints {
//            $0.top.equalTo(ingredientsLabel.snp.bottom).offset(6)
//            $0.leading.equalTo(titleLabel)
//        }
//        
//        sizeLabel.snp.makeConstraints {
//            $0.leading.equalTo(sizeIcon.snp.trailing).offset(3)
//            $0.bottom.equalTo(sizeIcon)
//        }
//    }
//    
//    private func setupView() {
////        backgroundColor = .red
//        imagePlaceHolder.backgroundColor = .green
//        
//        addSubview(titleLabel)
//        addSubview(priceLabel)
//        addSubview(currencyLabel)
//        addSubview(ingredientsLabel)
//        addSubview(sizeIcon)
//        addSubview(sizeLabel)
//        addSubview(imagePlaceHolder)
//    }
//    
//    func setupCell(with drink: Drink) {
//        titleLabel.text = drink.name
//        priceLabel.text = drink.price.description
//        
//        ingredientsLabel.text = drink.ingredients
//        sizeLabel.text = drink.portionSize.description
//    }
//    
//}
//
//#if DEBUG
//
//import SwiftUI
//
//struct DrinkCell_Previews: PreviewProvider {
//    
//    static func makeCell() -> DrinkCell {
//        let cell = DrinkCell()
//        
//        // write cell.setupCell(with .init for students)
//        
//        cell.setupCell(with: .init()
//        
//        
//        
//        cell.setupCell(with: .init(name: "Coca-Cola", price: 100, ingredients: "Water, Sugar, Caramel", portionSize: 500))
//                       
//        return cell
//    }
//    
//    static var previews: some View {
//        Group {
//            makeCell()
//                .asPreview()
//                .frame(height: 150)
//        }
//    }
//}
//
//extension UIViewController {
//    @available(iOS 13, *)
//    private struct Preview: UIViewControllerRepresentable {
//        var viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//            // No-op
//        }
//    }
//
//    @available(iOS 13, *)
//    func asPreview() -> some View {
//        Preview(viewController: self)
//    }
//}
//
//// MARK: - UIView Extensions
//
//extension UIView {
//    @available(iOS 13, *)
//    private struct Preview: UIViewRepresentable {
//        var view: UIView
//
//        func makeUIView(context: Context) -> UIView {
//            view
//        }
//
//        func updateUIView(_ view: UIView, context: Context) {
//            // No-op
//        }
//    }
//
//    @available(iOS 13, *)
//    func asPreview() -> some View {
//        Preview(view: self)
//    }
//}
//
//
//#endif
//
//
