class ApiEndpoints {
  //! Authentication Endpoints
  static const String SERVICE_PROVIDER_LOGIN  = "/auth/service-provider/sign-in";
  static const String SERVICE_PROVIDER_SIGNUP  = "/auth/service-provider/create";
  static const String SERVICE_PROVIDER_LOGOYT = "/auth/service-provider/sign-out";

  //! Article Endpoints
  static const String CREATE_ARTICLE = "/articles/create";
  static const String GET_ARTICLE_SUB_CATEGORY = "/articles/by-sub-category";
  static const String GET_SERVICE_PROVIDER_ARTICLES = "/articles/for-authenticated-provider";

  //! Media Endpoints
  static const String UPLOAD_MEDIA = "/media/upload";
  static const String GET_MEDIA = "/media/for-auth-service-provider";
  static const String UPDATE_MEDIA = "/media/update";
  static const String INITIATE_DRAFT = "/draft/initiate";
  static const String SAVE_DRAFT = "/draft/save";
  static const String GET_DRAFT = "/registration/get_draft/%s"; //! This uses sprintf formatting
  static const String CHECK_EMAIL = "/check/email";
  static const String CHECK_PHONE = "check/phone";

  //! Leads Endpoints
  static const String GET_LEADS = "/service-providers/leads";
}