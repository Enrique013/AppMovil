importScripts("https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.1/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyA3KiQ24yv0SQN2VFHVAeimMdrm0kPdkjY",
  authDomain: "test-login2-642e2.firebaseapp.com",
  projectId: "test-login2-642e2",
  storageBucket: "test-login2-642e2.firebasestorage.app",
  messagingSenderId: "238254514845",
  appId: "1:238254514845:web:19e63def269ee8f26f2a74"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  self.registration.showNotification(
    message.notification.title,
    {
      body: message.notification.body,
    }
  );
});
