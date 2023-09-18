var request = require('request'),
  assert = require('assert'),
  Q = require('q');
/*
**************************************************
What is the URL that you want to check?
**************************************************
*/
var urlsToMonitor = [
  'https://misite.com'
];

var licenseKey = 'XXXX';
var accountId = 'SSL Certifications';

function treatAsUTC(date) {
    var result = new Date(date);
    result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
    return result;
}

function daysBetween(startDate, endDate) {
    var millisecondsPerDay = 24 * 60 * 60 * 1000;
    return Math.round((treatAsUTC(endDate) - treatAsUTC(startDate)) / millisecondsPerDay);
}

function insertInsightsEvent(urlMonitored, certificateIssuer, daysToExpiration, expirationMilliseconds){
  var options = {
    uri: 'https://insights-collector.newrelic.com/v1/accounts/'+accountId+'/events',
    body: '[{"eventType":"SSLCertificateCheck","Url":"'+urlMonitored+'","Issuer":"'+certificateIssuer+'","DaysToExpiration":'+daysToExpiration+', "ExpirationDate":'+expirationMilliseconds+'}]',
		headers:{
			'X-Insert-Key': licenseKey,
			'Content-Type': 'application/json'
		}
  };
  console.log("Posting event for: "+urlMonitored);
  request.post(options, function(error,response, body){
      console.log(response.statusMessage);
      console.log(response.statusCode + " status code");
      assert.ok(response.statusCode == 200, 'Expected 200 OK response');  
      var info = JSON.parse(body);
      assert.ok(info.success == true, 'Expected True results in Response Body, result was ' + info.success);
      console.log("SSL cert check completed successfully");
    });
}

function processSite(urlToMonitor)
{
	//var deferred = Q.defer();
  console.log('Preparing to monitor '+urlToMonitor);

  var theRequestObject = request({
    url: urlToMonitor,
    method: 'HEAD',
    gzip: true,
    followRedirect: false,
    followAllRedirects: false
  });

  theRequestObject.on('response', 
    function(res) { 
      var certDetails = (res.req.connection.getPeerCertificate());
      var currentDate = new Date(); 
      var certExpirationDate = new Date(certDetails.valid_to);
      var certificateIssuer = certDetails.issuer.O; 
      var daysToExpiration = daysBetween(currentDate, certExpirationDate);
      var certificateIssuer = certDetails.issuer.O;
      console.log('This certificate was issued by '+certificateIssuer, '');
      console.log('This SSL certificate will expire on '+certExpirationDate, '');
      console.log('**** Date at time of testing: '+currentDate);
      console.log('**** Days to expiration: '+daysToExpiration);
      console.log("Creating event for: "+urlToMonitor);
      insertInsightsEvent(urlToMonitor, certificateIssuer, daysToExpiration, certExpirationDate.getTime());
    }
  );
}

for(var i=0; i< urlsToMonitor.length; i++)
{
  var urlToMonitor = urlsToMonitor[i];
  processSite(urlToMonitor);
}