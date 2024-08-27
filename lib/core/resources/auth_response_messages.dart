class AuthResponseMessages {
  /////////////////////////////////////////
  // Collect Message update
  /////////////////////////////////////////
  static const String AUTH_ERROR_UNKNOWN2 =
      "L'utilisateur renseigné est inconnu";
  static const String ACCESS_DENIED2 =
      "Vous n'avez pas l'autorisation d'accéder à cette application, merci de contacter un administrateur";
  static const String INTERNAL_ERROR2 =
      "Le serveur d'authentification est indisponible pour le moment, merci de ré-essayer plus tard";
  static const String LDAP_SERVER_NO_HTTP_CODE2 =
      "Le serveur d'authentification ne répond pas:\\nProblème dû à l'accès a son référenciel de données";
  static const String WRONG_PASSWORD2 = "Login ou mot de passe incorrect";
  static const String SESSION_EXISTE2 =
      "Session déjà active pour un autre téléphone et lié à une tournée, merci de contacter un administrateur";
  static const String AUTHORIZATION_EXPIRED2 =
      "Votre autorisation d\\'accès a expiré, merci de contacter un administrateur";
  static const String USER_ALREADY_CONNECTED2 =
      "Une session est déjà lancé pour cet utilisateur";
  static const String DEVICE_ALREADY_LINKED_TO_A_SESSION2 =
      "Une session est déjà reliée à ce device";
  static const String LDAP_RESTRICTED_USER2 =
      "Vous n'êtes pas autorisé à initialiser les codes PIN";
  static const String LDAP_UNKNOWN2 = "Badge inconnu";
  static const String LDAP_NOT_AUTHORIZED2 =
      "Badge non autorisé, compte désactivé";
  static const String LDAP_UID_NOT_INITIALIZED2 =
      "Votre code PIN doit être initialisé, merci de contacter un administrateur de l\\'agence";
  static const String TEMPORARY_BADGE2 =
      "Badge provisoire ! \\nSaisie matricule impossible sans impression du badge du jour";
  static const String PIN_CHANGE_ME2 =
      "Erreur de saisie de code PIN (6 échecs), votre code PIN doit être réinitialisé, contacter un administrateur agence";
  static const String LDAP_UNAVAILABLE2 =
      "Service indisponible => utiliser le mode dégradé pour lancer la distri";
  static const String SCAN_CAB_BADGE2 =
      "Merci de scanner le CAB de votre badge. Saisie du matricule interdite !";
  static const String WRONG_PIN2 =
      "Le code PIN choisi est interdit, merci de le modifier !";

  /////////////////////////////////////////
  // Auth Message
  /////////////////////////////////////////
  static const String WRONG_PASSWORD = "Login ou mot de passe incorrect";
  static const String ACCESS_DENIED = "Accès refusé";
  static const String INTERNAL_ERROR =
      "Service indisponible : utiliser le mode dégradé pour lancer la distri";
  static const String PASSWORD_NEED_REINIT =
      "Votre code PIN doit être réinitialisé, merci de contacter un administrateur de l'agence";
  static const String LDAP_UNKNOWN = "Badge inconnu";
  static const String SET_NEW_PASSWORD_NO_REINIT_ASKED = "Unknown Ldap error";
  static const String LDAP_SERVER_NO_HTTP_CODE = "Unknown Ldap error";
  static const String LDAP_WRONG_TOKEN = "Login ou mot de passe incorrect";
  static const String LDAP_UIDS_DIFFERENT_ESTABLISHMENT = "Unknown Ldap error";
  static const String GDDA_ADMIN_RIGHTS_PROBLEM = "Unknown Ldap error";
  static const String ADMIN_ACCESS_DENIED = "Administrateur non autorisé";
  static const String ADMIN_LDAP_UNKNOWN = "Unknown Ldap error";
  static const String LDAP_SERVER_AUTH_NO_HTTP_CODE = "Unknown Ldap error";
  static const String LDAP_SERVER_AUTH_NULL_RESPONSE = "Unknown Ldap error";
  static const String LDAP_UID_NOT_INITIALIZED =
      "Votre code PIN doit être initialisé, merci de contacter un administrateur de l\\'agence";
  static const String LDAP_ACCESS_DENIED =
      "Badge non autorisé, compte désactivé";
  static const String REGISTRATION_NUMBER_PROHIBITED =
      "Merci de scanner le CAB de votre badge. Saisie du matricule interdite !";
  static const String CHOSEN_PIN_PROHIBITED =
      "Erreur de saisie de code PIN (6 échecs), votre code PIN doit être réinitialisé, contacter un administrateur agence";
  static const String PIN_MUST_BE_RESTED =
      "Le code PIN choisi est interdit, merci de le modifier !";
  static const String CHANGING_PIN_NOT_ALLOWED =
      "Vous n'êtes pas autorisé à modifier les codes PIN ! Merci de contacter un administreur.";
  static const String Temporary_badge_not_printed = "Badge provisoire !\n"
      "Saisie matricule impossible sans impression du badge du jour   ";
  static const String scan_of_CAB_of_real_badge_compulsory_at_first_auth =
      "Merci de scanner le CAB de votre badge. Saisie du matricule interdite !";
}
