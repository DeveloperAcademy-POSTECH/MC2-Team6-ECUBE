import Foundation
import SwiftUI
import Moya

let moyaService = MoyaProvider<TestServices>(plugins: [NetworkLoggerPlugin()])
var testImageData: ImageTestResponse?

struct GeneralAPI {
    static let baseURL = "http://13.124.90.96:8080"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmciLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY1NTA4ODY1NywiaWF0IjoxNjU1MDgzMjU3fQ.tJarmSRIK8vigZ_j3Mz_leFLVHPi1B3vvHCOGBqVzC8"
}

// API 목록들
enum TestServices {
    case login(param: LoginRequest) // 파라미터로 스트럭트가 들어갑니다.
    case imagePost(content: String, image: UIImage)
    case getTest
}
// LoginApi Request 양식
struct LoginRequest: Codable {
    var name: String
}
// LoginApi Response 양식
struct LoginResponse: Codable {
    let accessToken: String
    let isNewMember: Bool
    let refreshToken: String
    let userSettingDone: Bool
}
// ImageApi Response 양식
struct ImageTestResponse: Codable {
    let contentRecieved: String
    let imageName: String
}
// http method, URLSession task, header 작성 등을 케이스 분류
extension TestServices: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    // API 주소
    var path: String {
        switch self {
        case.login:
            return "/api/v1/test/login"
        case .imagePost:
            return "/api/v1/testing/image"
        case .getTest:
            return "/api​/v1​/testing​/test"
        }
    }
    // http method 종류
    var method: Moya.Method {
        switch self {
        case .login, .imagePost:
            return .post
        case .getTest:
            return .get
        }
    }
    // Task 종류
    var task: Task {
        switch self {
            // 일반 json 형식 요청
        case .login(let param):
            return .requestJSONEncodable(param)
            // MultiPart 요청
        case .imagePost(let content, let image):
            var multipartForm: [MultipartFormData] = []
            let imageData = image.pngData()
            multipartForm.append(MultipartFormData(provider: .data(Data(String(content).utf8)), name: "content"))
            multipartForm.append(MultipartFormData(provider: .data(imageData!), name: "image", fileName: "sample.png", mimeType: "sample/png"))
            return .uploadMultipart(multipartForm)
            
        case .getTest:
            return .requestPlain
        }
    }
    
    // 권한 요청
    var authorizationType: AuthorizationType? {
        switch self {
        case .login, .imagePost, .getTest:
            return nil
        }
    }
    // header부분 작성 형식
    var headers: [String: String]? {
        switch self {
        case .imagePost:
            return ["Content-Type": "multipart/form"]
        case .getTest:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json",
                    "Authorization": GeneralAPI.token]
        }
    }
}
