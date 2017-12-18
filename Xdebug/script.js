var cookieName = "XDEBUG_SESSION";
var cookieValue = "1";
var duration = 365;

function createCookie(name,value,days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}

function handleMessage(event) {
    if (event.message.isActive) {
        createCookie(cookieName, cookieValue, duration);
    } else {
        eraseCookie(cookieName);
    }
}

function makeMessage() {
    return {"isActive": readCookie(cookieName) == cookieValue };
}

if (window.top === window) {
    document.addEventListener("DOMContentLoaded", function(event) {
                              safari.extension.dispatchMessage("xdebug", makeMessage());
                              safari.self.addEventListener("message", handleMessage);
                              });
    
    window.onfocus = function () {
        safari.extension.dispatchMessage("xdebug", makeMessage());
    };
}
