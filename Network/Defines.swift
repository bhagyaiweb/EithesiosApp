//
//  Defines.swift
//  NicoBeacon
//
//  Created by Vinay on 21/08/17.
//  Copyright © 2017 iWeb. All rights reserved.
//

import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

class Defines: NSObject
{
    static let kStartColor = UIColor(red: 179.0/255.0, green: 18.0/255.0, blue: 23.0/255.0, alpha: 1.0).cgColor
    static let kEndColor = UIColor(red: 246.0/255.0, green: 106.0/255.0, blue: 101.0/255.0, alpha: 1.0).cgColor
    static let kRequestGradientColorArray = [UIColor(red: 108.0/255.0, green: 152.0/255.0, blue: 254.0/255.0, alpha: 1.0).cgColor,
                                        UIColor(red: 216.0/255.0, green: 232.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
    static let kChatRequestGradientColorArray = [UIColor(red: 255.0/255.0, green: 165.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor,
                                                 UIColor(red: 255.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor]
    static let kGroupRequestGradientColorArray = [UIColor(red: 87.0/255.0, green: 176.0/255.0, blue: 196.0/255.0, alpha: 1.0).cgColor,
                                                 UIColor(red: 189.0/255.0, green: 239.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor]
    static let kTextViewUnderLineColor = UIColor.gray.cgColor
 
    // MARK: Message
    static let alterTitle = "Alert!"
    static let successTitle = "Success!"
    static let invalidEmail = "Please fill valid email address."
    static let password = "Please fill valid password."
    static let loginErrorMessage = "Please check your internet connection"
    static let underDevelopmentMessageMessage = "Underdevelopment"
    static let noRecordFound = "No Record Found!"
    static let noInterNet = "Please check your internet connection"
    static let blankUserName = "Please enter Username!"
    static let networkErrorMessage = "Please check your internet connection"
    static let deleteDeviceAlertMessage = "Are you sure to remove this device?"
    
    // MARK: API
    static let ServerUrl = "http://178.62.83.145:7000/api/v1/"
    static let ImageUrl = "https://www.phaseapp.net:3002/"
    //"http://178.62.83.145:3002/api/"
    //"http://67.205.173.26:3000/api/"
    static let register = "signup"
    static let signIn = "user_login"
    static let dashboard_Data = "dashboard_data"
    static let update_profile = "update_profile"
    static let view_profile = "view_profile"
    static let getFireDepartmentList = "get_police_department_employee"
    static let getPoliceDepartmentList = "get_fire_department_list"
    static let getVehicleList = "vehicle_list"
    static let UploadVehicleRegistration = "vehicle_registration"
    static let deleteVehicle = "delete_vehicle"
    static let getInsuredVehicles = "insurance_list"
    static let UploadVehicleInsurance = "upload_vehicle_insurance"
    static let deleteVehicleInsurance = "delete_insurance"
    static let GetAttorneyList = "attorney_list"
    static let GetBailBondList = "bail_bond_lists"
    static let getVideoList = "get_self_video"
    static let selfHelpVideo = "upload_self_video"
    static let getDrivingLicenceList = "license_list"
    static let deleteDrivingList = "delete_license"
    static let uploadDL = "upload_driver_license"
    static let uploadConnection = "save_my_connections"
    static let getmyConnectionList = "my_connections"
    static let deleteConnection = "delete_connection"
    static let getPDList = "police_department_details"
    static let getElectedOfficerList = "elected_officer"
    static let getGovernmentEmployee = "government_employee"
    static let getTrackerList = "tracker_list"
        
    static let resendOTP = "users/resendotp"
    static let forgotPassword = "users/forgetpassword"
    static let countryList = "users/countryList"
    static let addPost = "posts/addPost"
    static let getPost = "posts/getUserPost/"
    static let getOtherUserPost = "posts/getOtherUserPost/"
    
    static let search = "users/search"
    static let addEvent = "posts/addEvent"
    static let addComment = "posts/commentPost"
    static let deletePost = "posts/deletepost/"
    static let friendRequest = "users/receiveFriendRequestList/"
    static let sendFriendRequest = "users/sendfriendrequest"
    static let changeFriendStatus = "users/changeFriendStatus"
    static let getAroundPost = "posts/getAroundPost"
    static let getPublicPost = "posts/getPublicPost/"
    static let getFriendsPost = "posts/getFriendPost/"
    static let socialSignup = "users/signupSocial"
    static let socialCheck = "users/socialIdcheck"
    
    static let like = "posts/likePost"
    static let getProfile = "users/userProfile/"
    static let changeProfilePicture = "users/changeProfilePicture"
    static let changeCoverPicture = "users/changeCoverPicture"
    static let editProfile =  "users/editProfile"
    static let describeMe = "users/describeme"
    static let editProfession = "users/editProfession"
    static let editEducation = "users/editEducation"
    static let editLocation = "users/editLocation"
    static let gallery = "users/getUserGallery/"
    static let notificationSettingsUpdate = "users/notificationSetting"
    static let changePassword = "users/changePassword"
    static let profileSettingsUpdate = "users/profileSetting"
    static let getFriendsList = "users/friendList/"
    static let getNotifications = "users/notificationlist/"
    static let reportPost = "posts/ReportPost"
    static let sharePost = "posts/sharePost"
    static let getAllCommentPostApi = "posts/allCommentOfPost"
    static let getAllLikesPostApi = "posts/likes_data"
    static let getViewUsersApi = "users/getEventUser/"
    static let JoinEventApi = "users/joinEvent"
    static let GetLeaveEventApi = "users/deleteevent/"
    static let UnfriendApi = "users/unfriend/"
    static let DeleteCommentApi = "posts/deleteComment/"
    static let getPostDetailApi = "posts/postDetail"

    //MARK: Group related API urls
    static let joinGroupApi = "groups/join_group"
    static let getGroupsList = "groups/getgroups/"
    static let createGroupApi = "groups/create_group"
    static let editGroup = "groups/update_group"
    static let getGroupDetails = "groups/groupProfile/"
    static let deleteGroup = "groups/delete/"
    static let uploadImage = "posts/uploadimg"
    static let getGroupPosts = "groups/getpostofgroup/"
    static let exitGroup = "groups/leave_group"
    static let inviteUsersToGroup = "groups/invitetogroup"
    static let groupUsers = "groups/usersfrom_group/"
    static let galleryGroup = "users/getGroupgallery/"
    static let groupInviteUsers = "groups/friendList"

    //MARK: Chat related API urls
    static let getChatNames = "users/getChatUser"
    static let searchChatNames = "users/chatUserSearch"
//    static let sendChatRequest = "users/sendfriendrequest"
    static let removeChat = "users/removechat"

    // MARK: Constants
    static let deviceType: String = "2"          // 2 for iOS.

    // MARK: Landmark API
    static let getLandmarkForIndia: String = "https://reverse.geocoder.api.here.com/6.2/reversegeocode.json?app_id=M7XJmdQhJqfHEbhwZ7Kg%20&app_code=Jd7WXq9IQiN_2jcAHoyFEg%20&mode=retrieveLandmarks&prox="
    
    static let getLandmarkForNonIndia: String = "https://api.opencagedata.com/geocode/v1/json?key=41768a012b6e4e3ab8db1c1b56bf26c3&q="
        
    static let placeholder = UIImage(named: "default")

}
