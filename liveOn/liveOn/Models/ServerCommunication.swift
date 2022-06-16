import Foundation
import SwiftUI
import Moya

let moyaService = MoyaProvider<ServerCommunications>(plugins: [NetworkLoggerPlugin()])
var testImageData: ImageTestResponse?

struct GeneralAPI {
    static let baseURL = "http://13.124.90.96:8080"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmciLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY1NzkzMDM2MCwiaWF0IjoxNjU1MzM4MzYwfQ.am7ufGAV-O3xwRBNCybcJbD9d-Pb75XAgyy_QUtHLCY"
}

// MARK: MoyaTest의 코드들 옮긴 부분
// API 목록들
enum ServerCommunications {
  
    case login(param: LoginRequest) // 파라미터로 스트럭트가 들어갑니다.
    case imagePost(comment: String, polaroid: UIImage)
    case voicemailPost(title: String)
    case getData
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
extension ServerCommunications: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    // API 주소
    var path: String {
        switch self {
        case.login:
            return "/api/v1/test/login"
            
        case .imagePost:
            return "api/v1/gifts/polaroids"
            
        case .voicemailPost:
            return "/api/v1/gifts/voicemail"
            
        case .getData:
            return "/api​/v1​/testing​/test"
        }
    }
    
    // http method 종류
    var method: Moya.Method {
        switch self {
        case .login, .imagePost, .voicemailPost:
            return .post
        case .getData:
            return .get
        }
    }
    
    // Task 종류
    var task: Task {
        switch self {
            // MARK: 일반 json 형식 요청
        case .login(let param):
            return .requestJSONEncodable(param)
            
            // MARK: MultiPart 요청
        case .imagePost(let comment, let polaroid):
            var multipartForm: [MultipartFormData] = []
            let imageData = polaroid.pngData()
            multipartForm.append(MultipartFormData(provider: .data(Data(String(comment).utf8)), name: "comment"))
            multipartForm.append(MultipartFormData(provider: .data(imageData!), name: "polaroid", fileName: "sample.png", mimeType: "sample/png"))
            return .uploadMultipart(multipartForm)
            
            // MARK: Voicemail Post 요청
        case .voicemailPost(let title):
            
            var multipartForm: [MultipartFormData] = []
            
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
//            let audioURLPath = Bundle.main.path(forResource: title, ofType: "m4a")
//            let audioURL = URL(fileURLWithPath: audioURLPath!)
            
            guard let audioFile: Data = try? Data(contentsOf: directoryContents[0])
            else {
                print("")
                return .uploadMultipart(multipartForm)
            }
            
            multipartForm.append(MultipartFormData(provider: .data(audioFile), name: "voiceMail", fileName: "\(title).m4a", mimeType: "audio/m4a"))
            
            return .uploadMultipart(multipartForm)
            
            // MARK: get test 요청
        case .getData:
            return .requestPlain
        }
    }
    
    // 권한 요청
    var authorizationType: AuthorizationType? {
        switch self {
            
        case .login, .imagePost, .getData:
            return nil
            
        default:
            return .bearer
            
        }
    }
    // header부분 작성 형식
    var headers: [String: String]? {
        switch self {
            
        case .imagePost, .voicemailPost:
            return ["Content-Type": "multipart/form",
                    "Authorization": "Bearer "+GeneralAPI.token]
            
        case .getData:
            return ["Content-Type": "application/json"]
            
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer "+GeneralAPI.token]
        }
    }
}
