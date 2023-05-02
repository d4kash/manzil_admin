var admin = require('firebase-admin');

var serviceAccount = require('C:UsersDAKSHDocumentsmanzil_usermanzil_admin/fcmkey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
// This registration token comes from the client FCM SDKs.
var registrationToken =
  'fHPdlUh0QaWqUEmL0SEtFD:APA91bEMQfZtWZCn4Vaa9ch2JkU8rOtke-LNFGDb9x7LcrMytkYS8sdfvHySw5mOHkrjBeCytmt59jpFthfK2a-aDQRgzY8VAND4Hz9UDvnX2Q_Oy-7Gb9z594s1m5CsP7CtOBrpi9WW';

var message = {
  notification: {
    title: '850',
    body: '2:45',
  },
  // token: registrationToken
};

// Send a message to the device corresponding to the provided
// registration token.
admin
  .messaging()
  .sendToTopic('Samsung', message)
  .then((response) => {
    // Response is a message ID string.
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });
