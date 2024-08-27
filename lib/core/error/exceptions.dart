import 'package:ekang_flutter/core/resources/auth_response_messages.dart';

class Exceptions implements Exception {
  static String handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 1:
        return AuthResponseMessages.AUTH_ERROR_UNKNOWN2;

      case 2:
        return AuthResponseMessages.WRONG_PASSWORD2;

      case 3:
        return AuthResponseMessages.ACCESS_DENIED2;

      case 10:
        return AuthResponseMessages.INTERNAL_ERROR2;

      case 11:
        return AuthResponseMessages.SESSION_EXISTE2;

      case 12:
        return AuthResponseMessages.AUTHORIZATION_EXPIRED2;

      case 15:
        return AuthResponseMessages.PASSWORD_NEED_REINIT;

      case 16:
        return AuthResponseMessages.USER_ALREADY_CONNECTED2;

      case 17:
        return AuthResponseMessages.LDAP_UNKNOWN2;

      case 18:
        return AuthResponseMessages.DEVICE_ALREADY_LINKED_TO_A_SESSION2;

      case 23:
        return AuthResponseMessages.SET_NEW_PASSWORD_NO_REINIT_ASKED;

      case 24:
        return AuthResponseMessages.LDAP_SERVER_NO_HTTP_CODE2;

      case 25:
        return AuthResponseMessages.LDAP_WRONG_TOKEN;

      case 26:
        return AuthResponseMessages.LDAP_UIDS_DIFFERENT_ESTABLISHMENT;

      case 27:
        return AuthResponseMessages.GDDA_ADMIN_RIGHTS_PROBLEM;

      case 28:
        return AuthResponseMessages.ADMIN_ACCESS_DENIED;

      case 29:
        return AuthResponseMessages.ADMIN_LDAP_UNKNOWN;

      case 30:
        return AuthResponseMessages.LDAP_SERVER_AUTH_NO_HTTP_CODE;

      case 31:
        return AuthResponseMessages.LDAP_SERVER_AUTH_NULL_RESPONSE;

      case 39:
        return AuthResponseMessages.LDAP_UID_NOT_INITIALIZED2;

      case 40:
        return AuthResponseMessages.LDAP_NOT_AUTHORIZED2;

      case 41:
        return AuthResponseMessages.TEMPORARY_BADGE2;

      case 42:
        return AuthResponseMessages.LDAP_RESTRICTED_USER2;

      case 43:
        return AuthResponseMessages.PIN_CHANGE_ME2;

      case 50:
        return AuthResponseMessages.LDAP_UNAVAILABLE2;

      case 51:
        return AuthResponseMessages.SCAN_CAB_BADGE2;

      case 52:
        return AuthResponseMessages.WRONG_PIN2;

      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }
}

class ServerException implements Exception {}

class CacheException implements Exception {}

class OfflineException implements Exception {}

class WeekPassException implements Exception {}

class ExistedAccountException implements Exception {}

class NoUserException implements Exception {}

class WrongPasswordException implements Exception {}

class TooManyRequestsException implements Exception {}
