class Constants {
  // static const String imagesUrl = 'http://172.16.19.96/school3/';
  // static const String imagesUrl2 = 'http://172.16.19.96/school3';
  static const String getstudentsubjectUrl = 'webservice/getstudentsubject';
  static const String authUrl = 'auth/faculityLogin';//'auth/login';
  static const String getHomeworkUrl = 'webservice/getHomework';
  static const String getClassTimeTableUrl = 'webservice/class_schedule';
  static const String getNotificationsUrl = 'webservice/getNotifications';
  static const String getsyllabussubjectsUrl = 'webservice/getsyllabussubjects';
  static const String getSubjectsLessonsUrl = 'webservice/getSubjectsLessons';
  static const String getAttendenceRecordsUrl = 'webservice/getAttendenceRecords';
  static const String getDocumentUrl = 'webservice/getDocument';
  static const String getStudentProfileUrl = 'webservice/getStudentProfile';
  static const String gettransportUrl = 'webservice/getTransportRoute';
  static const String gettransportroutesUrl = 'webservice/gettransportroutes';
  static const String getApplyLeaveUrl = 'webservice/getApplyLeave';
  static const String addleaveUrl = 'webservice/addleave';
  static const String getExamScheduleUrl = 'webservice/getExamSchedule';
  static const String getExamListUrl = 'webservice/getExamList';
  static const String getExamResultUrl = 'webservice/getExamResult';
  static const String getFeestUrl = 'webservice/fees';
  static const String lessonPlanUrl = 'webservice/getlessonplan';
  static const String getdailyassignmentUrl = 'webservice/getdailyassignment';
  static const String getdownloadcontent = 'webservice/getDownloadsLinks';
  static const String getVideocontent = 'webservice/getVideoTutorial';
  static const String getTimelineUrl = 'webservice/getTimeline';
  static const String getCbseexamtimetableUrl = 'webservice/cbseexamtimetable';
  static const String getCbseexamresultUrl = 'webservice/cbseexamresult';
  /////////////////////////
  static const String findPermissionsUrl = 'webservice/findPermissions';

  // static const String getNotificationsUrl = 'webservice/getNotifications';




  static const String getHostelListUrl = 'webservice/getHostelList';
  static const String getLibraryBookIssuedsUrl = 'webservice/getLibraryBookIssued';
  static const String getVisitorsUrl = 'webservice/getVisitors';
  // static const int defaultAge = 30;


//admin apis routes
  static const String getClassListUrl = 'webservice/getClassList';
  static const String getSectionListUrl = 'webservice/getSectionBYClass';
  static const String getstudentAttendenceUrl = 'webservice/studentAttendence';
  static const String getApprove_leaveUrl = 'webservice/approve_leave';
  static const String getApprove_leave_byIdUrl = 'webservice/get_approve_leave_byId';
  static const String getStudent_by_class_sectionUrl = 'webservice/get_student_list';
  static const String getSaveApproveLeaveUrl = 'webservice/saveApproveLeave';
  static const String getRemove_ApproveLeaveUrl = 'webservice/remove_ApproveLeave';
  static const String getClasstimetablelistUrl = 'webservice/classtimetablelist';
  static const String getTimetablecreateUrl = 'webservice/timetablecreate';
  static const String getSubjectGroupByClassSectionUrl = 'webservice/getGroupByClassandSection';
  static const String getSaveNewTimeTableUrl = 'webservice/saveNewTimeTable';



  /// Student Information


  static const String studentDetails = 'webservice/getStudentsByClassSection';
  static const String searchStudentInfo = 'webservice/getStudentsBySearch';
  static const String dailyattendancereport = 'webservice/dailyattendancereport';

  /// Homework
  static const String addHomeWork = 'webservice/createHomeWork';
  static const String subjectGroup = 'webservice/getGroupByClassandSection';
  static const String subject = 'webservice/getGroupsubjects';
  static const String closeHomework = 'webservice/closehomeworklist';
  static const String homework = 'webservice/gethomeworklist';

  /// Front Office
  static const String admissionEnquiry = 'enquiry/getEnquiryList';
  static const String addEntry = 'enquiry/add';
  static const String followUp = 'enquiry/follow_up';
  static const String followUpList = 'enquiry/follow_up_list';
  static const String addFollowUp = 'enquiry/follow_up_insert';

  //chat
  static const String getRecentChatUrl = 'conversations';
  static const String getChatUrl = 'users/';
  static const String sendTextMessageUrl = 'send-message';
  static const String sendReadMessageUrl = 'read-message';
  static const String getNoticeBoardUrl = 'notification/notificationList';


  //downloadcenter apis
  static const String getcontenttypelistUrl = 'contenttype/getcontenttypelist';
  static const String save_content_typeUrl = 'contenttype/save_content_type';
  static const String getcontenttypebyidUrl = 'contenttype/getcontenttypebyid';
  static const String contenttypeeditUrl = 'contenttype/edit';
  static const String contenttypedeleteUrl = 'contenttype/delete';

  static const String getuploaddataUrl = 'content/getuploaddata';
  static const String deleteuploaddataUrl = 'content/delete';
  static const String ajaxuploadUrl = 'content/ajaxupload';
  static const String contentShareUrl = 'content/share';
  static const String contentShareListUrl = 'content/getsharelist';
  static const String getUserRoleListUrl = 'content/getUserRoleList';


  static const String getAllStudentsGaurdianListUrl = 'content/getAllStudentsGaurdian';
  static const String getAllStaffListUrl = 'content/getAllStaff';
  static const String getAllParentListUrl = 'content/getAllParent';

  static const String getVideoTutorialListUrl = 'video_tutorial/getVideoTutorialList';
  static const String getVideoTutorialListBySearchUrl = 'video_tutorial/getVideoTutorialListBySearch';

  /// Library Apis
  static const String getAllBookUrl = 'book/getall';
  static const String getBookByIdUrl = 'book/getBookById';
  static const String crateBookUrl = 'book/create';
  static const String updateBookByIdUrl = 'book/updateBookById';
  static const String deleteBookByIdUrl = 'book/delete';
  static const String getMemberListUrl = 'member/membersList';
  static const String getMemberDetailsUrl = '/member/getMemberDetails';

/// section api

  static const String getSectionList = '/sections/getSectionList';
  static const String deleteSectionList = '/sections/delete';
  static const String editSectionList = '/sections/edit';
  static const String addSectionList = '/sections/add';

  /// subject
  static const String getSubjectList = '/subject/getSubjectList';
  static const String addSubjectList = '/subject/add';
  static const String editSubjectList = '/subject/edit';
  static const String deleteSubjectList = '/subject/delete';
  static const String viewSubject = '/subject/view';

  /// class
  static const String getClassList = '/classes/classList';
  static const String addClass = '/classes/add';
  static const String deleteClass = '/classes/delete';
  static const String viewClass = '/classes/view';
  static const String editClass = '/classes/edit';

  ///  gallery
  static const String getGalleryList = '/gallery/galleryList';
  static const String deleteGalleryList = '/gallery/delete';
  static const String createGalleryList = '/gallery/create';
  static const String viewGalleryList = '/gallery/view';
  static const String editGalleryList = '/gallery/edit';


  ///  Event
  static const String getEventList = '/events/eventList';
  static const String deleteEventList = '/events/delete';
  static const String createEventList = '/events/create';
  static const String viewEventList = '/events/view';
  static const String editEventList = '/events/edit';

  ///  Notice
  static const String getNoticeList = '/notice/noticeList';
  static const String deleteNoticeList = '/notice/delete';
  static const String createNoticeList = '/notice/create';
  static const String viewNoticeList = '/notice/view';
  static const String editNoticeList = '/notice/edit';

  /// subjectGroup
  static const String getSubjectGroupList = '/subjectgroup/getSubjectGroupList';
  static const String addSubjectGroupList = '/subjectgroup/add';
  static const String editSubjectGroupList = '/subjectgroup/edit';
  static const String deleteSubjectGroupList  = '/subjectgroup/delete';
  static const String viewSubjectGroup = '/subjectgroup/view';


  /// promote student
  static const String getAllSessionList = '/stdtransfer/getAllSession';


  ///fees
  static const String balanceFeeListUrl = 'webservice/studentbalancefeereport';
  static const String dailycollectionreportUrl = 'webservice/dailycollectionreport';

  /// HR  webservice/getStaffList
  static const String getStaffList = 'webservice/getStaffList';


  /// media Manager
  static const String getAllMediaList = '/media/getAllMedia';
  static const String getMediaTypeList = '/media/getMediaTypeList';
  static const String deleteMediaItem = '/media/deleteItem';
  static const String addMediaImage = '/media/addImage';
  static const String addMediaVideo = '/media/addVideo';


  /// leave request
  static const String getLeaverequest = '/leaverequest/leaverequest';
  static const String removeLeaverequest = '/leaverequest/remove';


  /// approve leave request
  static const String getStaffleaverequest = '/leaverequest/staffleaverequest';


}