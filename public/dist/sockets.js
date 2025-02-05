
window.wsconnected = new Event("wsconnected");
server.kernelControl = {};

var socket = new WebSocket("ws://"+window.location.hostname+':'+(Number(window.location.port)+1));
socket.onopen = function(e) {
  console.log("[open] Соединение установлено");
  
  server.init(socket);
  setTimeout(()=>{
    server.socket.send('Append[broadcast, Global`client]');
    setTimeout(()=>{
      window.dispatchEvent(wsconnected);
    }, 100);
  }, 200);

  window.onerror = function (message, file, line, col, error) {
    socket.send('NotebookPopupFire["error", "'+error.message+'"]');
    console.log(error);
    return false;
  };
  window.addEventListener("error", function (e) {
    socket.send('NotebookPopupFire["error", "'+e.message+'"]');
    console.log(e);
    return false;
  });
  window.addEventListener('unhandledrejection', function (e) {
    socket.send('NotebookPopupFire["error", "'+e.message+'"]');
    console.log(e);
  });

  console.error = function(e) {
    socket.send('NotebookPopupFire["error", "'+e+'"]');
    console.log(e);
  };

}; 

socket.onmessage = function(event) {
  //create global context
  //callid
  const uid = Date.now() + Math.floor(Math.random() * 100);
  var global = {call: uid};
  interpretate(JSON.parse(event.data), {global: global});
};

socket.onclose = function(event) {
  console.log(event);
  server.kernelControl.wsReset('bad');
  server.kernelControl.notebookReset('bad');
  //alert('Connection lost. Please, update the page to see new changes.');
};

window.addEventListener("blur", ()=>{
  server.kernelControl.wsReset();
  server.kernelControl.notebookReset();
});

window.WSPHttpQueryQuite = (command, promise, type = "String") => {

  var http = new XMLHttpRequest();
  var url = 'http://'+window.location.hostname+':'+window.location.port+'/utils/query.wsp';
  var params = 'command='+encodeURI(command)+'&type='+type;
  http.open('GET', url+"?"+params, true);

  //Send the proper header information along with the request
  http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  if (type == "ExpressionJSON" || type == "JSON") {
    http.onreadystatechange = function() {//Call a function when the state changes.
      if(http.readyState == 4 && http.status == 200) {
       
        // http.responseText will be anything that the server return
        promise(JSON.parse(http.responseText));
        
      }
    };
  } else {
    http.onreadystatechange = function() {//Call a function when the state changes.
      if(http.readyState == 4 && http.status == 200) {
  
        // http.responseText will be anything that the server return
        promise(http.responseText);
        
      }
    };
  }

 
  http.send(null);
}

window.WSPHttpQuery = (command, promise, type = "String") => {
  var http = new XMLHttpRequest();
  var url = 'http://'+window.location.hostname+':'+window.location.port+'/utils/query.wsp';
  var params = 'command='+encodeURI(command)+'&type='+type;

  console.log(params);
  http.open('GET', url+"?"+params, true);

  //Send the proper header information along with the request
  http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  if (type == "ExpressionJSON" || type == "JSON") {
    http.onreadystatechange = function() {//Call a function when the state changes.
      if(http.readyState == 4 && http.status == 200) {
        console.log("RESP: " + http.responseText);
        // http.responseText will be anything that the server return
        promise(JSON.parse(http.responseText));
        document.getElementById('logoFlames').style = "display: none";
        document.getElementById('bigFlames').style = "opacity: 0";
        
      }
    };
  } else {
    http.onreadystatechange = function() {//Call a function when the state changes.
      if(http.readyState == 4 && http.status == 200) {
        console.log("RESP: " + http.responseText);
  
        // http.responseText will be anything that the server return
        promise(http.responseText);
        document.getElementById('logoFlames').style = "display: none";
        document.getElementById('bigFlames').style = "opacity: 0";
      }
    };
  }

  document.getElementById('logoFlames').style = "display: block";
  document.getElementById('bigFlames').style = "opacity: 0.1";
  http.send(null);
}

window.WSPHttpBigQuery = (command, promise, type = "String") => {

    var url = 'http://'+window.location.hostname+':'+window.location.port+'/utils/post.wsp';

    const formData = new FormData();
    formData.append('command', command);


    const request = new XMLHttpRequest();

    request.onreadystatechange = ()=>{
      if (request.readyState === 4) {
        console.log(request.responseText);

          if (request.responseText == 'Nothing') {
            promise.resolve();
          } else {
            promise.reject();
          }
      }    
      }
    
    request.open("POST", url);
    request.send(formData);
}

