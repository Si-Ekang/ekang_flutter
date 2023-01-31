import 'package:ekang_flutter/generated/assets.dart';

enum WordTextToSpeech {
  NONE("", ""),

  akang("akang", Assets.audioAkang),
  akung("akung", Assets.audioAkung),
  angbang("angbang", Assets.audioAngbang),
  anoan("anoan", Assets.audioAnoan),
  atun("atun", Assets.audioAtun),
  ebuma("ebuma", Assets.audioEbuma),
  edong("edong", Assets.audioEdong),
  elas("elas", Assets.audioElas),
  elong("elong", Assets.audioElong),
  elum("elum", Assets.audioElum),
  esua("esua", Assets.audioEsua),
  fa_a("fa_a", Assets.audioFaA),
  kisin("kisin", Assets.audioKisin),
  kokos("kokös", Assets.audioKokos),
  kuleyebe("kuleyebe", Assets.audioElas),
  kunegh("kunegh", Assets.audioElas),
  mba_to_o("mba_to_o", Assets.audioElas),
  miam("miam", Assets.audioMiam),
  mvekum("mvekum", Assets.audioMvekum),
  mwan_ku("mwan-ku", Assets.audioMwanKu),
  mwan_swa("mwan-swa", Assets.audioMwanSwa),
  n_yoman("n-yoman", Assets.audioNYoman),
  nduan("nduan", Assets.audioNduan),
  nduin("ndüin", Assets.audioNduin),
  ngia("ngia", Assets.audioNgia),
  nkang("nkang", Assets.audioNkang),
  nnom_ku("nnom-ku", Assets.audioNnomKu),
  ntum("ntum", Assets.audioNtum),
  obam("obam", Assets.audioObam),
  obeng("obeng", Assets.audioObeng),
  okeng("okeng", Assets.audioOkeng),
  onoan("onoan", Assets.audioOnoan),
  otua("otua", Assets.audioOtua),
  otua1("otüa", Assets.audioOtua1),
  sosoo("sosoo", Assets.audioSosoo),
  to_o("to'o", Assets.audioToO),
  viok("viok", Assets.audioViok),
  zum("zum", Assets.audioZum),
  elat("élat", Assets.audioElat);

  final String word;
  final String audioAsset;

  const WordTextToSpeech(this.word, this.audioAsset);
  
}
