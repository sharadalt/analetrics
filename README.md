
     ,-----.,--.                  ,--. ,---.   ,--.,------.  ,------.
    '  .--./|  | ,---. ,--.,--. ,-|  || o   \  |  ||  .-.  \ |  .---'
    |  |    |  || .-. ||  ||  |' .-. |`..'  |  |  ||  |  \  :|  `--, 
    '  '--'\|  |' '-' ''  ''  '\ `-' | .'  /   |  ||  '--'  /|  `---.
     `-----'`--' `---'  `----'  `---'  `--'    `--'`-------' `------'
    ----------------------------------------------------------------- 

Checkpoint - 7 Client-Side Javascript

Blocmetrics users must be able to track events using JavaScript snippets.

When a browser executes the blocmetrics.report function, make an Ajax request to the server-side API 
to create the event on your server.

blocmetrics.report = function(eventName) {
   // #1
   var event = {event: { name: eventName }};
 
   // #2
   var request = new XMLHttpRequest();
   // #3
   request.open("POST", "http://localhost:3000/api/events", true);
   // #4
   request.setRequestHeader('Content-Type', 'application/json');
   // #5
   request.send(JSON.stringify(event));
}

At #1, we create an event JSON object to send to the Blocmetrics analytics service.

At #2, we initialize a new XMLHttpRequest() (AJAX request)

At #3, we set the HTTP method to POST, the url of our events endpoint, and allow the request to run asynchronously.

At #4, we set the request Content-Type header to 'application/json'. Without that, our API::EventsController would not know to process the request as JSON.

At #5, we finally send the request.



I have added a new branch called blocmetrics_test. There I added the Java snippet to application.js 
under app/javascripts directory. In index.html.erb, the method blocmetrics.report is invoked.

First I started blocmetrics, then I created a registered_application with blocipedia url. Then I started
blocipedia. Afterwards when I checked at blocmetrics events, I could see the event corresponding to
the event name in the blocmetrics.report was incremented.
