var http = require('http');

var app = function(req, res) {};

http.createServer(app)
  .listen(80, function(err) {
    if (err) return cb(err);

    // Find out which user used sudo through the environment variable
    var uid = parseInt(process.env.SUDO_UID);
    // Set our server's uid to that user
    if (uid) process.setuid(uid);
    console.log('Server\'s UID is now ' + process.getuid());
  });

