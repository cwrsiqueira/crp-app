import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB9YWE5ZnmKPcfCgauEGeo-3seoeGsqQuk",
            authDomain: "fin-calc-simulador-fina-45dk6z.firebaseapp.com",
            projectId: "fin-calc-simulador-fina-45dk6z",
            storageBucket: "fin-calc-simulador-fina-45dk6z.firebasestorage.app",
            messagingSenderId: "254854273065",
            appId: "1:254854273065:web:08baee7aa2a43f1e172438",
            measurementId: "G-HGF9LTW439"));
  } else {
    await Firebase.initializeApp();
  }
}
