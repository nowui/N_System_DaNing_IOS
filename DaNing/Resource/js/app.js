var EventTitle = "Title";
var EventInit = "Init";
var EventGo = "Go";
var EventBack = "Back";
var EventSaveSetting = "SaveSetting";
var EventFindSetting = "FindSetting";
var EventClickHeaderRightButton = "ClickHeaderRightButton";

var ActionSetTitle = "setTitle";
var ActionSetSetting = "setSetting";
var ActionGetSetting = "getSetting";
var ActionSetSwitch = "setSwitch";
var ActionSetNavite = "setNavite";
var ActionSetBack = "setBack";
var ActionSetBackAndRefresh = "setBackAndRefresh";
var ActionSetClickHeaderRightButton = "setClickHeaderRightButton";
var ActionSetPreviewImage = "setPreviewImage";
var ActionGetAlert = "getAlert";
var ActionSetApplicationIconBadgeNumber = "setApplicationIconBadgeNumber";
var ActionGetAppear = "getAppear";

var CookieAccount = "Account";
var CookieUserId = "UserId";
var CookieUserName = "UserName";

var HideDelay = 500;
var WaitDelay = 1500;

var LoadingTemplate = "<ion-spinner icon=\"android\" class=\"spinner-light\" />";

var imageUrl = "http://daning.nowui.com";

var url = document.location.href;
var urlString = url.replace("http://" + window.location.host, "");


var getUrlParam = function(name) {
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r!=null) {
		return unescape(r[2]);
	} else {
		return null;
	}
}

var isNullOrEmpty = function(string) {
	if(string == "" || typeof(string) == "undefined" || string == null) {
		return true;
	} else {
		return false;
	}
}

var isNumber = function(s) {
    if (s!=null && s!="") {
        return !isNaN(s);
    }
    return false;
}

String.prototype.replaceAll = function(s1, s2) {
    return this.replace(new RegExp(s1, "gm"), s2);
}

Date.prototype.Format = function(fmt) {
  var o = {
    "M+" : this.getMonth()+1,                 //月份
    "d+" : this.getDate(),                    //日
    "h+" : this.getHours(),                   //小时
    "m+" : this.getMinutes(),                 //分
    "s+" : this.getSeconds(),                 //秒
    "q+" : Math.floor((this.getMonth()+3)/3), //季度
    "S"  : this.getMilliseconds()             //毫秒
  };
  if(/(y+)/.test(fmt))
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
  for(var k in o)
    if(new RegExp("("+ k +")").test(fmt))
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
  return fmt;
}

var isWeb = false;
var isiOS = false;
var iDevice = ['iPad', 'iPhone', 'iPod'];
var UIWebView = /(iPhone|iPod|iPad).*AppleWebKit(?!.*Safari)/i.test(navigator.userAgent);
var isAndroid = navigator.userAgent.toLowerCase().indexOf("android") > -1;
var isApp = false;

for (var i = 0; i < iDevice.length; i++) {
    if (navigator.platform.indexOf(iDevice[i]) >= 0) {
        isiOS = true;
        break;
    }
}

if ((isiOS && UIWebView) || isAndroid) {
	isWeb = false;
} else {
	isWeb = true;
}

if(navigator.userAgent.toLowerCase().match(/MicroMessenger/i)=="micromessenger") {
	isWeb = true;
}

var isApp = ! isWeb