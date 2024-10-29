import UIKit
import SnapKit

final class ViewDetailsController: UIViewController {

    private let student: Student

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let photoImageViewShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        
        return view
        
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        
        return label
    }()
    
    init(student: Student) {
        self.student = student
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupLayout()
        setupDetails(with: student)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(photoImageViewShadow)
        photoImageViewShadow.addSubview(photoImageView)

        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(addressLabel)
    }

    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        photoImageViewShadow.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(300)
        }

        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(photoImageViewShadow.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        ageLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(nameLabel)
        }

        addressLabel.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(nameLabel)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }


    private func setupDetails(with student: Student) {

        if let imageName = student.imageName, let image = UIImage(named: imageName) {
            photoImageView.image = image
        } else {
            photoImageView.image = UIImage(systemName: "person.crop.circle")
        }

        nameLabel.text = "\(student.name ?? "N/A")"
        ageLabel.text = "Age: \(student.age ?? 0)"

        if let address = student.address {
            var addressText = "Address: "
            addressText += "\(address.street), "
            addressText += "\(address.city)"
            if let postalCode = address.postalCode {
                addressText += ", \(postalCode)"
            }
            addressLabel.text = addressText
        } else {
            addressLabel.text = "Address: N/A"
        }
    }
}
