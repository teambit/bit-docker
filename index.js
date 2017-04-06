const fs = require('fs');
const crypto = require('crypto');
const inspect = require('util').inspect;
const buffersEqual = require('buffer-equal-constant-time');
const ssh2 = require('ssh2');
const utils = ssh2.utils;
const shell = require('shelljs');

const privateKey = process.env.PRIVATE_KEY;
const publicKey = process.env.PUBLIC_KEY;

const pubKey = utils.genPublicKey(utils.parseKey(fs.readFileSync(`/root/.ssh/${publicKey}`)));

new ssh2.Server({
  hostKeys: [fs.readFileSync(`/root/.ssh/${privateKey}`)]
}, function(client) {
  console.log('Client connected!');

  client.on('authentication', function(ctx) {

     if (ctx.method === 'publickey'
             && ctx.key.algo === pubKey.fulltype
             && buffersEqual(ctx.key.data, pubKey.public)) {
      if (ctx.signature) {
        var verifier = crypto.createVerify(ctx.sigAlgo);
        verifier.update(ctx.blob);
        if (verifier.verify(pubKey.publicOrig, ctx.signature))
          ctx.accept();
        else
          ctx.reject();
      } else {
        // if no signature present, that means the client is just checking
        // the validity of the given public key
        ctx.accept();
      }
    } else
      ctx.reject();
  }).on('ready', function() {
    console.log('Client authenticated!');

    client.on('session', function(accept, reject) {
      var session = accept();
      session.once('exec', function(accept, reject, info) {
        console.log('Client wants to execute: ' + inspect(info.command));
        // Run external tool synchronously
        shell.exec(info.command, {cwd:'/scope'}, function(code, stdout, stderr) {
           var stream = accept();
            stream.stderr.write(stderr);
            stream.write(stdout);
            stream.exit(0);
            stream.end();
        });
        
      });
    });
  }).on('end', function() {
    console.log('Client disconnected');
  });
}).listen(3000, '0.0.0.0', function() {
  console.log('Listening on port ' + this.address().port);
});