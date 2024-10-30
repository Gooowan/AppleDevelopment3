import UIKit
import SnapKit
import Combine

enum StudentDetailControllerOutputMessage {
    case subjectSelected(String)
}

final class StudentDetailViewController: UIViewController {

    private let student: Student

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let subjectsTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let _outputPublisher = PassthroughSubject<StudentDetailControllerOutputMessage, Never>()
    var outputPublisher: AnyPublisher<StudentDetailControllerOutputMessage, Never> {
        _outputPublisher.eraseToAnyPublisher()
    }

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
        label.numberOfLines = 0
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

        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(photoImageViewShadow)
        photoImageViewShadow.addSubview(photoImageView)

        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(subjectsTableView)
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
        }

        subjectsTableView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(44 * (student.subjects?.count ?? 1))
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
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

extension StudentDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.subjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell") ?? UITableViewCell(style: .default, reuseIdentifier: "SubjectCell")

        if let subject = student.subjects?[indexPath.row] {
            var text = subject

            if let scores = student.scores, let scoreOptional = scores[subject] {
                if let scoreValue = scoreOptional {
                    text += ": \(scoreValue)"
                } else {
                    text += ": N/A"
                }
            } else {
                text += ": N/A"
            }

            cell.textLabel?.text = text
        } else {
            cell.textLabel?.text = "Unknown Subject"
        }

        cell.accessoryType = .disclosureIndicator
        return cell
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let subject = student.subjects?[indexPath.row] {
            _outputPublisher.send(.subjectSelected(subject))
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
