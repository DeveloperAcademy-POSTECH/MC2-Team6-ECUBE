import Foundation
import SwiftUI
import Moya

let moyaService = MoyaProvider<ServerCommunications>(plugins: [NetworkLoggerPlugin()])
var testImageData: ImageTestResponse?
var loadedImage: ImageGetResponse?

struct GeneralAPI {
    static let baseURL = "http://13.124.90.96:8080"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmciLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY1ODIxNTgwMSwiaWF0IjoxNjU1NjIzODAxfQ.grBYdobpNbQ80e-OdqAED0DD-jjRF10a-vaKam06fHk"
}

// MARK: MoyaTest의 코드들 옮긴 부분
// API 목록들
enum ServerCommunications {
    
    case login(param: LoginRequest) // 파라미터로 스트럭트가 들어갑니다.
    case imagePost(comment: String, polaroid: UIImage)
    case imageGet
    case voicemailPost(title: String, name: String, duration: String)
//    case voicemailPost(title: String)
    case voicemailListGet
    case voicemailGet(id: Int)
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

struct ImageGetResponse: Codable {
    let createdAt: String
    let giftPolaroidId: Int64
    let giftPolaroidImage: String
    let userNickName: String
}

// MARK: Voicemail related models
 struct VoicemailPostRequest {
    let title: String
    let data: MultipartFormData
 }

let randomLabelList = ["cassetteIcon01", "cassetteIcon02", "cassetteIcon03", "cassetteIcon04"]

struct VoicemailGetResponse: Codable {
    let giftVoiceMailID: Int
    let giftVoiceMailDuration, title, createdAt, userNickName: String
    
    let i = Int.random(in: 0..<4)

    enum CodingKeys: String, CodingKey {
        case giftVoiceMailID = "giftVoiceMailId"
        case giftVoiceMailDuration, title, createdAt, userNickName
    }
    
    func convertToVoicemail() -> Voicemail {
        let data = Voicemail(
            voiceMailId: self.giftVoiceMailID,
            title: self.title,
            createDate: self.createdAt,
            whoSent: {
                if i == 0 {
                    return self.userNickName
                } else {
                    return "유진"
                }
            }(),
            vmBackgroundColor: {
                
                if i == 0 {
                    return MailConstants.green
                } else {
                    return MailConstants.orange
                }
            }(),
            vmIconImageName: {
                return randomLabelList[i]
            }(),
            soundLength: self.giftVoiceMailDuration
        )
        return data
    }
}

struct SingleVoicemailResponse: Codable {
    let createdAt, title, userNickName, voiceMail: String
    let voiceMailID: Int

    enum CodingKeys: String, CodingKey {
        case createdAt, title, userNickName, voiceMail
        case voiceMailID = "voiceMailId"
    }
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
            
        case .imageGet:
            return "/api/v1/gifts/polaroids/1"
            
        case .voicemailPost, .voicemailListGet:
            return "/api/v1/gifts/voicemail"
            
        case .voicemailGet(let id):
            return "/api/v1/gifts/voicemail/\(id)"
            
        case .getData:
            return "/api​/v1​/testing​/test"
        }
    }
    
    // http method 종류
    var method: Moya.Method {
        switch self {
        case .login, .imagePost, .voicemailPost:
            return .post
            
        case .getData, .voicemailListGet, .voicemailGet, .imageGet:
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
            // title - Model의 title / name - 파일명 / duration - 녹음길이
        case .voicemailPost(let title, let name, let duration):

            var multipartForm: [MultipartFormData] = []
            let uploadTitle = title.data(using: .utf8) ?? Data()
            let uploadDuration = duration.data(using: .utf8) ?? Data()

            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            guard let audioFile: Data = try? Data(contentsOf: directoryContents[0])
            else {
                return .uploadMultipart(multipartForm)
            }
            
            multipartForm.append(MultipartFormData(provider: .data(audioFile), name: "voiceMail", fileName: "\(name).m4a", mimeType: "audio/m4a"))
            
            multipartForm.append(MultipartFormData(provider: .data(uploadTitle), name: "title"))
            
            multipartForm.append(MultipartFormData(provider: .data(uploadDuration), name: "voiceMailDuration"))
            
            return .uploadMultipart(multipartForm)
            
            // MARK: Voicemail List Get 요청, Voicemail Get 요청
        case .voicemailListGet, .voicemailGet:
            return .requestPlain
            
            // MARK: get test 요청
        case .getData:
            return .requestPlain
            
        case .imageGet:
            return .requestPlain
        }
    }
    
    // 권한 요청
    var authorizationType: AuthorizationType? {
        switch self {
            
        case .login, .imagePost, .getData, .voicemailPost:
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
            
        case .voicemailListGet:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer "+GeneralAPI.token]
            
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer "+GeneralAPI.token]
        }
    }
}
