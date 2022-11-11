var admin = require("firebase-admin");

var serviceAccount = require("./service_key.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://marku-ce382.firebaseio.com"
});

const firestore = admin.firestore();
const path = require("path");
const fs = require("fs");
const directoryPath = path.join(__dirname, "files");
console.log("Start");
let i=0;

fs.readdir(directoryPath, function(err, files) {
  if (err) {
    return console.log("Unable to scan directory: " + err);
  }

  files.forEach(function(file) {
    var lastDotIndex = file.lastIndexOf(".");
    if(file == "comps_data.json"){      
      
      var menu = require("./files/" + file);
      console.log(file)
      menu.forEach(function(obj) {
        
        data = {
          "name": obj.name,
          "id": obj.id,
          "email": obj.email,
          "phone": obj.phone,
          "elective": obj.elective,
          "roll": obj.roll
        };
        console.log(data.name);
        
        firestore
          .collection(obj.branch)
          .doc(obj.year)
          .collection("students")
          .doc(obj.id)
          .set(data)
          .then(function(docRef) {
            console.log("Document written");
            i++;
          })
          .catch(function(error) {
            console.error("Error adding document: ", error);
          });

      });
      console.log(`uploader executed successfully ${i}`);
    }
  });
});


