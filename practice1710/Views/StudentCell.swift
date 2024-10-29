import Foundation
import UIKit
import SnapKit

final class StudentCell: UITableViewCell {
    
    private let PFPhoto: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let PFPShadow: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    private let scholarshipLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let scholarshipStatus: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    
    public static let identifier = "StudentCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }

    
    init() {
        super.init(style: .default, reuseIdentifier: "StudentCell")
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            
            PFPhoto.image = nil
            nameLabel.text = nil
            ageLabel.text = nil
            scoreLabel.text = nil
            scholarshipLabel.text = nil
            scholarshipStatus.image = nil
        }
    
    private func setupLayout() {
            PFPhoto.snp.makeConstraints {
                $0.top.leading.bottom.equalToSuperview().inset(0)
                $0.width.equalTo(82)
            }
            
            PFPShadow.snp.makeConstraints {
                $0.top.leading.bottom.equalToSuperview().inset(10)
                $0.width.equalTo(82)
            }
            
            nameLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(10)
                $0.leading.equalTo(PFPhoto.snp.trailing).offset(10)
                $0.trailing.equalToSuperview().inset(6)
            }
            
            ageLabel.snp.makeConstraints {
                $0.top.equalTo(nameLabel.snp.bottom).offset(6)
                $0.leading.equalTo(nameLabel)
            }
            
            scoreLabel.snp.makeConstraints {
                $0.centerY.equalTo(ageLabel)
                $0.leading.equalTo(ageLabel.snp.trailing).offset(12)
                $0.trailing.lessThanOrEqualToSuperview().inset(6)
            }
            
            scholarshipLabel.snp.makeConstraints {
                $0.top.equalTo(ageLabel.snp.bottom).offset(6)
                $0.leading.equalTo(nameLabel)
            }
            
            scholarshipStatus.snp.makeConstraints {
                $0.centerY.equalTo(scholarshipLabel)
                $0.leading.equalTo(scholarshipLabel.snp.trailing).offset(6)
                $0.width.height.equalTo(20)
            }
            
            scholarshipLabel.snp.makeConstraints {
                $0.bottom.lessThanOrEqualToSuperview().inset(6)
            }
    }
    
    private func setupView() {
        
        contentView.addSubview(PFPShadow)
        PFPShadow.addSubview(PFPhoto)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(scholarshipLabel)
        contentView.addSubview(scholarshipStatus)
    }
    
    func setupCell(with student: Student) {
        
        if let imageName = student.imageName, let image = UIImage(named: imageName) {
                PFPhoto.image = image
            } else {
                PFPhoto.image = UIImage(systemName: "person.crop.circle")
            }
        
        nameLabel.text = student.name
        ageLabel.text = "Age: \(student.age ?? 0)"
        
        if let averageScore = student.averageScore {
                scoreLabel.text = String(format: "Score: %.2f", averageScore)
            } else {
                scoreLabel.text = "Score: N/A"
            }
        
        if let hasScholarship = student.hasScholarship {
            scholarshipLabel.text = "Scholarship:"
            let imageName = hasScholarship ? "checkmark.circle.fill" : "xmark.circle.fill"
            scholarshipStatus.image = UIImage(systemName: imageName)
        } else {
            scholarshipLabel.text = "Scholarship:"
            scholarshipStatus.image = UIImage(systemName: "questionmark.circle")
        }
    }
}
