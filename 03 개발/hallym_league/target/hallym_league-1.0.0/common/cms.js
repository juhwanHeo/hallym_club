
/* 지니웍스 cms */
window.undefined=window.undefined;Andwise={$:function(el){if(el.jquery){return el}else{return $(el)}}};Andwise.apply=function(o,c,defaults){if(defaults){Andwise.apply(o,defaults)}if(o&&c&&typeof c=='object'){for(var p in c){o[p]=c[p]}}return o};(function(){var idSeed=0,toString=Object.prototype.toString,ua=navigator.userAgent.toLowerCase(),check=function(r){return r.test(ua)},DOC=document,docMode=DOC.documentMode,isStrict=DOC.compatMode=="CSS1Compat",isOpera=check(/opera/),isChrome=check(/\bchrome\b/),isWebKit=check(/webkit/),isSafari=!isChrome&&check(/safari/),isSafari2=isSafari&&check(/applewebkit\/4/),isSafari3=isSafari&&check(/version\/3/),isSafari4=isSafari&&check(/version\/4/),isIE=!isOpera&&check(/msie/),isIE7=isIE&&(check(/msie 7/)||docMode==7),isIE8=isIE&&(check(/msie 8/)&&docMode!=7),isIE9=isIE&&check(/msie 9/),isIE6=isIE&&!isIE7&&!isIE8&&!isIE9,isGecko=!isWebKit&&check(/gecko/),isGecko2=isGecko&&check(/rv:1\.8/),isGecko3=isGecko&&check(/rv:1\.9/),isBorderBox=isIE&&!isStrict,isWindows=check(/windows|win32/),isMac=check(/macintosh|mac os x/),isAir=check(/adobeair/),isLinux=check(/linux/),isSecure=/^https/i.test(window.location.protocol);if(isIE6){try{DOC.execCommand("BackgroundImageCache",false,true)}catch(e){}}Andwise.apply(Andwise,{SSL_SECURE_URL:isSecure&&isIE?'javascript:""':'about:blank',isStrict:isStrict,isSecure:isSecure,isReady:false,enableForcedBoxModel:false,enableGarbageCollector:true,enableListenerCollection:false,enableNestedListenerRemoval:false,USE_NATIVE_JSON:false,applyIf:function(o,c){if(o){for(var p in c){if(!Andwise.isDefined(o[p])){o[p]=c[p]}}}return o},id:function(el,prefix){el=Andwise.getDom(el,true)||{};if(!el.id){el.id=(prefix||"ext-gen")+(++idSeed)}return el.id},extend:function(){var io=function(o){for(var m in o){this[m]=o[m]}};var oc=Object.prototype.constructor;return function(sb,sp,overrides){if(typeof sp=='object'){overrides=sp;sp=sb;sb=overrides.constructor!=oc?overrides.constructor:function(){sp.apply(this,arguments)}}var F=function(){},sbp,spp=sp.prototype;F.prototype=spp;sbp=sb.prototype=new F();sbp.constructor=sb;sb.superclass=spp;if(spp.constructor==oc){spp.constructor=sp}sb.override=function(o){Andwise.override(sb,o)};sbp.superclass=sbp.supr=(function(){return spp});sbp.override=io;Andwise.override(sb,overrides);sb.extend=function(o){return Andwise.extend(sb,o)};return sb}}(),override:function(origclass,overrides){if(overrides){var p=origclass.prototype;Andwise.apply(p,overrides);if(Andwise.isIE&&overrides.hasOwnProperty('toString')){p.toString=overrides.toString}}},namespace:function(){var len1=arguments.length,i=0,len2,j,main,ns,sub,current;for(;i<len1;++i){main=arguments[i];ns=arguments[i].split('.');current=window[ns[0]];if(current===undefined){current=window[ns[0]]={}}sub=ns.slice(1);len2=sub.length;for(j=0;j<len2;++j){current=current[sub[j]]=current[sub[j]]||{}}}return current},urlEncode:function(o,pre){var empty,buf=[],e=encodeURIComponent;Andwise.iterate(o,function(key,item){empty=Andwise.isEmpty(item);Andwise.each(empty?key:item,function(val){buf.push('&',e(key),'=',(!Andwise.isEmpty(val)&&(val!=key||!empty))?(Andwise.isDate(val)?Andwise.encode(val).replace(/"/g,''):e(val)):'')})});if(!pre){buf.shift();pre=''}return pre+buf.join('')},urlDecode:function(string,overwrite){if(Andwise.isEmpty(string)){return{}}var obj={},pairs=string.split('&'),d=decodeURIComponent,name,value;Andwise.each(pairs,function(pair){pair=pair.split('=');name=d(pair[0]);value=d(pair[1]);obj[name]=overwrite||!obj[name]?value:[].concat(obj[name]).concat(value)});return obj},urlAppend:function(url,s){if(!Andwise.isEmpty(s)){return url+(url.indexOf('?')===-1?'?':'&')+s}return url},toArray:function(){return isIE?function(a,i,j,res){res=[];for(var x=0,len=a.length;x<len;x++){res.push(a[x])}return res.slice(i||0,j||res.length)}:function(a,i,j){return Array.prototype.slice.call(a,i||0,j||a.length)}}(),isIterable:function(v){if(Andwise.isArray(v)||v.callee){return true}if(/NodeList|HTMLCollection/.test(toString.call(v))){return true}return((typeof v.nextNode!='undefined'||v.item)&&Andwise.isNumber(v.length))},each:function(array,fn,scope){if(Andwise.isEmpty(array,true)){return}if(!Andwise.isIterable(array)||Andwise.isPrimitive(array)){array=[array]}for(var i=0,len=array.length;i<len;i++){if(fn.call(scope||array[i],array[i],i,array)===false){return i}}},iterate:function(obj,fn,scope){if(Andwise.isEmpty(obj)){return}if(Andwise.isIterable(obj)){Andwise.each(obj,fn,scope);return}else if(typeof obj=='object'){for(var prop in obj){if(obj.hasOwnProperty(prop)){if(fn.call(scope||obj,prop,obj[prop],obj)===false){return}}}}},getDom:function(el,strict){if(!el||!DOC){return null}if(el.dom){return el.dom}else{if(typeof el=='string'){var e=DOC.getElementById(el);if(e&&isIE&&strict){if(el==e.getAttribute('id')){return e}else{return null}}return e}else{return el}}},getBody:function(){return Andwise.get(DOC.body||DOC.documentElement)},getHead:function(){var head;return function(){if(head==undefined){head=Andwise.get(DOC.getElementsByTagName("head")[0])}return head}}(),removeNode:isIE&&!isIE8?function(){var d;return function(n){if(n&&n.tagName!='BODY'){(Andwise.enableNestedListenerRemoval)?Andwise.EventManager.purgeElement(n,true):Andwise.EventManager.removeAll(n);d=d||DOC.createElement('div');d.appendChild(n);d.innerHTML='';delete Andwise.elCache[n.id]}}}():function(n){if(n&&n.parentNode&&n.tagName!='BODY'){(Andwise.enableNestedListenerRemoval)?Andwise.EventManager.purgeElement(n,true):Andwise.EventManager.removeAll(n);n.parentNode.removeChild(n);delete Andwise.elCache[n.id]}},isEmpty:function(v,allowBlank){return v===null||v===undefined||((Andwise.isArray(v)&&!v.length))||(!allowBlank?v==='':false)},isArray:function(v){return toString.apply(v)==='[object Array]'},isDate:function(v){return toString.apply(v)==='[object Date]'},isObject:function(v){return!!v&&Object.prototype.toString.call(v)==='[object Object]'},isPrimitive:function(v){return Andwise.isString(v)||Andwise.isNumber(v)||Andwise.isBoolean(v)},isFunction:function(v){return toString.apply(v)==='[object Function]'},isNumber:function(v){return typeof v==='number'&&isFinite(v)},isString:function(v){return typeof v==='string'},isBoolean:function(v){return typeof v==='boolean'},isElement:function(v){return v?!!v.tagName:false},isDefined:function(v){return typeof v!=='undefined'},isOpera:isOpera,isWebKit:isWebKit,isChrome:isChrome,isSafari:isSafari,isSafari3:isSafari3,isSafari4:isSafari4,isSafari2:isSafari2,isIE:isIE,isIE6:isIE6,isIE7:isIE7,isIE8:isIE8,isIE9:isIE9,isGecko:isGecko,isGecko2:isGecko2,isGecko3:isGecko3,isBorderBox:isBorderBox,isLinux:isLinux,isWindows:isWindows,isMac:isMac,isAir:isAir});Andwise.ns=Andwise.namespace})();Andwise.ns('Andwise.util','Andwise.lib','Andwise.data','Andwise.supports');Andwise.elCache={};Andwise.apply(Function.prototype,{createInterceptor:function(fcn,scope){var method=this;return!Andwise.isFunction(fcn)?this:function(){var me=this,args=arguments;fcn.target=me;fcn.method=method;return(fcn.apply(scope||me||window,args)!==false)?method.apply(me||window,args):null}},createCallback:function(){var args=arguments,method=this;return function(){return method.apply(window,args)}},createDelegate:function(obj,args,appendArgs){var method=this;return function(){var callArgs=args||arguments;if(appendArgs===true){callArgs=Array.prototype.slice.call(arguments,0);callArgs=callArgs.concat(args)}else if(Andwise.isNumber(appendArgs)){callArgs=Array.prototype.slice.call(arguments,0);var applyArgs=[appendArgs,0].concat(args);Array.prototype.splice.apply(callArgs,applyArgs)}return method.apply(obj||window,callArgs)}},defer:function(millis,obj,args,appendArgs){var fn=this.createDelegate(obj,args,appendArgs);if(millis>0){return setTimeout(fn,millis)}fn();return 0}});Andwise.applyIf(String,{format:function(format){var args=Andwise.toArray(arguments,1);return format.replace(/\{(\d+)\}/g,function(m,i){return args[i]})}});Andwise.applyIf(Array.prototype,{indexOf:function(o,from){var len=this.length;from=from||0;from+=(from<0)?len:0;for(;from<len;++from){if(this[from]===o){return from}}return-1},remove:function(o){var index=this.indexOf(o);if(index!=-1){this.splice(index,1)}return this}});
/* jQuery CooQuery Plugin v2 (minified) - http://cooquery.lenonmarcel.com.br/http://www.gnu.org/licenses/gpl.html */
(function($){$.setCookie=function(name,value,options){if(typeof name==='undefined'||typeof value==='undefined')
return false;var str=name+'='+encodeURIComponent(value);if(options.domain)str+='; domain='+options.domain;if(options.path)str+='; path='+options.path;if(options.duration){var date=new Date();date.setTime(date.getTime()+options.duration*24*60*60*1000);str+='; expires='+date.toGMTString();}
if(options.secure)str+='; secure';return document.cookie=str;};$.delCookie=function(name){return $.setCookie(name,'',{duration:-1});};$.readCookie=function(name){var value=document.cookie.match('(?:^|;)\\s*'+name.replace(/([-.*+?^${}()|[\]\/\\])/g,'\\$1')+'=([^;]*)');return(value)?decodeURIComponent(value[1]):null;};$.getCookie=$.readCookie;$.CooQueryVersion='v 2.0';})(jQuery);
// drop shadow
jQuery.fn.outerHTML = function(s) {
return (s)
? this.before(s).remove()
: jQuery("<p>").append(this.eq(0).clone()).html();
}
function toStr(o,def) { if(typeof(o)=='undefined') { return def+''; } return o+'';};
var LZString=function(){function o(o,r){if(!t[o]){t[o]={};for(var n=0;n<o.length;n++)t[o][o.charAt(n)]=n}return t[o][r]}var r=String.fromCharCode,n="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",e="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-$",t={},i={compressToBase64:function(o){if(null==o)return"";var r=i._compress(o,6,function(o){return n.charAt(o)});switch(r.length%4){default:case 0:return r;case 1:return r+"===";case 2:return r+"==";case 3:return r+"="}},decompressFromBase64:function(r){return null==r?"":""==r?null:i._decompress(r.length,32,function(e){return o(n,r.charAt(e))})},compressToUTF16:function(o){return null==o?"":i._compress(o,15,function(o){return r(o+32)})+" "},decompressFromUTF16:function(o){return null==o?"":""==o?null:i._decompress(o.length,16384,function(r){return o.charCodeAt(r)-32})},compressToUint8Array:function(o){for(var r=i.compress(o),n=new Uint8Array(2*r.length),e=0,t=r.length;t>e;e++){var s=r.charCodeAt(e);n[2*e]=s>>>8,n[2*e+1]=s%256}return n},decompressFromUint8Array:function(o){if(null===o||void 0===o)return i.decompress(o);for(var n=new Array(o.length/2),e=0,t=n.length;t>e;e++)n[e]=256*o[2*e]+o[2*e+1];var s=[];return n.forEach(function(o){s.push(r(o))}),i.decompress(s.join(""))},compressToEncodedURIComponent:function(o){return null==o?"":i._compress(o,6,function(o){return e.charAt(o)})},decompressFromEncodedURIComponent:function(r){return null==r?"":""==r?null:(r=r.replace(/ /g,"+"),i._decompress(r.length,32,function(n){return o(e,r.charAt(n))}))},compress:function(o){return i._compress(o,16,function(o){return r(o)})},_compress:function(o,r,n){if(null==o)return"";var e,t,i,s={},p={},u="",c="",a="",l=2,f=3,h=2,d=[],m=0,v=0;for(i=0;i<o.length;i+=1)if(u=o.charAt(i),Object.prototype.hasOwnProperty.call(s,u)||(s[u]=f++,p[u]=!0),c=a+u,Object.prototype.hasOwnProperty.call(s,c))a=c;else{if(Object.prototype.hasOwnProperty.call(p,a)){if(a.charCodeAt(0)<256){for(e=0;h>e;e++)m<<=1,v==r-1?(v=0,d.push(n(m)),m=0):v++;for(t=a.charCodeAt(0),e=0;8>e;e++)m=m<<1|1&t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t>>=1}else{for(t=1,e=0;h>e;e++)m=m<<1|t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t=0;for(t=a.charCodeAt(0),e=0;16>e;e++)m=m<<1|1&t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t>>=1}l--,0==l&&(l=Math.pow(2,h),h++),delete p[a]}else for(t=s[a],e=0;h>e;e++)m=m<<1|1&t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t>>=1;l--,0==l&&(l=Math.pow(2,h),h++),s[c]=f++,a=String(u)}if(""!==a){if(Object.prototype.hasOwnProperty.call(p,a)){if(a.charCodeAt(0)<256){for(e=0;h>e;e++)m<<=1,v==r-1?(v=0,d.push(n(m)),m=0):v++;for(t=a.charCodeAt(0),e=0;8>e;e++)m=m<<1|1&t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t>>=1}else{for(t=1,e=0;h>e;e++)m=m<<1|t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t=0;for(t=a.charCodeAt(0),e=0;16>e;e++)m=m<<1|1&t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t>>=1}l--,0==l&&(l=Math.pow(2,h),h++),delete p[a]}else for(t=s[a],e=0;h>e;e++)m=m<<1|1&t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t>>=1;l--,0==l&&(l=Math.pow(2,h),h++)}for(t=2,e=0;h>e;e++)m=m<<1|1&t,v==r-1?(v=0,d.push(n(m)),m=0):v++,t>>=1;for(;;){if(m<<=1,v==r-1){d.push(n(m));break}v++}return d.join("")},decompress:function(o){return null==o?"":""==o?null:i._decompress(o.length,32768,function(r){return o.charCodeAt(r)})},_decompress:function(o,n,e){var t,i,s,p,u,c,a,l,f=[],h=4,d=4,m=3,v="",w=[],A={val:e(0),position:n,index:1};for(i=0;3>i;i+=1)f[i]=i;for(p=0,c=Math.pow(2,2),a=1;a!=c;)u=A.val&A.position,A.position>>=1,0==A.position&&(A.position=n,A.val=e(A.index++)),p|=(u>0?1:0)*a,a<<=1;switch(t=p){case 0:for(p=0,c=Math.pow(2,8),a=1;a!=c;)u=A.val&A.position,A.position>>=1,0==A.position&&(A.position=n,A.val=e(A.index++)),p|=(u>0?1:0)*a,a<<=1;l=r(p);break;case 1:for(p=0,c=Math.pow(2,16),a=1;a!=c;)u=A.val&A.position,A.position>>=1,0==A.position&&(A.position=n,A.val=e(A.index++)),p|=(u>0?1:0)*a,a<<=1;l=r(p);break;case 2:return""}for(f[3]=l,s=l,w.push(l);;){if(A.index>o)return"";for(p=0,c=Math.pow(2,m),a=1;a!=c;)u=A.val&A.position,A.position>>=1,0==A.position&&(A.position=n,A.val=e(A.index++)),p|=(u>0?1:0)*a,a<<=1;switch(l=p){case 0:for(p=0,c=Math.pow(2,8),a=1;a!=c;)u=A.val&A.position,A.position>>=1,0==A.position&&(A.position=n,A.val=e(A.index++)),p|=(u>0?1:0)*a,a<<=1;f[d++]=r(p),l=d-1,h--;break;case 1:for(p=0,c=Math.pow(2,16),a=1;a!=c;)u=A.val&A.position,A.position>>=1,0==A.position&&(A.position=n,A.val=e(A.index++)),p|=(u>0?1:0)*a,a<<=1;f[d++]=r(p),l=d-1,h--;break;case 2:return w.join("")}if(0==h&&(h=Math.pow(2,m),m++),f[l])v=f[l];else{if(l!==d)return null;v=s+s.charAt(0)}w.push(v),f[d++]=s+v.charAt(0),h--,s=v,0==h&&(h=Math.pow(2,m),m++)}}};return i}();"function"==typeof define&&define.amd?define(function(){return LZString}):"undefined"!=typeof module&&null!=module&&(module.exports=LZString);
var Base64 = {
	encode: function( input ) {
		if(Andwise.isEmpty(input)) return 'LZStr';
		return 'LZStr'+LZString.compressToEncodedURIComponent( input );
	},
	decode: function( input ) {
		if(input == undefined) {
			return input;
		}
		return LZString.decompressFromEncodedURIComponent( input.substring(5) );
	}
}
//fgnass.github.com/spin.js#v1.2.7
!function(e,t,n){function o(e,n){var r=t.createElement(e||"div"),i;for(i in n)r[i]=n[i];return r}function u(e){for(var t=1,n=arguments.length;t<n;t++)e.appendChild(arguments[t]);return e}function f(e,t,n,r){var o=["opacity",t,~~(e*100),n,r].join("-"),u=.01+n/r*100,f=Math.max(1-(1-e)/t*(100-u),e),l=s.substring(0,s.indexOf("Animation")).toLowerCase(),c=l&&"-"+l+"-"||"";return i[o]||(a.insertRule("@"+c+"keyframes "+o+"{"+"0%{opacity:"+f+"}"+u+"%{opacity:"+e+"}"+(u+.01)+"%{opacity:1}"+(u+t)%100+"%{opacity:"+e+"}"+"100%{opacity:"+f+"}"+"}",a.cssRules.length),i[o]=1),o}function l(e,t){var i=e.style,s,o;if(i[t]!==n)return t;t=t.charAt(0).toUpperCase()+t.slice(1);for(o=0;o<r.length;o++){s=r[o]+t;if(i[s]!==n)return s}}function c(e,t){for(var n in t)e.style[l(e,n)||n]=t[n];return e}function h(e){for(var t=1;t<arguments.length;t++){var r=arguments[t];for(var i in r)e[i]===n&&(e[i]=r[i])}return e}function p(e){var t={x:e.offsetLeft,y:e.offsetTop};while(e=e.offsetParent)t.x+=e.offsetLeft,t.y+=e.offsetTop;return t}var r=["webkit","Moz","ms","O"],i={},s,a=function(){var e=o("style",{type:"text/css"});return u(t.getElementsByTagName("head")[0],e),e.sheet||e.styleSheet}(),d={lines:12,length:7,width:5,radius:10,rotate:0,corners:1,color:"#000",speed:1,trail:100,opacity:.25,fps:20,zIndex:2e9,className:"spinner",top:"auto",left:"auto",position:"relative"},v=function m(e){if(!this.spin)return new m(e);this.opts=h(e||{},m.defaults,d)};v.defaults={},h(v.prototype,{spin:function(e){this.stop();var t=this,n=t.opts,r=t.el=c(o(0,{className:n.className}),{position:n.position,width:0,zIndex:n.zIndex}),i=n.radius+n.length+n.width,u,a;e&&(e.insertBefore(r,e.firstChild||null),a=p(e),u=p(r),c(r,{left:(n.left=="auto"?a.x-u.x+(e.offsetWidth>>1):parseInt(n.left,10)+i)+"px",top:(n.top=="auto"?a.y-u.y+(e.offsetHeight>>1):parseInt(n.top,10)+i)+"px"})),r.setAttribute("aria-role","progressbar"),t.lines(r,t.opts);if(!s){var f=0,l=n.fps,h=l/n.speed,d=(1-n.opacity)/(h*n.trail/100),v=h/n.lines;(function m(){f++;for(var e=n.lines;e;e--){var i=Math.max(1-(f+e*v)%h*d,n.opacity);t.opacity(r,n.lines-e,i,n)}t.timeout=t.el&&setTimeout(m,~~(1e3/l))})()}return t},stop:function(){var e=this.el;return e&&(clearTimeout(this.timeout),e.parentNode&&e.parentNode.removeChild(e),this.el=n),this},lines:function(e,t){function i(e,r){return c(o(),{position:"absolute",width:t.length+t.width+"px",height:t.width+"px",background:e,boxShadow:r,transformOrigin:"left",transform:"rotate("+~~(360/t.lines*n+t.rotate)+"deg) translate("+t.radius+"px"+",0)",borderRadius:(t.corners*t.width>>1)+"px"})}var n=0,r;for(;n<t.lines;n++)r=c(o(),{position:"absolute",top:1+~(t.width/2)+"px",transform:t.hwaccel?"translate3d(0,0,0)":"",opacity:t.opacity,animation:s&&f(t.opacity,t.trail,n,t.lines)+" "+1/t.speed+"s linear infinite"}),t.shadow&&u(r,c(i("#000","0 0 4px #000"),{top:"2px"})),u(e,u(r,i(t.color,"0 0 1px rgba(0,0,0,.1)")));return e},opacity:function(e,t,n){t<e.childNodes.length&&(e.childNodes[t].style.opacity=n)}}),function(){function e(e,t){return o("<"+e+' xmlns="urn:schemas-microsoft.com:vml" class="spin-vml">',t)}var t=c(o("group"),{behavior:"url(#default#VML)"});!l(t,"transform")&&t.adj?(a.addRule(".spin-vml","behavior:url(#default#VML)"),v.prototype.lines=function(t,n){function s(){return c(e("group",{coordsize:i+" "+i,coordorigin:-r+" "+ -r}),{width:i,height:i})}function l(t,i,o){u(a,u(c(s(),{rotation:360/n.lines*t+"deg",left:~~i}),u(c(e("roundrect",{arcsize:n.corners}),{width:r,height:n.width,left:n.radius,top:-n.width>>1,filter:o}),e("fill",{color:n.color,opacity:n.opacity}),e("stroke",{opacity:0}))))}var r=n.length+n.width,i=2*r,o=-(n.width+n.length)*2+"px",a=c(s(),{position:"absolute",top:o,left:o}),f;if(n.shadow)for(f=1;f<=n.lines;f++)l(f,-2,"progid:DXImageTransform.Microsoft.Blur(pixelradius=2,makeshadow=1,shadowopacity=.3)");for(f=1;f<=n.lines;f++)l(f);return u(t,a)},v.prototype.opacity=function(e,t,n,r){var i=e.firstChild;r=r.shadow&&r.lines||0,i&&t+r<i.childNodes.length&&(i=i.childNodes[t+r],i=i&&i.firstChild,i=i&&i.firstChild,i&&(i.opacity=n))}):s=l(t,"animation")}(),typeof define=="function"&&define.amd?define(function(){return v}):e.Spinner=v}(window,document);
$.fn.spinStart = function(opts) {  this.each(function() {    var $this = $(this), data = $this.data();    if (data.spinner) {      data.spinner.stop();      delete data.spinner;    }    if (opts !== false) {      data.spinner = new Spinner($.extend({color: $this.css('color')}, opts)).spin(this);    }  });  return this;};
$.fn.spinStop = function(opts) {  this.each(function() {    var $this = $(this), data = $this.data();    if (data.spinner) {      data.spinner.stop();      delete data.spinner;    }  });  return this;};
// $.toJSON $.parseJSON
(function($){var m={'\b':'\\b','\t':'\\t','\n':'\\n','\f':'\\f','\r':'\\r','"':'\\"','\\':'\\\\'},s={'array':function(x){var a=['['],b,f,i,l=x.length,v;for(i=0;i<l;i+=1){v=x[i];f=s[typeof v];if(f){v=f(v);if(typeof v=='string'){if(b){a[a.length]=','}a[a.length]=v;b=true}}}a[a.length]=']';return a.join('')},'boolean':function(x){return String(x)},'null':function(x){return"null"},'number':function(x){return isFinite(x)?String(x):'null'},'object':function(x){if(x){if(x instanceof Array){return s.array(x)}var a=['{'],b,f,i,v;for(i in x){v=x[i];f=s[typeof v];if(f){v=f(v);if(typeof v=='string'){if(b){a[a.length]=','}a.push(s.string(i),':',v);b=true}}}a[a.length]='}';return a.join('')}return'null'},'string':function(x){if(/["\\\x00-\x1f]/.test(x)){x=x.replace(/([\x00-\x1f\\"])/g,function(a,b){var c=m[b];if(c){return c}c=b.charCodeAt();return'\\u00'+Math.floor(c/16).toString(16)+(c%16).toString(16)})}return'"'+x+'"'}};$.toJSON=function(v){var f=isNaN(v)?s[typeof v]:s['number'];if(f)return f(v)};$.parseJSON=function(v,safe){if(safe===undefined)safe=$.parseJSON.safe;if(safe&&!/^("(\\.|[^"\\\n\r])*?"|[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t])+?$/.test(v))return undefined;return eval('('+v+')')};$.parseJSON.safe=false})(jQuery);

// $.addclass; $.removeclass
(function(){var rspace=/\s+/,rclass=/[\n\t\r]/g;jQuery.fn.extend({addClass:function(value){var classNames,i,l,elem,setClass,c,cl;if(jQuery.isFunction(value)){return this.each(function(j){jQuery(this).addClass(value.call(this,j,this.className));jQuery(this).trigger('addclass',value)})}if(value&&typeof value==="string"){classNames=value.split(rspace);for(i=0,l=this.length;i<l;i++){elem=this[i];var jQry=jQuery(elem);if(elem.nodeType===1){if(!elem.className&&classNames.length===1){elem.className=value}else{setClass=" "+elem.className+" ";for(c=0,cl=classNames.length;c<cl;c++){if(!~setClass.indexOf(" "+classNames[c]+" ")){setClass+=classNames[c]+" "}}elem.className=jQuery.trim(setClass)}}jQry.trigger('addclass',value)}}return this},removeClass:function(value){var classNames,i,l,elem,className,c,cl;if(jQuery.isFunction(value)){return this.each(function(j){jQuery(this).removeClass(value.call(this,j,this.className));jQuery(this).trigger('removeclass',value)})}if((value&&typeof value==="string")||value===undefined){classNames=(value||"").split(rspace);for(i=0,l=this.length;i<l;i++){elem=this[i];var jQry=jQuery(elem);if(elem.nodeType===1&&elem.className){if(value){className=(" "+elem.className+" ").replace(rclass," ");for(c=0,cl=classNames.length;c<cl;c++){className=className.replace(" "+classNames[c]+" "," ")}elem.className=jQuery.trim(className)}else{elem.className=""}}}jQuery(this).trigger('removeclass',value)}return this}})})();

if(typeof(ctx) == 'undefined') {
	ctx = '';
}

var cmsMsg = {
	ko: {
		requireField: '필수 입력 항목입니다',
		title: '제목',
		password: '비밀번호',
		contents: '내용'
	},
	en: {
		requireField: 'is a required field',
		title: 'Title',
		password: 'Password',
		contents: 'Contents'
	}
};

function loadJavascript(url, callback, charset) {

	loadedScript = typeof(loadedScript) == 'undefined' ? {} : loadedScript;

		$.ajaxSetup({async:false, cache: true});
		if($.isArray(url)) {

			$.each(url,function(i) {
				if(!loadedScript.hasOwnProperty(url[i])) {
					$.getScript(url[i], callback);
					loadedScript[url[i]] = true;
				}
			});

		} else {
			if(!loadedScript.hasOwnProperty(url)) {
				$.getScript(url, callback);
					loadedScript[url] = true;
			}
		}
		$.ajaxSetup({async:true, cache: false});

}


/**
 * 다국어 문자 리턴
 * @param {} code
 */
var isLoadMessageScript = false;
function $m(code,defaultMsg) {

	var retv;

	if(!isLoadMessageScript && typeof(messageCode) == 'undefined' && typeof(localeScriptPath) != 'undefined') {
		isLoadMessageScript = true;
		loadJavascript( localeScriptPath +'message_' + locale + '.js'  );

	} else
	if(typeof(messageCode) != 'undefined') {
		retv = messageCode[code];
	}

	if(!retv) {
		var lngCode;
		if(typeof(locale) !== 'undefined') {

			lngCode = cmsMsg[locale];
			retv = lngCode && lngCode.hasOwnProperty( code ) ? lngCode[code] : cmsMsg.ko[code];

		}

		if(!retv && defaultMsg) {
			retv = defaultMsg;
		}

		if(!retv) {
			retv = code;
		}
	}
	return retv;

}


App = {};
if(!$.browser) {
	$.browser = (function() {
		var s = navigator.userAgent.toLowerCase();
		var match = /(webkit)[ \/](\w.]+)/.exec(s) ||
		/(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) ||
		/(msie) ([\w.]+)/.exec(s) ||
		/(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
		[];
		return { name: match[1] || "", version: match[2] || "0" };
	}());
}

$.browser.ismobile = (/mobile|iphone|ipad|ipod|android|blackberry|symbian|mobi|polaris|iemobile|lgtelecom|nokia|sonyericsson|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()));
/*!
 * Bowser - a browser detector
 * https://github.com/ded/bowser
 * MIT License | (c) Dustin Diaz 2015
 */

!function(e,t){typeof module!="undefined"&&module.exports?module.exports=t():typeof define=="function"&&define.amd?define(e,t):this[e]=t()}("bowser",function(){function t(t){function n(e){var n=t.match(e);return n&&n.length>1&&n[1]||""}function r(e){var n=t.match(e);return n&&n.length>1&&n[2]||""}var i=n(/(ipod|iphone|ipad)/i).toLowerCase(),s=/like android/i.test(t),o=!s&&/android/i.test(t),u=/nexus\s*[0-6]\s*/i.test(t),a=!u&&/nexus\s*[0-9]+/i.test(t),f=/CrOS/.test(t),l=/silk/i.test(t),c=/sailfish/i.test(t),h=/tizen/i.test(t),p=/(web|hpw)os/i.test(t),d=/windows phone/i.test(t),v=/SamsungBrowser/i.test(t),m=!d&&/windows/i.test(t),g=!i&&!l&&/macintosh/i.test(t),y=!o&&!c&&!h&&!p&&/linux/i.test(t),b=n(/edge\/(\d+(\.\d+)?)/i),w=n(/version\/(\d+(\.\d+)?)/i),E=/tablet/i.test(t),S=!E&&/[^-]mobi/i.test(t),x=/xbox/i.test(t),T;/opera/i.test(t)?T={name:"Opera",opera:e,version:w||n(/(?:opera|opr|opios)[\s\/](\d+(\.\d+)?)/i)}:/opr|opios/i.test(t)?T={name:"Opera",opera:e,version:n(/(?:opr|opios)[\s\/](\d+(\.\d+)?)/i)||w}:/SamsungBrowser/i.test(t)?T={name:"Samsung Internet for Android",samsungBrowser:e,version:w||n(/(?:SamsungBrowser)[\s\/](\d+(\.\d+)?)/i)}:/coast/i.test(t)?T={name:"Opera Coast",coast:e,version:w||n(/(?:coast)[\s\/](\d+(\.\d+)?)/i)}:/yabrowser/i.test(t)?T={name:"Yandex Browser",yandexbrowser:e,version:w||n(/(?:yabrowser)[\s\/](\d+(\.\d+)?)/i)}:/ucbrowser/i.test(t)?T={name:"UC Browser",ucbrowser:e,version:n(/(?:ucbrowser)[\s\/](\d+(?:\.\d+)+)/i)}:/mxios/i.test(t)?T={name:"Maxthon",maxthon:e,version:n(/(?:mxios)[\s\/](\d+(?:\.\d+)+)/i)}:/epiphany/i.test(t)?T={name:"Epiphany",epiphany:e,version:n(/(?:epiphany)[\s\/](\d+(?:\.\d+)+)/i)}:/puffin/i.test(t)?T={name:"Puffin",puffin:e,version:n(/(?:puffin)[\s\/](\d+(?:\.\d+)?)/i)}:/sleipnir/i.test(t)?T={name:"Sleipnir",sleipnir:e,version:n(/(?:sleipnir)[\s\/](\d+(?:\.\d+)+)/i)}:/k-meleon/i.test(t)?T={name:"K-Meleon",kMeleon:e,version:n(/(?:k-meleon)[\s\/](\d+(?:\.\d+)+)/i)}:d?(T={name:"Windows Phone",windowsphone:e},b?(T.msedge=e,T.version=b):(T.msie=e,T.version=n(/iemobile\/(\d+(\.\d+)?)/i))):/msie|trident/i.test(t)?T={name:"Internet Explorer",msie:e,version:n(/(?:msie |rv:)(\d+(\.\d+)?)/i)}:f?T={name:"Chrome",chromeos:e,chromeBook:e,chrome:e,version:n(/(?:chrome|crios|crmo)\/(\d+(\.\d+)?)/i)}:/chrome.+? edge/i.test(t)?T={name:"Microsoft Edge",msedge:e,version:b}:/vivaldi/i.test(t)?T={name:"Vivaldi",vivaldi:e,version:n(/vivaldi\/(\d+(\.\d+)?)/i)||w}:c?T={name:"Sailfish",sailfish:e,version:n(/sailfish\s?browser\/(\d+(\.\d+)?)/i)}:/seamonkey\//i.test(t)?T={name:"SeaMonkey",seamonkey:e,version:n(/seamonkey\/(\d+(\.\d+)?)/i)}:/firefox|iceweasel|fxios/i.test(t)?(T={name:"Firefox",firefox:e,version:n(/(?:firefox|iceweasel|fxios)[ \/](\d+(\.\d+)?)/i)},/\((mobile|tablet);[^\)]*rv:[\d\.]+\)/i.test(t)&&(T.firefoxos=e)):l?T={name:"Amazon Silk",silk:e,version:n(/silk\/(\d+(\.\d+)?)/i)}:/phantom/i.test(t)?T={name:"PhantomJS",phantom:e,version:n(/phantomjs\/(\d+(\.\d+)?)/i)}:/slimerjs/i.test(t)?T={name:"SlimerJS",slimer:e,version:n(/slimerjs\/(\d+(\.\d+)?)/i)}:/blackberry|\bbb\d+/i.test(t)||/rim\stablet/i.test(t)?T={name:"BlackBerry",blackberry:e,version:w||n(/blackberry[\d]+\/(\d+(\.\d+)?)/i)}:p?(T={name:"WebOS",webos:e,version:w||n(/w(?:eb)?osbrowser\/(\d+(\.\d+)?)/i)},/touchpad\//i.test(t)&&(T.touchpad=e)):/bada/i.test(t)?T={name:"Bada",bada:e,version:n(/dolfin\/(\d+(\.\d+)?)/i)}:h?T={name:"Tizen",tizen:e,version:n(/(?:tizen\s?)?browser\/(\d+(\.\d+)?)/i)||w}:/qupzilla/i.test(t)?T={name:"QupZilla",qupzilla:e,version:n(/(?:qupzilla)[\s\/](\d+(?:\.\d+)+)/i)||w}:/chromium/i.test(t)?T={name:"Chromium",chromium:e,version:n(/(?:chromium)[\s\/](\d+(?:\.\d+)?)/i)||w}:/chrome|crios|crmo/i.test(t)?T={name:"Chrome",chrome:e,version:n(/(?:chrome|crios|crmo)\/(\d+(\.\d+)?)/i)}:o?T={name:"Android",version:w}:/safari|applewebkit/i.test(t)?(T={name:"Safari",safari:e},w&&(T.version=w)):i?(T={name:i=="iphone"?"iPhone":i=="ipad"?"iPad":"iPod"},w&&(T.version=w)):/googlebot/i.test(t)?T={name:"Googlebot",googlebot:e,version:n(/googlebot\/(\d+(\.\d+))/i)||w}:T={name:n(/^(.*)\/(.*) /),version:r(/^(.*)\/(.*) /)},!T.msedge&&/(apple)?webkit/i.test(t)?(/(apple)?webkit\/537\.36/i.test(t)?(T.name=T.name||"Blink",T.blink=e):(T.name=T.name||"Webkit",T.webkit=e),!T.version&&w&&(T.version=w)):!T.opera&&/gecko\//i.test(t)&&(T.name=T.name||"Gecko",T.gecko=e,T.version=T.version||n(/gecko\/(\d+(\.\d+)?)/i)),!T.msedge&&(o||T.silk)?T.android=e:i?(T[i]=e,T.ios=e):g?T.mac=e:x?T.xbox=e:m?T.windows=e:y&&(T.linux=e);var N="";T.windowsphone?N=n(/windows phone (?:os)?\s?(\d+(\.\d+)*)/i):i?(N=n(/os (\d+([_\s]\d+)*) like mac os x/i),N=N.replace(/[_\s]/g,".")):o?N=n(/android[ \/-](\d+(\.\d+)*)/i):T.webos?N=n(/(?:web|hpw)os\/(\d+(\.\d+)*)/i):T.blackberry?N=n(/rim\stablet\sos\s(\d+(\.\d+)*)/i):T.bada?N=n(/bada\/(\d+(\.\d+)*)/i):T.tizen&&(N=n(/tizen[\/\s](\d+(\.\d+)*)/i)),N&&(T.osversion=N);var C=N.split(".")[0];if(E||a||i=="ipad"||o&&(C==3||C>=4&&!S)||T.silk)T.tablet=e;else if(S||i=="iphone"||i=="ipod"||o||u||T.blackberry||T.webos||T.bada)T.mobile=e;return T.msedge||T.msie&&T.version>=10||T.yandexbrowser&&T.version>=15||T.vivaldi&&T.version>=1||T.chrome&&T.version>=20||T.samsungBrowser&&T.version>=4||T.firefox&&T.version>=20||T.safari&&T.version>=6||T.opera&&T.version>=10||T.ios&&T.osversion&&T.osversion.split(".")[0]>=6||T.blackberry&&T.version>=10.1||T.chromium&&T.version>=20?T.a=e:T.msie&&T.version<10||T.chrome&&T.version<20||T.firefox&&T.version<20||T.safari&&T.version<6||T.opera&&T.version<10||T.ios&&T.osversion&&T.osversion.split(".")[0]<6||T.chromium&&T.version<20?T.c=e:T.x=e,T}function r(e){return e.split(".").length}function i(e,t){var n=[],r;if(Array.prototype.map)return Array.prototype.map.call(e,t);for(r=0;r<e.length;r++)n.push(t(e[r]));return n}function s(e){var t=Math.max(r(e[0]),r(e[1])),n=i(e,function(e){var n=t-r(e);return e+=(new Array(n+1)).join(".0"),i(e.split("."),function(e){return(new Array(20-e.length)).join("0")+e}).reverse()});while(--t>=0){if(n[0][t]>n[1][t])return 1;if(n[0][t]!==n[1][t])return-1;if(t===0)return 0}}function o(e,r,i){var o=n;typeof r=="string"&&(i=r,r=void 0),r===void 0&&(r=!1),i&&(o=t(i));var u=""+o.version;for(var a in e)if(e.hasOwnProperty(a)&&o[a])return s([u,e[a]])<0;return r}function u(e,t,n){return!o(e,t,n)}var e=!0,n=t(typeof navigator!="undefined"?navigator.userAgent||"":"");return n.test=function(e){for(var t=0;t<e.length;++t){var r=e[t];if(typeof r=="string"&&r in n)return!0}return!1},n.isUnsupportedBrowser=o,n.compareVersions=s,n.check=u,n._detect=t,n})

if(typeof(rootPath) == 'undefined') {
	rootPath = '';
}
if(typeof(printSelector) == 'undefined') {
	printSelector = '#jwxe_main_content';
}

// String prototype -------------------------------------------
String.prototype.encodeURI = function( url ) {
	return encodeURIComponent(this);
}

String.prototype.test = function(regex, params){
	return ((typeof regex == 'string') ? new RegExp(regex, params) : regex).test(this);
}

String.prototype.contains= function(string, separator){
	return (separator) ? (separator + this + separator).indexOf(separator + string + separator) > -1 : this.indexOf(string) > -1;
}

String.prototype.trim= function(){
	return this.replace(/^\s+|\s+$/g, '');
}

String.prototype.clean= function(){
	return this.replace(/\s+/g, ' ').trim();
}

String.prototype.camelCase= function(){
	return this.replace(/-\D/g, function(match){
		return match.charAt(1).toUpperCase();
	});
}

String.prototype.hyphenate= function(){
	return this.replace(/[A-Z]/g, function(match){
		return ('-' + match.charAt(0).toLowerCase());
	});
}

String.prototype.capitalize= function(){
	return this.replace(/\b[a-z]/g, function(match){
		return match.toUpperCase();
	});
}

String.prototype.escapeRegExp= function(){
	return this.replace(/([-.*+?^${}()|[\]\/\\])/g, '\\$1');
}

String.prototype.toInt= function(base){
		return parseInt(this, base || 10);
	}

String.prototype.toFloat= function(){
	return parseFloat(this);
}

String.prototype.hexToRgb= function(array){
	var hex = this.match(/^#?(\w{1,2})(\w{1,2})(\w{1,2})$/);
	return (hex) ? hex.slice(1).hexToRgb(array) : null;
}

String.prototype.rgbToHex= function(array){
	var rgb = this.match(/\d{1,3}/g);
	return (rgb) ? rgb.rgbToHex(array) : null;
}

String.prototype.stripScripts= function(option){
	var scripts = '';
	var text = this.replace(/<script[^>]*>([\s\S]*?)<\/script>/gi, function(){
		scripts += arguments[1] + '\n';
		return '';
	});
	if (option === true) $exec(scripts);
	else if ($type(option) == 'function') option(scripts, text);
	return text;
}

String.prototype.htmlEncode = function(){
	return this.replace(/&/g, "&amp;").replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g, "&quot;");
}

String.prototype.htmlDecode = function(){
  return this.replace(/&gt;/g, ">").replace(/&lt;/g, "<").replace(/&quot;/g, '"').replace(/&amp;/g, "&");
}


String.prototype.substitute= function(object, regexp){
	return this.replace(regexp || (/\\?\{([^{}]+)\}/g), function(match, name){
		if (match.charAt(0) == '\\') return match.slice(1);
		return (object[name] != undefined) ? object[name] : '';
	});
}


String.prototype.replaceAll = function(FindString, ReplaceString) {
	if(!FindString) return FindString;
	var SearchIndex = 0;
	var NewString = "";
	while (this.indexOf(FindString,SearchIndex) != -1)    {
  	NewString += this.substring(SearchIndex,this.indexOf(FindString,SearchIndex));
  	NewString += ReplaceString;
  	SearchIndex = (this.indexOf(FindString,SearchIndex) + FindString.length);
 	}
	NewString += this.substring(SearchIndex,this.length);
	return NewString;
}

String.prototype.startsWith = function(compareString) {
	return this.substring(0,compareString.length) == compareString;
}

String.prototype.endsWith = function(compareString) {
	return this.substring(this.length-compareString.length) == compareString;
}

function startsWith(value, compareString) {
	if(typeof(value) != 'string') return false;
	return value.startsWith(compareString);
}

function toCommaString(n) {
  var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
  n += '';                          // 숫자를 문자열로 변환

  while (reg.test(n))
    n = n.replace(reg, '$1' + ',' + '$2');

  return n;
}
//-----------------------------------------------
// 쿼리스트링을 오브젝트로 컨버트
// querystring to param
// @param {} value
// @return {}
//
//-----------------------------------------------
jQuery.unparam = function ( value ) {

	value = value || location.search;
    if(value.startsWith('?')) {
	    	value = value.substring(1);
    }

    var
    params = {},
    pieces = value.split('&'),
    pair, i, l;

    for (i = 0, l = pieces.length; i < l; i++) {
        pair = pieces[i].split('=', 2);
        params[decodeURIComponent(pair[0])] = (pair.length == 2 ?
            decodeURIComponent(pair[1].replace(/\+/g, ' ')) : true);
    }
    return params;
};



//각종 상수값들
/*
left side quick menu가 윈도우가 작아지는 경우 본문을 가릴 수 있음. 그래서 최소값을 지정.
만약 이 값을 여기서 정의만 되며 변경이 필요하면 user.js에서 변경하여 사용할 것.
*/
var jwxe_left_quick_min_x = 0; // 초기에는 작 잡혀있음
var max_zIndex=100;
var _anchors = [];
//var _scroll_btns = [];
window.jwxe = {};
andwise = {
	popupbtns:{ // 팝업존 가이드 버튼들
	}
};

//select theme
//document.write('<script type="text/javascript" src="'+rootPath+'/_common/js/select/dropkick.1-0.1.js"></script>');

$(function(){

	//$.body = $(document.body);

	//select dropkick
	/*
	$('.select-gray').dropkick();
	$('.select-black').dropkick({
			theme: 'black'
	});*/
});



//*************************************************************
// 배경이미지 오버/아웃
// id, sson_url, sson_over_bg, sson_out_bg, sson_sel_over_bg, sson_sel_out_bg,
// ssoff_url, ssoff_over_bg, ssoff_out_bg, ssoff_sel_over_bg, ssoff_sel_out_bg,
//*************************************************************
function jwxe_changeBgCss(obj,url) {

	// 이미지 타입
	//if(!url) return;
	if(obj.get(0).bgObj.imageTag) {
		if(!url) return;
		obj.get(0).bgObj.imageTag.src = url;
	} else {
		//백그라운드 타입
		obj.css('background-image','url('+url+')');
	}
	//$(obj).fadeIn('fast');
}

function jwxe_setMouseOverOut(obj, over_bg, out_bg){

	//$(
	//	function() {
			obj.mouseenter(function(){
		  		jwxe_changeBgCss($(this),over_bg);

		  });
			obj.focus(function(){
		  		jwxe_changeBgCss($(this),over_bg);

		  });
	//	}
	//)

	//$(
	//	function() {
			obj.mouseleave(function(){
				//if($(this).parents('.jwxe_menu_box2').length == 0)  // tab menu, main menu 는 마우스아웃을 금지
				var jqry = $(this), cls;
				if((cls = jqry.parent().parent().attr('class')) && cls.test(/jwxe_menu_box0|jwxe_menu_box2/) == false ) {// tab menu 는 마우스아웃을 금지
					if(!jqry.get(0).bgObj.select) { // 선택이 되었으면 변동 없음
		  			jwxe_changeBgCss(jqry,out_bg);
					}
				}
		  });
			obj.blur(function(){
				//if($(this).parents('.jwxe_menu_box2').length == 0)  // tab menu 는 마우스아웃을 금지
				var jqry = $(this), cls;
				if((cls = jqry.parent().parent().attr('class')) && cls.test(/jwxe_menu_box0|jwxe_menu_box2/) == false ) {// tab menu 는 마우스아웃을 금지
					if(!jqry.get(0).bgObj.select) { // 선택이 되었으면 변동 없음
			  		jwxe_changeBgCss($(this),out_bg);
					}
				}
		  });
	//	}
	//)


 }


function jwxe_changeBg(obj){
	_anchors.push(obj);
}

function jwxe_expand(a) {
	if(a.next().length > 0) {
		$(a.next().get(0)).css("display","block");
	}
}


function jwxe_bubble_select(el) {

	// 메인 메뉴 이면 셀렉트를 취소
	//if(el.parents('[class^="jwxe_menu_box0"]').length > 0 ) return;

	// 메인메뉴 버블을  취소
	var pel = el.parentsUntil('.jwxe_menu_box0').parent('.jwxe_menu_box0');
	if(pel.attr('bubble') == 'false') {
		//1번만 취소
		//pel.attr('bubble','true');
		return;
	}

	var j, parent = el.parent().parent(), tagName = parent.prop('tagName'), a, className = parent.attr('class');

	// 부모를 펼친다.
	//while (tagName && tagName.toLowerCase() == "ul" && parent.css("display") == "none" && className != 'jwxe_menu_box0' && className != 'jwxe_menu_box0_relative') {
	while (tagName && tagName.toLowerCase() == "ul" ) {

		a = parent.prev();

		parent.css("display", "block");
		if(a && (tag = a.prop('tagName')) && tag.toLowerCase() == 'a') {

			j = a.get(0);
			if(j && j.bgObj) {

				j.bgObj.select = true;
				jwxe_changeBGProc(j.bgObj);
			}
		}

		parent = a.parent().parent();
		tagName = parent.prop('tagName');

	}

	// 자식을 펼친다.
	var nxt = el.next();

	if(nxt.length > 0 && nxt.prop('tagName').toLowerCase() == 'ul') {
		nxt.css('display','block');
	}

}

function jwxe_set_select( obj ) {

	if(!obj) return;

	var a, j;

	if(typeof(obj) == 'string') {
		a = $('#'+obj);
		j = a.get(0);
	}	else {
		a = $(obj);
		j = obj;
	}
	if(!j.bgObj) {
		var ul;
		//if((ul = a.next()) && ul.length>0 && ul.get(0).tagName.toLowerCase() == 'ul' && (ul.attr('display') || ul.attr('focused'))) {
		if((ul = a.next('ul')) && ul.find('.jw_selected').length > 0 ) {
			ul.css('display','block');
		}
  	return;
  }

	j.bgObj.select = true;
	jwxe_changeBGProc(j.bgObj);

}


function jwxe_changeBGProc(obj) {

	var sson_url = obj.sson_url?obj.sson_url:obj.ssoff_url;
	var ssoff_url = obj.ssoff_url;
	var el = $('#'+obj.id);

	if(!el.length) return;

	el.get(0).bgObj = obj;
	obj.el = el;


	// background 인지 image tg 인지
	obj.imageTag = el.children('img').get(0);

	// 이미 jwxe_bubble_select 에 의하여 지정 되었으면
	if(obj.assinged) {
	}

	// 메인메뉴에 있는 anchor 인지

	if(_so_) {

		//if(_thisUrl.indexOf(sson_url) > -1 ) { // session on, selected
		//el.get(0).selectBg = obj.sson_sel_out_bg;
		if(obj.select == true) { // session on, selected
			//var sson_sel_over_bg = obj.sson_sel_over_bg ? obj.sson_sel_over_bg : (obj.ssoff_sel_over_bg?obj.ssoff_sel_over_bg:obj.ssoff_over_bg);
			$( function() { jwxe_bubble_select(el); } );
			if(obj.sson_sel_out_bg) {
				$( function(){
						obj.outBg = obj.sson_sel_out_bg;
						jwxe_changeBgCss(el, obj.sson_sel_out_bg);
					}
				);
				if(obj.sson_sel_over_bg ) {
					obj.outBg = obj.sson_sel_out_bg;
					obj.overBg = obj.sson_sel_over_bg;
					jwxe_setMouseOverOut(el,obj.sson_sel_over_bg,obj.sson_sel_out_bg);
				}
			} else {
				if(obj.sson_out_bg) {
					$( function() {
							obj.outBg = obj.sson_out_bg;
							jwxe_changeBgCss(el,obj.sson_out_bg);
						}
					)
					if(obj.sson_over_bg ) {
						obj.outBg = obj.sson_out_bg;
						obj.overBg = obj.sson_over_bg;
						jwxe_setMouseOverOut(el,obj.sson_over_bg,obj.sson_out_bg);
					}
				} else {
					if(obj.ssoff_sel_out_bg) {

						$( function() {
								obj.outBg = obj.ssoff_sel_out_bg;
								jwxe_changeBgCss(el,obj.ssoff_sel_out_bg);
							}
						)

						if(obj.ssoff_sel_over_bg) {
							obj.outBg = obj.ssoff_sel_out_bg;
							obj.overBg = obj.ssoff_sel_over_bg;
							jwxe_setMouseOverOut(el,obj.ssoff_sel_over_bg,obj.ssoff_sel_out_bg);
						}
					} else {

						if(obj.ssoff_over_bg && obj.ssoff_out_bg) {
							obj.outBg = obj.ssoff_out_bg;
							obj.overBg = obj.ssoff_out_bg;
							jwxe_setMouseOverOut(el,obj.ssoff_over_bg,obj.ssoff_out_bg);
						}

					}

				}
			}

		}	else {
			if(obj.sson_out_bg) {
				$( function() {
						obj.outBg = obj.sson_out_bg;
						jwxe_changeBgCss(el,obj.sson_out_bg);
					}
				)
				if(obj.sson_over_bg) {
					obj.outBg = obj.sson_out_bg;
					obj.overBg = obj.sson_over_bg;
					jwxe_setMouseOverOut(el,obj.sson_over_bg,obj.sson_out_bg);
				}
			} else {
				//if(obj.ssoff_over_bg && obj.ssoff_out_bg) {
					// 오버만 있으면  가능
				if(obj.ssoff_over_bg) {
					obj.outBg = obj.ssoff_out_bg;
					obj.overBg = obj.ssoff_over_bg;
					jwxe_setMouseOverOut(el,obj.ssoff_over_bg,obj.ssoff_out_bg);
				}
			}
		}

	} else {


		if(obj.select == true) { // session on, selected
			$( function() { jwxe_bubble_select(el); } );
			if(obj.ssoff_sel_out_bg) {
				$( function() {
						obj.outBg = obj.ssoff_sel_out_bg;
						jwxe_changeBgCss(el,obj.ssoff_sel_out_bg);
					}
				)
				if(obj.ssoff_sel_over_bg) {
					obj.outBg = obj.ssoff_sel_out_bg;
					obj.overBg = obj.ssoff_sel_over_bg;
					jwxe_setMouseOverOut(el,obj.ssoff_sel_over_bg,obj.ssoff_sel_out_bg);
				}
			} else {

				if(obj.ssoff_over_bg && obj.ssoff_out_bg) {
					obj.outBg = obj.ssoff_out_bg;
					obj.overBg = obj.ssoff_over_bg;
					jwxe_setMouseOverOut(el,obj.ssoff_over_bg,obj.ssoff_out_bg);
				}

			}

		}	else {
			//if(obj.ssoff_over_bg && obj.ssoff_out_bg) {
			if(obj.ssoff_over_bg) {
				obj.outBg = obj.ssoff_out_bg;
				obj.overBg = obj.ssoff_over_bg;
				jwxe_setMouseOverOut(el,obj.ssoff_over_bg,obj.ssoff_out_bg);
			}
		}

	}

	obj.assinged = true;
}

/*************************************************************
// 엥커 마우스 오버/아웃/셀렉트 , 공통
*************************************************************/

$(
	function() {

		var selected = false, key, i, obj, url, objs = [], curUrl = document.location.href, found = false, menu_cd;

		var lastIndex = curUrl.indexOf('?');
		if(lastIndex >= 0)
			curUrl = curUrl.substring(0,lastIndex);

		//셀렉트를 판단
		for(i=0; i<_anchors.length; i++) {

			obj = _anchors[i];

			url = obj.ssoff_url || '';

			menu_cd = obj.menu_cd;

			if(!menu_cd && (!url || url == '' || url == '#')) continue;

			if(url) {
				if (_so_) {
					url = obj.sson_url ? obj.sson_url : obj.ssoff_url;
				}
				url = _thisHost + url.trim().replace(_thisHost,'');

				lastIndex = url.indexOf('?');
				if(lastIndex >= 0)
					url = url.substring(0,lastIndex);
			}


			obj.select = false;
			var tmp;
			if((menu_cd && _cur_menu_cd && menu_cd == _cur_menu_cd) || curUrl == url ) {
				selected = true;
				obj.select = true;
				found = true;
				var item = $('#' + obj.id);
				item.addClass('jw_selected');

			} else if(url && curUrl.indexOf(url) > -1) {
				////obj.length = url.length;
				////objs.push( obj );
			}

		}


		for (i = 0; i < _anchors.length; i++) {
			jwxe_changeBGProc(_anchors[i]);
		}

	}

)

$(

	/* anchor 커스텀 태그에서 판단한 선택여부를 script에 적용
	 *
	 */

	function() {
		$('a[class~=jw_selected]').each(function() {
				//this.bgObj.select = true;
				var jObj = $(this);

				if(this.bgObj && this.bgObj.select == false) {

					this.bgObj.select = true;

					jwxe_changeBGProc(this.bgObj);
				}

		});
	}


)






function subMenuClassOverOut( submnu ) {

		this.element = submnu;
		// on class 넣어 주기
		this.allLinks = this.element.find('a');
		var self = this;

		this.allLinks.mouseenter(function(event) {
			self.onLinkOver.call(self,$(this),event);
		}).mouseleave(function(event) {
			self.onLinkOut.call(self,$(this),event);
		});

}

subMenuClassOverOut.prototype = {
	onLinkOver: function(a, event, tag) {

		if(a.length == 0) return;

		a.addClass('over');
		a.next('ul').addClass('over');
		a.parentsUntil(this.element).children('ul').prev('a').addClass('over');
		a.parentsUntil(this.element).addClass('over');

	},

	onLinkOut: function(a, event) {

		if(a.length == 0) return;

			a.removeClass('over');
			a.next('ul').removeClass('over');
			a.parent('li').parent('ul').prev('a').removeClass('over');
			a.parentsUntil(this.element).children('ul').prev('a').removeClass('over');
			a.parentsUntil(this.element).removeClass('over');

	}
}

$(
	function() {

		$('.jwxe_menu_box1').each(function() {
			var submnu = $(this);
			// on class 넣어 주기
			new subMenuClassOverOut(submnu);
		});

		$('.jwxe_menu_box1 a').css('position','relative');
		$('.jwxe_menu_box1 .jwxe_menu_box1').each( function() {
			var obj = $(this);
			if(obj.css('position') == 'absolute' && obj.css('left').toInt() == 0 && obj.css('top').toInt() == 0 ) {
				obj.css('position','relative');
			}
		});


		// 링크가 없고 하위가 ul 인것만 클릭 이벤트 생성
		var jwxe_menu_box1_focused = false;
		var jwxe_menu_box1_time;
		var jwxe_menu_box1_keydown = false;
		$('.jwxe_menu_box1 a').each(function(){
			var anchor = $(this);
			var next = anchor.next(), tagName;
			if(next.length > 0) {
				var tagName = next.prop('tagName').toLowerCase();
				var href = anchor.attr('href');
				if(tagName == 'ul' && anchor.hasClass('jw_selected')) {
						next.css('display','block');
				}
				if(tagName == 'ul' && (href == '' || typeof(href) == 'undefined' || href.substring(0,1) == '#')) {
				//if(tagName == 'ul') {
					if(anchor.hasClass('jw_selected')) {
						next.css('display','block');
					}
					anchor.click(function(e) {
						e.preventDefault();
						if(jwxe_menu_box1_focused) {
							jwxe_menu_box1_focused = false;
							return;
						}
 					  	$(this).next('ul').stop().slideToggle('fast');
						return false;
					});
				} else {
					anchor.click(function() {
				    if(jwxe_menu_box1_time) {
				      clearTimeout(jwxe_menu_box1_time);
				    }
				    return true;
				  });
				}
			}
		});

//		if(!$.browser.msie) {
			$(".jwxe_menu_box1 a").keydown(function(e) {
				jwxe_menu_box1_keydown = true;
			});

			$(".jwxe_menu_box1 a").focus(function(e) {
			  	var anchor = $(this);
					jwxe_menu_box1_focused = true;
					var next = anchor.next(), tagName;
					if(next.length > 0 ) {
						if(jwxe_menu_box1_keydown) {
								next.find('.jwxe_menu_box1').css('display','block');
								var tagName = next.get(0).tagName.toLowerCase();
								if(tagName == 'ul') {
									next.fadeIn('fast');
								}
						} else {
							jwxe_menu_box1_time = setTimeout( function() {
									next.find('.jwxe_menu_box1').css('display','block');
									var tagName = next.get(0).tagName.toLowerCase();
									if(tagName == 'ul') {
										next.fadeIn('fast');
									}
							},200);
						}
						jwxe_menu_box1_keydown = false;
					}
			});
//		}


	}
)

/*************************************************************
// 플래시 삽입
*************************************************************/

$(

	function() {


		// flash wrapper div의  display:none 를 제거한다
		$('.jwxe_flash').each(function(){

			if(this.style.display == 'none') {
				this.style.display = 'block';
			}

		});

	}



);

/*************************************************************
// 탭처리
*************************************************************/

$(
	function() {
		// 버튼 위치 정리
		$("a[class=jwxe_popup_close]").each(function() {
			var el = $(this);
			el.css({top:(el.parent().height()-24)+'px', left:(el.parent().width()-54)+'px'});
		});
		$("a[class=jwxe_popup_close_1]").each(function() {
			var el = $(this);
			el.css({top:(el.parent().height()-24)+'px', left:(el.parent().width()-168)+'px'});
		});
		$("a[class=jwxe_popup_close_7]").each(function() {
			var el = $(this);
			el.css({top:(el.parent().height()-24)+'px', left:(el.parent().width()-168)+'px'});
		});

	}
);

/*************************************************************
// 설문  처리
*************************************************************/
$(
	function() {
		var vote_objs = $("input[class=jwxe_survey_vote]");
		vote_objs.css("top", (vote_objs.parent().parent().parent().height() - 39) + "px");
		vote_objs.css("left", (vote_objs.parent().parent().parent().width() - 92) + "px");

		var q_objs = $("div[class=jwxe_survey_q]");
		q_objs.css("width", (q_objs.parent().parent().parent().parent().width() - 50) + "px");

		var r_objs = $("div[class=jwxe_survey_r]");
		r_objs.css("width", (r_objs.parent().width() - 50) + "px");
	}
)

/*************************************************************
// JWXE_A_MASTER인 경우 처리 Mouse Over, Focus에 반응하는 Layer 관련 Script
*************************************************************/
// 먼저 모두 숨겨준다.
$(
	function() {
		$('.jwxe_a_master').next().css("display","none");
	}
)

$(
	function() {
		$('.jwxe_a_master').focus(
			function() {
				$('.jwxe_a_master').next().css("display","none");
				$('.jwxe_a_master').next().css("z-index", "");
				$(this).next().css("z-index",max_zIndex);
				$(this).next().css("display","block");
				//$(this).next().fadeIn();
			}
		)
	}
)
$(
	function() {
		$('.jwxe_a_master').mouseenter(
			function() {
				$('.jwxe_a_master').next().css("display","none");
				$('.jwxe_a_master').next().css("z-index", "");
				$(this).next().css("z-index",max_zIndex);
				$(this).next().css("display","block");
				//$(this).next().fadeIn();
			}
		)
	}
)


/**********************************************************************
// submit 버튼의 value 를 제거한다
**********************************************************************/
$(
	function() {
		$('.jwxe_input_submit').attr("value", "");
	}
)


/**********************************************************************
// 확대/축소/출력 스크립트
**********************************************************************/
var current_zoom = 100;
var jwxe_zoomIn = function() {
  if($.browser.msie){    // IE
  	if($.browser.version >= 8) {
			current_zoom += 10;
  		$("body").children().css("zoom", current_zoom + "%");
		} else {
			current_zoom += 2;
  		$("body *").css("zoom", current_zoom + "%");
			$('div[class$="_left"]').parent().css('width','auto');
		}
    return;
	}
	alert("표준 브라우저에서의 확대/축소는 브라우저의 기능을 이용합니다.\n화면 확대: 키보드의 control키와 '+'를 동시에 누릅니다.\n화면 축소: 키보드의 control키와 '-'를 동시에 누릅니다.");
}
var jwxe_zoomDef = function() {
  if($.browser.msie){    // IE
  	current_zoom = 100;
  	if($.browser.version >= 8) {
  		$("body").children().css("zoom", "100%");
		} else {
  		$("body *").css("zoom", "100%");
		}
    return;
	}
	alert("표준 브라우저에서의 확대/축소는 브라우저의 기능을 이용합니다.\n화면 확대: 키보드의 control키와 '+'를 동시에 누릅니다.\n화면 축소: 키보드의 control키와 '-'를 동시에 누릅니다.");
}
var jwxe_zoomOut = function() {
  if($.browser.msie ){    // IE
  	if($.browser.version >= 8) {
	  	current_zoom -= 10;

	  	$("body").children().css("zoom", current_zoom + "%");
		} else {
	  	current_zoom -= 2;
	  	$("body *").css("zoom", current_zoom + "%");
		}
    return;
	}
	alert("표준 브라우저에서의 확대/축소는 브라우저의 기능을 이용합니다.\n화면 확대: 키보드의 control키와 '+'를 동시에 누릅니다.\n화면 축소: 키보드의 control키와 '-'를 동시에 누릅니다.");
}
var jwxe_print = function() {

	var max_div = $(printSelector);

	if(max_div.length == 0) {

		var arr = $('div[class*="lo_"]');
		var max_tb = 0;

		for(var i=0;i<arr.length;i++) {
			var emt = $(arr.get(i));
			var tmp_tb = emt.height() * emt.width();
			if(tmp_tb > max_tb) {
				max_tb = tmp_tb;
				max_div = emt;
			}
		}
	}

	if(max_div != null) {
		var pf = $('#jwxe_print_form'), link;
		if(pf.length > 0) {
			var links = $('link');
			for(var i=0; i<links.length; i++) {
				link = $('<input type="hidden" name="links"/>');
				link.attr('value',links.get(i).href);
				link.appendTo(pf)
			}
			pf.get(0).contents.value = Base64.encode(max_div.html());
			pf.get(0).submit();
			pf.get(0).contents.value = '';
			pf.find('input[name="links"]').remove();
		}
	}

	return false;

	/*
	var p = $(this);
	do {
		p = p.parent();
		var cls = p.attr("class")
	} while(!(cls.length > 3 && cls.substring(0,3) == "lo_"));

	var pf = document.getElementById("jwxe_print_form");
	pf.contents.value = p.attr("outerHTML");
	pf.submit();
	*/
}

$(
	function() {


		var current_zoom = 1.0;
		var cur_line = 1.2;
		var current_font_step = 0;
		var isInitFont = false;

		var jwxe_zoomInFont = function() {
				if(!isInitFont) {
					initFont();
				}
				current_font_step ++;
	  		$("body *").each(function() {
		  		var $this = $(this);
		  		if($this.data('font-size')) {
		  			$this.css("font-size", ($this.data('font-size').toInt()+current_font_step)+ "px");
		  		}
	  		});
		}

		var jwxe_zoomDefFont = function() {
				if(!isInitFont) {
					initFont();
				}
				current_font_step = 0;
	  		$("body *").each(function() {
		  		var $this = $(this);
		  		if($this.data('font-size')) {
			  		$this.css("font-size",$this.data('font-size'));
		  		}
	  		});
		}
		var jwxe_zoomOutFont = function() {
				if(!isInitFont) {
					initFont();
				}
				current_font_step --;
	  		$("body *").each(function() {
		  		var $this = $(this);
		  		if($this.data('font-size')) {
			  		$this.css("font-size",($this.data('font-size').toInt()+current_font_step)+ "px");
		  		}
	  		});
		}

		var initFont = function() {
				isInitFont = true;
	  		$("body *").each(function() {
		  		var $this = $(this);
		  		$this.data("font-size",$this.css('font-size'));
	  		});
		}

		if(typeof(zooInOutMode) == 'undefined' || zooInOutMode == 'screen') {

			$("#jwxe_zoomIn").click(jwxe_zoomIn);
			$("#jwxe_zoomOut").click(jwxe_zoomOut);
			$("#jwxe_zoomDef").click(jwxe_zoomDef);

		} else {

			$("#jwxe_zoomIn").click(jwxe_zoomInFont);
			$("#jwxe_zoomOut").click(jwxe_zoomOutFont);
			$("#jwxe_zoomDef").click(jwxe_zoomDefFont);

		}

		var obj = $("#jwxe_print");
		if(obj.length > 0) {
			obj.click(jwxe_print);
			if(!obj.attr('href')) {
				obj.attr({
					'href': rootPath+'/_common/template/print.jsp',
					'title': '새창으로 프린트'
				});
			}
			var str = "<form id='jwxe_print_form' action='"+rootPath+"/_common/template/print.jsp' method='post' target='_blank'>" +
			"<input type='hidden' name='contents' value='123'/>" +
			"</form>";
			$("body").append(str);
		}
	}
)


/**********************************************************************
// 퀵메뉴 스크립트(상하 스크롤)
**********************************************************************/

$(function(){

  $('.jwxe_quick_menu').each(function() {
      var $this = $(this);
      var max = document.documentElement.scrollHeight || document.body.scrollHeight;
      var orignTop = $this.css('top').toInt();
      var height = $this.height();
      //var userQuickMax = $('.foot_up').offset().top;
    $(window).scroll(function() {
      var mx = typeof(userQuickMax)!='undefined'? userQuickMax: max;
      var offset = $this.offset();
      var top = document.documentElement.scrollTop || document.body.scrollTop;
      if(top  + height > mx ) {
        top = mx - height - orignTop;
      }
      $this.stop().animate({'top':  top + orignTop },500);


    });

  });

});


/**********************************************************************
// 퀵메뉴 스크립트 (상단 고정)
**********************************************************************/

$(function(){

	var _quickSideMenuBox = $('.jwxe_quick_side_menu, .jwxe_quick_right_side_menu');

	var _quickSideMenuBoxWidth, _body, _quickRightMinTop;

	if(_quickSideMenuBox.length > 0) {
		_quickRightMinTop = _quickSideMenuBox.css('top').toInt();
		_quickSideMenuBoxWidth = _quickSideMenuBox.css('width').toInt();
		_body = $('body');
	}

	var _quickSideChange = function( firstLoading ) {
		var el;

		if(_quickSideMenuBox.length <= 0) return;

		if ($.browser.safari) {
	  	el =  document.body;
		} else {
	  	el =  document.documentElement;
		}

		var top; // = el.scrollTop;
		if(startsWith(_quickSideMenuBox.get(0).className,'jwxe_quick_right_side_menu')) {
			if (el.scrollTop > _quickRightMinTop) {
	  		top = el.scrollTop;
	  	} else {
	  		top = _quickRightMinTop;
			}
		} else {
			top = el.scrollTop;
		}

		var offsetWidth = el.offsetWidth;
		var left = el.scrollLeft+offsetWidth;//   Math.max(document.documentElement.scrollWidth, document.body.scrollWidth);

		// 최소값의 적용
		if(left < jwxe_left_quick_min_x)
			left = jwxe_left_quick_min_x;

		if($.browser.msie) {
			left -= 4;

			if($.browser.version == 6.0 || el.scrollHeight > el.offsetHeight) {
				if($.browser.version == 6.0 )
					left -= 13;
				else
					left -= 17;
			}
		}
		_quickSideMenuBox.stop();
		_quickSideMenuBox.animate({top: top, left: left - _quickSideMenuBoxWidth}, 400);
	}

	if(_quickSideMenuBox.length) {
		$(_body.children().get(1)).after(_quickSideMenuBox);
		_quickSideMenuBox.css('z-index',1000);
	}

	$(window).load(function(){ //윈도우에 스크롤값이 변경될때마다
		_quickSideChange( true );
	});

	$(window).scroll(function(){ //윈도우에 스크롤값이 변경될때마다
			_quickSideChange();
	});

 	var resizeTimer;
	if ($.browser.msie) {
  	window.onresize = function(){
  		clearTimeout(resizeTimer);
  		resizeTimer = setTimeout(_quickSideChange, 100);
  	}
  } else {
		$(window).resize(function() {
			_quickSideChange();
		    clearTimeout(resizeTimer);
		    resizeTimer = setTimeout(_quickSideChange, 100);
		});
	}

	/*
	var resizeTimer;
	$(window).resize(function() {
		_quickSideChange();
	    clearTimeout(resizeTimer);
	    resizeTimer = setTimeout(_quickSideChange, 100);
	});*/

	_quickSideChange( true );

});

/*
 * 구글맵 로딩 함수
 */
var loadGoogleMap = function( opt ) {
	this.load(opt);
}
loadGoogleMap.prototype = {

	load: function(opt) {

		var self = this;
		var dom = document.getElementById(opt.id)

		this.latlng = new google.maps.LatLng(opt.lat, opt.lng);

		var options = {
			zoom: opt.zoom,
			center: this.latlng,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	  }

	  this.map = new google.maps.Map(dom , options);

		var marker = new google.maps.Marker({
	    position: this.latlng,
	    map: this.map
	  });


	  this.infowindow = new google.maps.InfoWindow({
			content: opt.content,
	    position: this.latlng
	  });
	  this.infowindow.open(this.map);


		google.maps.event.addListener(marker, "click", function() {
	 		self.infowindow.open(self.map);
	 	});
	}

}


/**
 * 구글 맵 API 수정
 */
function JwxeGoogleInitMap() {
		
	var lat = $("#jwxe-google-map").data("map-lat");
	var lng = $("#jwxe-google-map").data("map-lng");
	var title = $("#jwxe-google-map").data("title");
	
	
    var center = {lat: parseFloat(lat), lng: parseFloat(lng) };
    var map = new google.maps.Map(document.getElementById('jwxe-google-map'), {
      zoom: 17,
      center: center
    });

    var contentString = '<div id="content">'+
        '<p>' + title + '</p>'
        '</div>';

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    var marker = new google.maps.Marker({
      position: center,
      map: map
    });
    
    infowindow.open(map, marker);
    
}



/*****************************
 * 달력 초기화
 */
function initCalendar(id, isEmpty){
	$(
		function() {
			var obj;

			if(typeof(id) == 'string') {
			 obj = $('#'+id);
			} else {
				obj = id;
			}
			if(!isEmpty) {
				obj.each(function() {
					var item = $(this);
					if(!item.attr("value")) {
						item.attr("value",new Date().getDateString("YYYY-MM-DD"));
					}
				});
			}

			obj.datepicker({
				changeMonth: true,
				changeYear: true,
				yearRange: '2009:2020'
			});
		}
	)

}


		/*****************************
		 * 날짜 포맷
		 */

		Number.prototype.to2 = function() { return (this > 9 ? "" : "0")+this; };
		Date.MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		Date.DAYS   = ["Sun", "Mon", "Tue", "Wed", "Tur", "Fri", "Sat"];
		Date.prototype.getDateString = function(dateFormat) {
		  var result = "";

		  dateFormat = dateFormat == 8 && "YYYY.MM.DD" ||
		               dateFormat == 6 && "hh:mm:ss" ||
		               dateFormat ||
		               "YYYY.MM.DD hh:mm:ss";
		  for (var i = 0; i < dateFormat.length; i++) {
		    result += dateFormat.indexOf("YYYY", i) == i ? (i+=3, this.getFullYear()                     ) :
		              dateFormat.indexOf("YY",   i) == i ? (i+=1, String(this.getFullYear()).substring(2)) :
		              dateFormat.indexOf("MMM",  i) == i ? (i+=2, Date.MONTHS[this.getMonth()]           ) :
		              dateFormat.indexOf("MM",   i) == i ? (i+=1, (this.getMonth()+1).to2()              ) :
		              dateFormat.indexOf("M",    i) == i ? (      this.getMonth()+1                      ) :
		              dateFormat.indexOf("DDD",  i) == i ? (i+=2, Date.DAYS[this.getDay()]               ) :
		              dateFormat.indexOf("DD",   i) == i ? (i+=1, this.getDate().to2()                   ) :
		              dateFormat.indexOf("D"   , i) == i ? (      this.getDate()                         ) :
		              dateFormat.indexOf("hh",   i) == i ? (i+=1, this.getHours().to2()                  ) :
		              dateFormat.indexOf("h",    i) == i ? (      this.getHours()                        ) :
		              dateFormat.indexOf("mm",   i) == i ? (i+=1, this.getMinutes().to2()                ) :
		              dateFormat.indexOf("m",    i) == i ? (      this.getMinutes()                      ) :
		              dateFormat.indexOf("ss",   i) == i ? (i+=1, this.getSeconds().to2()                ) :
		              dateFormat.indexOf("s",    i) == i ? (      this.getSeconds()                      ) :
		                                                   (dateFormat.charAt(i)                         ) ;
		  }
		  return result;
		};




	function jwxe_popupWindow( url, width, height, target, scrollbars, resizable) {
		var tar = "";
		var properties = "";

		if( target ) tar = target;
		if( width ) properties += ", width=" + width;
		if( height ) properties += ", height=" + height;
		if( scrollbars ) properties += ", scrollbars=yes";
		if( resizable ) properties += ", resizable=yes";

		properties = properties.substring(2);

		var win = window.open( url, tar, properties );
		win.focus();

		//return win;
	}

// 개발 모드가 아니면 페이지 전환시 쿠키 삭제
var forceDevMode = false;
var forceRealMode = false;
if(typeof(developMode) == 'undefined' || developMode == false) {

	$(window).unload(function() {
		if(!forceDevMode) {
				$.setCookie( 'develop_preview_mode', 'N', {
					  duration : 0,
					  path : '/',
					  domain : '',
					  secure : false
				});
				$.delCookie('develop_preview_mode');
		}
	});

}	else {
	if(developMode == true) {
		// 개발모드이면 페이지 전환시 쿠기 생성
		$(window).unload(function() {
			if(!forceRealMode) {
				$.setCookie( 'develop_preview_mode', 'Y', {
				  duration : 0,
				  path : '/',
				  domain : '',
				  secure : false
				});
			}
		});
	}

}


if(typeof(_edit_content) != 'undefined' && _edit_content) {

	var editDivs = [];
	var tmpStart, cStart;
	var trace = {}, _editBtnWrap, _editBtn_, _pajetBtn;
	//var _site_id = typeof(_siteId) == 'undefined'?    _thisUrl.replace(_thisHost,'');
	//_site_id = _site_id.substring(1,_site_id.indexOf('/',1));

	var _parseDom = function( html ) {

		//wrapper.css({display:'none'});
		//$('body').append(wrapper);

		//cStart = _findFirst(wrapper);

	}

	var _showEditBtn = function(html, onlyMainYn, mainItemKey) {


		_editBtn_ = $('<button class="jw-edit-btn" id="_jwxe_edit_content" >'+$m('편집')+'</button>');

		_editBtnWrap = $('<div class="jw-edit-btn-wrap" style="padding-top:50px;clear:both;text-align:right;position:relative;z-index:101">').append(_editBtn_);

		// 개발 모드 사용 여부
		if(typeof(_cfgUseDevMode) != 'undefined' && _cfgUseDevMode) {
			var modeNm = '운영';
			if(typeof(developMode) == 'undefined') {
				// 개발모드로 전환 버튼
				var devBtn = $('<a id="_jwxe_dev_mode" style="cursor:pointer;margin-left:10px;" ><img src="'+rootPath+'/_common/img/btn-dev.gif" alt=""/></a>');
				_editBtnWrap.append(devBtn);
				devBtn.click(function() {
					forceDevMode = true;
					forceRealMode = false;
					$.setCookie( 'develop_preview_mode', 'Y', {
						  duration : 0,
						  path : '/',
						  domain : '',
						  secure : false
					});
					location.href = sysPath+'/proc/call_dev_page.jsp?url=' + encodeURIComponent( location.pathname );
				});
			} else {
				// 운영모드로 전환 버튼
				modeNm = '개발';
				var realBtn = $('<a id="_jwxe_real_mode" style="cursor:pointer;margin-left:10px;" ><img src="'+rootPath+'/_common/img/btn-real.gif" alt=""/></a>');
				realBtn.click(function() {
					forceDevMode = false;
					forceRealMode = true;
					$.setCookie( 'develop_preview_mode', null, {
						  duration : -1,
						  path : '/',
						  domain : '',
						  secure : false
					});
					$.delCookie('develop_preview_mode');
					location.href = sysPath+'/proc/call_preview_page.jsp?url=' + encodeURIComponent( location.pathname );
				});
				_editBtnWrap.append(realBtn);
			}

		}
		var body = $('body');
		body.append(_editBtnWrap);


		_editBtn_.click(function(e){


			if(typeof(_pajetBtn) !== 'undefined') {
				if(_pajetBtn.is(':visible')) {
					_pajetBtn.hide();
				} else {
					_pajetBtn.show();
				}
			}

			e.preventDefault();

			if(editDivs.length > 0) {
				for(var i=0; i<editDivs.length; i++) {
					editDivs[i].parent().removeClass('cms-editing');
					editDivs[i].remove();
				}
				editDivs = [];
				$('.jwxe_root').fadeTo('fast',1);
				_editBtn_.text($m('편집'));
				return;

			}


			var _cntItem = body.find( 'Y' == onlyMainYn ? printSelector : '[class*="lo_"],[class*="cms-edit"]')  ;
			var wrapper = $('<div>'+html+'</div>');
			var tmpItem = wrapper.find( 'Y' == onlyMainYn ? printSelector : '[class*="lo_"],[class*="cms-edit"]')  ;

			for(var i=0; i<tmpItem.length; i++ ) {

				var tmp = $(tmpItem.get(i));

				//console.log(tmp);
				if(tmp.attr('board_id') || !tmp.attr('item')) continue;

				try {
					var content = $(_cntItem.get(i));
				} catch(e) {
					continue;
				}

				if(!content || content.length == 0) continue;
				var root = content;
				root.fadeTo('fast',.5);
				root.addClass('cms-editing');

				var href = sysPath+'/jwxe.jsp?_site='+_siteId+'&_edit=Y&_key='+encodeURIComponent(tmp.attr('item'))
				+(typeof(developMode) != 'undefined' && developMode == true ? '&developMode=Y': '');

				var btn = $('<a class="cms-edit-btn" title="'+$m('편집')+'" href="'+href+'" target="'+tmp.attr('item')+'"><img class="cms-edit-img" src="'+rootPath+'/_common/img/tick-button.png" alt="'+$m('편집')+'" /></a>');

				btn.css({
					cursor: 'pointer',
					position: 'absolute',
					right: 0,
					top: parseInt((root.height() /2)-16)+'px',
					bottom: 0,
					'z-index': 10000
				});
				btn.mouseenter(function() {
					$(this).parent().fadeTo('fast',1);
				});
				btn.mouseleave(function() {
					$(this).parent().fadeTo('fast',.5);
				});
				root.append(btn);
				editDivs.push(btn);


				var west = $('<div class="cms-edit-cnt"></div>');
				west.css({
					position: 'absolute',
					'border-left': '1px dotted blue',
					top: 0,
					left: 0,
					width: '1px',
					height: '100%'
				});
				root.append(west);
				editDivs.push(west);

				var north = $('<div class="cms-edit-cnt"></div>');
				north.css({
					position: 'absolute',
					'border-top': '1px dotted blue',
					top: 0,
					left: 0,
					height: '1px',
					width: '100%'
				});

				root.append(north);
				editDivs.push(north);

				var east = $('<div class="cms-edit-cnt"></div>');
				east.css({
					position: 'absolute',
					'border-right': '1px dotted blue',
					top: 0,
					right: 0,
					width: '1px',
					height: '100%'
				});

				root.append(east);
				editDivs.push(east);

				var south = $('<div class="cms-edit-cnt"></div>');
				south.css({
					position: 'absolute',
					'border-bottom': '1px dotted blue',
					left: 0,
					bottom: 0,
					height: '1px',
					width: '100%'
				});

				root.append(south);
				editDivs.push(south);

			}

			wrapper.remove();

			if(editDivs.length == 0) {
				if(mainItemKey) {
					window.open( sysPath + "/jwxe.jsp?_edit=Y&_site="+ _siteId +"&_key="+ mainItemKey );
				} else {
					alert('편집 가능한 컨텐츠가 존재하지 않습니다.\n페이지 관리에서 편집할 컨텐츠를 메인컨텐츠로 지정하세요');
				}
				return false;
			}


			_editBtn_.text($m('취소'));

			return false;
		});

	}

	$(function() {


		if(typeof(front_page_edit) == 'undefined' || front_page_edit == false) return;

		var _key = location.pathname;
		if (_key.endsWith('.jsp') ) {
			_key = _key.substring(0, _key.lastIndexOf('.jsp') + 4);
		} else if (_key.endsWith('.do')) {
			_key = _key.substring(0, _key.lastIndexOf('.')) + ".jsp";
		} else {
			_key = _key+'index.jsp';
		}



		$.ajax({
			url: rootPath + '/_common/jsp/auth/check_edit_auth.jsp?dc='+new Date().getTime(),
			data: {
				_key: _key
			},
			dataType: 'json',
			success: function(data) {
				if(typeof(data.success) != 'undefined' && data.success == true) {

					sysPath = data.path;

					_showEditBtn(data.html, data.only_main_yn || 'N', data.main_item );

					if(typeof(locale) !== 'undefined' && locale == 'ko') {
						_showPajetBtn();
					}

					if(typeof(showEditBtnCallback) !== 'undefined') {
						showEditBtnCallback();
					}


				}
			}
		});

	})
}

function _showPajetBtn() {

	_pajetBtn = $('<button class="jw-edit-btn">'+$m('접근성검사')+'</button>');
	_editBtnWrap.append( _pajetBtn );

	_pajetBtn.click(function() {

		loadJavascript(ctx+'/_common/js/pajet.js');

		accessibilityCheck();

	});


}


function jwxeKeyPress(evt, callBack) {

	evt = (evt) ? evt : (window.event) ? event : null;
  if (evt)
  {
    var charCode = (evt.charCode) ? evt.charCode :((evt.keyCode) ? evt.keyCode :((evt.which) ? evt.which : 0));
    if (charCode == 13) {
			callBack();
		}
  }

}




/*************************************************************
// 팝업코드 처리
*************************************************************/

$(
	function() {

		// 복사된 팝업의 아이디 정리
		if(typeof(_siteId) !== 'undefined') {
			$('a[class^=jwxe_popup_close_]').each(function() {
				var name = $(this).attr('name');
				name = _siteId + '_' + name.substring( name.indexOf('1') );
				$(this).attr('name',name);
			});
		}

		var popups = $(".jwxe_popup");

		if(popups.length > 0) {

			popups.css({'z-index':1001});

			var w = 0;
			var left = 0;
			/*
			var divs = $("div[class^=lo_]");
			if(divs.length > 0) {
				w = parseInt($(divs[0]).css("width"));
				left = $(divs[0]).position().left;
			} else {
				w = 1000;
			}*/


			if ($.browser.safari) {
		  	el =  document.body;
			} else {
		  	el =  document.documentElement;
			}
			w = el.offsetWidth;

			var sw = 0;
			for (var i = 0; i < popups.length; i++) {
				popups[i] = $(popups[i]);
				sw += popups[i].width()+20;
			}


			left = (parseInt((w-sw)/2) );
			if(left < 0) left = 0;

			// 팝업의 초기 위치 user.js
			left = typeof(user_popup_left) == 'undefined' ? left: user_popup_left;
			var top = typeof(user_popup_top) == 'undefined' ? 150: user_popup_top;

			for(var i=0;i<popups.length;i++) {
				var p = popups[i];
				var wrap = p.parent();
				// 새창 팝업은 스킵
				if(wrap.hasClass('popup-window')) {
					continue;
				}


				if(wrap.hasClass('popup-wrap')) {
					left = wrap.css('left').toInt();
					top = wrap.css('top').toInt();
					p.unwrap();
				} else
				if(i!=0) {
					left += (popups[i-1].width())+20;
				}

				p.css("left", left + "px");
				p.css("top", top+"px");
			}

				// 그림자
			for(var i=0; i<popups.length; i++) {
				if(popups.get(i).parent().hasClass('popup-window')) {
					popups.get(i).css('visibility','visible');
					continue;
				}

				if(popups.get(i).draggable) {
					popups.get(i).draggable();
				}

				popups.get(i).css('visibility','visible');
			}
		}

		$("a[class=jwxe_popup_close]").click(
			function() {
				if($(this).parent('.jwxe_popup').parent().hasClass('popup-window')) {
					// 새창
					self.close();
				} else {
					// 레이어
					var parent = $(this).parent('.jwxe_popup');
					parent.remove();
				}
				return false;
			}
		);

		$("a[class=jwxe_popup_close_7]").click(
			function() {
				var nm = $(this).attr("name");

				$.setCookie( nm, 'true', {
				  duration : 7, // In days
				  path : '/',
				  domain : '',
				  secure : false
				});

				if($(this).parent('.jwxe_popup').parent().hasClass('popup-window')) {
					// 새창
					self.close();
				} else {
				  // 레이어
					var parent = $(this).parent('.jwxe_popup');
					parent.remove();

				}

				return false;
				//console.log($.readCookie(nm));
			}
		);

		$("a[class=jwxe_popup_close_1]").click(
			function() {

				var nm = $(this).attr("name");

				$.setCookie( nm, 'true', {
				  duration : 1, // In days
				  path : '/',
				  domain : '',
				  secure : false
				});

				if($(this).parent('.jwxe_popup').parent().hasClass('popup-window')) {
					// 새창
					self.close();
				} else {
					// 레이어
					var parent = $(this).parent('.jwxe_popup');
					parent.remove();
				}

				return false;
				//console.log($.readCookie(nm));
			}
		);

	}

)

$(function(){
		$(".jwxe_popup").css({'z-index':1001});

})


/**
 * 추천 / 반대
 */
function recommend(obj,article_no,mode) {

		$.ajax({
			url: rootPath+'/_common/jsp/recommend/set_point.jsp?dc='+new Date().getTime(),
			data: {
				mode: mode,
				article_no: article_no
			},
			dataType: 'json',
			success: function(data) {
				if(typeof(data.success) != 'undefined') {
					if (data.success == true) {
		  			$(obj).html('<em>' + data.cnt + '</em>');
		  		} else {
						if(data.msg) {
							alert(data.msg);
						}
					}
				}
			}
		});

}

function drawNaverMap(id, pointX, pointY, width, height, detail ){

	var oPoint = new nhn.api.map.LatLng(pointX, pointY);
	nhn.api.map.setDefaultPoint('LatLng');
	var oMap = new nhn.api.map.Map(id, {
		point: oPoint,
		zoom: 10,
		enableWheelZoom: true,
		enableDragPan: true,
		enableDblClickZoom: false,
		mapMode: 0,
		activateTrafficMap: false,
		activateBicycleMap: false,
		minMaxLevel: [1, 14],
		size: new nhn.api.map.Size(width, height)
	});

	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);

	var oMarker = new nhn.api.map.Marker(oIcon, { title : '' });
	oMarker.setPoint(oPoint);
	oMap.addOverlay(oMarker);

	if(detail == true) {

		var mapZoom = new nhn.api.map.ZoomControl();
		mapZoom.setPosition({left:10, top:10});
		oMap.addControl(mapZoom);

		var mapTypeChangeButton = new nhn.api.map.MapTypeBtn(); // - 지도 타입 버튼 선언
		 mapTypeChangeButton.setPosition({top:10, left:50}); // - 지도 타입 버튼 위치 지정
		 oMap.addControl(mapTypeChangeButton);


	}

}

function loadCSS(url) {

	loadedCss = typeof(loadedCss) == 'undefined' ? {} : loadedCss;

	if(loadedCss.hasOwnProperty(url)) {
		return;
	}

	loadedCss[url] = true;

   var head = document.getElementsByTagName("head")[0];
   var css = document.createElement("link");

   css.setAttribute("rel", "stylesheet");
   css.setAttribute("type", "text/css");
   css.setAttribute("href",url);
   head.appendChild(css);
}

/**
 * 게시판에서 youtube 사용
 * class="jwxe-youtubue src"
 */
var youtubeGen = function(){

	$('.jwxe-youtube').each(function() {
		var item = $(this), style = item.attr('style');
		var isWidth = style && style.indexOf('width') > -1;
		/*var width = (isWidth? item.css('width').toInt():560);
		var height = (isWidth? item.css('height').toInt():315);*/

		/*var center = style && style.indexOf('margin') > -1 && style.indexOf('auto') > -1;*/
		var src = item.attr('class');
		src = src.substring(src.indexOf(' ')+1);
		if(src) {
			var html = '<div class="b-video-box"><iframe title="유투브 동영상" align="center" src="https://www.youtube.com/embed/'+src+'?wmode=transparent" frameborder="0" allowfullscreen';
			html += '></iframe></div>';
			item.outerHTML(html);
		}
	});

}

$(function(){
	youtubeGen();
});


/*
$(function() {
	// https 제거
	if(typeof(_thisHost) == 'undefined') return;

  var _thisScheme = _thisHost.substring(0,_thisHost.indexOf('/')-1);
  if(_thisScheme != 'https') return;
  var _thisDomain = _thisHost.substring(_thisHost.lastIndexOf('/')+1);
	if(_thisDomain.indexOf(':') > -1) {
		_thisDomain = _thisDomain.substring(0,_thisDomain.indexOf(':'));
	}
  $('a').each(function() {
    var item = $(this);
    var href = item.attr('href');
    if(!href) return;
    if(!href.startsWith('https')) {
        return;
    }
    item.attr('href','http://'+_thisDomain+href);
  });
});
*/

Andwise.ns('Andwise.app');

/**
 * validator 유효성 검사 클래스
 *
 * 엘리먼트의 class 에 jwvalid 로 시작한다.
 * jwvalid-xxxx 					-> xxx는 정규식 비교 ex) 								jwvalid-must-name
 * jwvalid-xxxx-yyyy 			-> yyyy 는 타이틀 (이름은, 나이는, ...)  	jwvalid-num-tel
 * jwvalid-xxxx-yyyy-zzz 	-> zzz 는 변수 	jwvalid-min-tel-4
 */

Andwise.app.Validator = function( $form ) {

	if($form && !$form.jquery) {
		$form = $($form);
	}

	if($form) {
		this.items = $form.find('input[class*="jwvalid-"],select[class*="jwvalid-"],textarea[class*="jwvalid-"]');
	} else {
		this.items = $('input[class*="jwvalid-"],select[class*="jwvalid-"],textarea[class*="jwvalid-"]');
	}

}


/**
 * must: 필수입력
 * min: 최소 길이 제한
 * max: 최대 길이 제한
 * len: 길이가 반드시 일치
 * a0: 영문,숫자가 반드시 포함
 * a0s: 영문,숫자,특수문자가 반드시 포함
 * aA0s: 영문소, 영문대, 숫자, 특수문자가 반드시 포함
 * mail: 메일형식 검사 (abc@abc.com)
 * mailtail : 메일형식 중 도메인만 검사 (abc.com)
 * tel: 전화번호 형식과 일치 (02-123-1234)
 * mobile: 휴대폰번호 형식과 일치 (011-123-1234)
 * zipcode: 우편번호 형식과 일치 (123-123)
 * num: 숫자 입력만 가능
 * date: 날짜 형식과 일치 yyyy-mm-dd
 *
 * addTitle( key, title)  // 정의되지 않은 타이틀을 추가한다.
 *
 * .pwd-chk 클래스가 있는 input 는 (모바일,전화번호) 비밀번호와 비교
 * ex)
 * function onSubmit() {
 * 	var validator = new Andwise.app.Validator();
 * 	validator.addTitle('cpwd','현재 비밀번호');
 * 	validator.addTitle('npwd','변경할 비밀번호');
 * 	return validator.valid();
 * }
 *
 */

$(function() {

	$('form.jw-form-valid').each(function() {

		var $this = $(this);
		$this.submit(function() {

			var validator = new Andwise.app.Validator($this);
			return validator.valid();
		});
	});

});
Andwise.app.Validator.prototype = {

	regex: {
		// 필수입력  ex) jwvalid-must-id
		must: {
			hanTail: ['은','는'],
			msg: function() { return $m('requireField'); },
			valid: function(val) { return val === true || (val && val.length > 0) ? true: false; }
		},
		// 최소 입력 ex) jwvalid-min-id-5
		min: {
			hanTail: ['의','의'],
			msg: function() { return String.format( $m('pw.minLength','{0} 자 이상 이어야 합니다.'), this.len);  },
			len: 0,
			valid: function(val, len ) { if(!val) return true; this.len = len; return val && val.length >= this.len  ? true: false; }
		},
		// 최대 입력 ex) jwvalid-max-name-16
		max: {
			hanTail: ['의','의'],
			msg: function() { return String.foramt($m('pw.maxLength','{0} 자 이하만 가능합니다.'), this.len); },
			len: 0,
			valid: function(val, len ) { if(!val) return true; this.len = len; return val && val.length <= this.len  ? true: false; }
		},
		// 길이가 일치
		len: {
			hanTail: ['의','의'],
			msg: function() { return ' 길이는 '+this.len+'자 이어야 합니다.'; },
			len: 0,
			valid: function(val, len ) { if(!val) return true; this.len = len; return val && val.length == this.len  ? true: false; }
		},
		// 영어 숫자 조합
		a0: {
			hanTail: ['은','는'],
			msg: function() { return '영어와 숫자가 모두 포함되어야 합니다.'; },
			valid: function(val) {
				if(!val) return true;
				return /^(?=.*\d)(?=.*[a-zA-Z]).+$/.test(val);
			}
		},
		// 영어,숫자,특수문자 조합
		a0s: {
			hanTail: ['은','는'],
			msg: function() { return '영어, 숫자, 특수문자가 모두 포함되어야 합니다.'; },
			valid: function(val) {
				if(!val) return true;
				return /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[^0-9a-zA-Z]).+$/.test(val);
			}
		},
		// 영어 대문자, 영어 소문자 ,숫자,특수문자 조합
		aA0s: {
			hanTail: ['은','는'],
			msg: function() { return '영어 소문자, 영어 대문자 ,숫자, 특수문자가 모두 포함되어야 합니다.'; },
			valid: function(val) {
				if(!val) return true;
				return /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[^0-9a-zA-Z]).+$/.test(val);
			}
		},
		// 이메일
		mail: {
			hanTail: ['의','의'],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) abc@abc.com'; },
			valid: function(val) {
				if(!val) return true;
				return /^[_a-zA-Z0-9\.\-]+@[\._a-zA-Z0-9\-]+\.[a-zA-Z]{2,}/.test(val);
			}

		},
		// 특수문자 거부
		nospchar: {
			hanTail: ['의','의'],
			msg: function() { return $m('형식오류','특수 문자를 사용할 수 없습니다.')+' ex) a-bc.123_123'; },
			valid: function(val) {
				if(!val) return true;
				return /[_a-zA-Z0-9\.\-]+/.test(val);
			}

		},		// 이메일 도메인
		emaildomain: {

			hanTail: ['의','의'],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) abc.com'; },
			valid: function(val) {
				if(!val) return true;
				return /^[\._a-zA-Z0-9\-]+\.[a-zA-Z]{2,}$/.test(val);
			}

		},
		// 사업자 등록번호
		saupno: {
			hanTail: ['의','의'],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) 123-12-12345'; },
			valid: function(val) {
				if(!val) return true;
				return /^[0-9]{3}\-[0-9]{2}\-[0-9]{5}$/.test(val);
			}

		},

		// 이메일 뒷부분만 체크
		mailtail: {
			hanTail: ['',''],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) abc.com'; },
			valid: function(val) {
				if(!val) return true;
				return /^[\._a-zA-Z0-9\-]+\.[a-zA-Z]{2,}/.test(val);
			}

		},
		// 전화번호 체크
		tel: {
			hanTail: ['',''],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) 02-123-1234 또는 010-123-1234'; },
			valid: function(val) {
				if(!val) return true;
				return /^0[0-9]{1,2}-[0-9]{3,4}-[0-9]{4}$/.test(val);
			}

		},
		// 휴대폰번호 체크
		mobile: {
			hanTail: ['',''],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) 010-123-1234'; },
			valid: function(val) {
				if(!val) return true;
				return /^01[0-9]-[0-9]{3,4}-[0-9]{4}$/.test(val);
			}

		},
		// 숫자만 가능
		num: {
			hanTail: ['은','는'],
			msg: function() { return $m('숫자만','숫자만 입력이 가능합니다.'); },
			valid: function(val) {
				if(!val) return true;
				return /^[0-9]+$/.test(val);
			}

		},
		// 우편번호
		zipcode: {
			hanTail: ['',''],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) 123-123'; },
			valid: function(val) {
				if(!val) return true;
				return /^[0-9]{3}-[0-9]{3}$/.test(val);
			}

		},
		docOnly: {
			hanTail: ['은','는'],
			msg: function() { return '문서 파일만 업로드가 가능합니다. (docx, doc, pdf, hwp)'},
			valid: function(val) {
				if(!val) return true;
				return /\.(docx|doc|pdf|hwp)$/i.test(val);
			}
		},
		imgfile: {
			hanTail: ['은','는'],
			msg: function() { return '이미지 파일만 업로드가 가능합니다. (gif, bmp, png, jpg, jpeg)'},
			valid: function(val) {
				if(!val) return true;
				return /\.(png|bmp|jpg|gif)$/i.test(val);
			}
		},

		moviefile: {
			hanTail: ['은','는'],
			msg: function() { return '동영상 파일만 업로드가 가능합니다. (mp4)'},
			valid: function(val) {
				if(!val) return true;
				return /\.(mp4)$/i.test(val);
			}
		},

		xlsfile: {
			hanTail: ['은','는'],
			msg: function() { return '엑셀 파일만 업로드가 가능합니다. (xls)'},
			valid: function(val) {
				if(!val) return true;
				return /\.xls$/i.test(val);
			}
		},
		// 날짜형식
		date: {
			hanTail: ['의','의'],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex) 2013-05-05'; },
			valid: function(val) {
				if(!val) return true;
				return /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/.test(val);
			}

		},
		url: {
			hanTail: ['은','는'],
			msg: function() { return $m('형식오류','형식에 맞지 않습니다.')+' ex)http://www.abc.com'; },
			valid: function(val) {
				if(!val) return true;
				return /^((http(s?))\:\/\/)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?$/.test(val);
			}

		},
		// 지정한 값보다 작거나 같아야함
		// 예) 날짜 범위에서 시작일이 종료일 보다 클경우
		// jwvalid-less-startdt-enddt
		less: {
			hanTail: ['은','는'],
			msg: function() { return ' 종료 보다 클 수 없습니다.;' },
			valid: function( val, targetName, $this ) {

				if(val > $('[name='+targetName+']').val()) {
					return false;
				}

				return true;

			}

		},
		// 지정한 값보다 크거나 같아야함
		// 예) 날짜 범위에서 시작일이 종료일 보다 클경우
		// jwvalid-less-startdt-enddt
		greater: {
			hanTail: ['은','는'],
			msg: function() { return ' 시작 보다 작을 수 없습니다.;' },
			valid: function( val, targetName, $this ) {

				if(val < $('[name='+targetName+']').val()) {
					return false;
				}

				return true;

			}
		},

		equals : {
			hanTail: ['은','는'],
			msg: function() { return ' 동일해야 합니다.' },
			valid: function( val, targetName, $this ) {

				if(val != $('[name='+targetName+']').val()) {
					return false;
				}

				return true;

			}
		},
		// 안전한 비밀번호
		// .pwd-chk 클래스가 있는 input 는 (모바일,전화번호) 비밀번호와 비교
		pwd: {
			hanTail: ['은','는'],
			msg: function() { return this.message; },
			len: 0,
			valid: function(val, len, $this ) {
				var retv = true;
				this.message = '동일한 문자가 연속으로 3회이상 들어갈 수 없습니다.';
				for(var i=0; i<val.length; i++) {
					var sub = val.substring(i);
					if(sub.length < 3) {
						retv = true;
						break;
					}
					var ch = sub.substring(0,1);
					if(sub.substring(1,2) == ch && sub.substring(2,3) == ch) {
						retv = false;
						break;
					}
				}
				// 휴대폰 또는 전화번호 체크
				var form = $this.parents('form');
				if(retv && $this.parents('form').length > 0) {

					this.message = '휴대폰 또는 전화번호중 세자이상 동일한 숫자를 사용할 수 없습니다.';
					form.find('.pwd-chk').each(function() {
						var value = $(this).val().replace(/-/g,'');
						for(var i=0; i<value.length; i++) {
							if(i+3 > value.length) {
								return false;
							}
							var sub = value.substring(i,i+3); // 3개 문자 추출
							if(val.indexOf(sub) > -1) {
								retv = false;
								return false;
							}

						}
					});

				}

				return retv;
			}
		}

	},

	title: {
		continent: '대륙구분', name: '이름', sex: '성별', id: '아이디', pwd: $m('password'), repwd: '비밀번호 확인란', mail: '이메일', tel: '전화번호', mobile: '휴대폰번호',
		zipcode: '우편번호', addr: '주소', article_title: $m('title'), article_text: $m('contents'), saupno : '사업자등록번호', category: '분류', search_val: '검색어',
		emailid: '이메일 아이디', emaildomain: '이메일 도메인', title: $m('title'), contents: $m('contents'), url: 'URL 경로', captcha: '보안문자', upload: '업로드'
	},

	// 타이틀을 추가한다.
	addTitle: function(key, title) {

		this.title[key] = title;

	},

	// 종성이 받침으로 끝나는지 여부
	isHanTail : function( a ) {

		if(a.length > 1) {
			a = a.substring(a.length-1);
		}
		var r = (a.charCodeAt(0) - parseInt('0xac00',16)) % 28;
		var t = String.fromCharCode(r + parseInt('0x11A8') -1);

		return (t.charCodeAt(0) != 4519);

	},

	valid: function() {

		var item, type, className, index, classes, regexKey, value, regVal;

		try {

			for(var i=0; i<this.items.length; i++) {

				item = $(this.items[i]);

				if(!item.is(':visible') ) {
					continue;
				}

				className = item.attr('class').replace(/\s{2,20}/g,' ');
				classes = className.split(' '); // 클래스를 분리한다.

				for(var j=0; j<classes.length; j++) {
					className = classes[j];
					index = className.indexOf('jwvalid-');
					// validator class 가 존재
					if(index > -1) {
						var strs = className.split('-');

						// 정규식 key 추출
						regexKey = strs[1];
						if(!this.regex.hasOwnProperty(regexKey)) {
							//throw '클래스명 '+className+' 에서 regex key 추출 오류';
							alert('develop error : 클래스명 '+className+' 에서 regex key 추출 오류');
							return false;
						}

						// 타이틀 추출*********************************

						var attrTitle = item.attr('data-valid-title'), step = 3;
						// 타이틀이 어트리뷰트 data-valid-title 에 지정되어 있으면 그 값을 타이틀로 사용
						if(attrTitle) {
							typeKey = Math.random();
							this.title[typeKey] = attrTitle;
							step = 2;
						} else {

							typeKey = strs[2];
							if(!this.title.hasOwnProperty(typeKey)) {
								//throw '클래스명 '+className+' 에서 type key 추출 오류';
								this.title[typeKey] = typeKey;
							}

						}


						// 그외의 변수 추출
						regVal = '';
						if(strs.length > step) {
							regVal = strs[step];
						}

						// 값추출
						value = this.getValue(item);


						/* 검증 */
						if(!this.regex[regexKey].valid( value, regVal, item )) {

							if(this.alertFunction) {
								this.alertFunction( this.getValidMessage(typeKey, regexKey) );
							} else {
								alert( this.getValidMessage(typeKey, regexKey) );
							}
							var t = item.offset().top;
							$('html,body').stop(true, false).animate({scrollTop: t - 160 }, 900, function() {
								item.focus();
							});

							return false;
						}

					}

				}
			}

		} catch(e) {
			alert('dev error : '+e);
			return false;
		}

		return true;

	},

	getValidMessage: function(typeKey, regexKey) {

		var name = '"'+this.title[typeKey]+'"';

		var tail = '';

		if(toStr(locale,'ko') == 'ko') {

			tail = this.isHanTail(this.title[typeKey])? this.regex[regexKey].hanTail[0]:this.regex[regexKey].hanTail[1]
		}

		return name + tail +' '+ this.regex[regexKey].msg();

	},

	getValue: function(item) {

			var value, elName ;

			inputType = item.attr('type');
			if(!inputType) {
				inputType = item.get(0).tagName.toLowerCase();
			}

			switch(inputType) {
				case 'radio' :
					//elName = item.attr('name');
					//value = $('input[name="'+elName+'"]:checked').val();
					value = $('input[name="'+item.attr('name')+'"]:checked').length > 0;
					break;
				case 'select':
					//elName = item.attr('name');
					//value = $('select[name="'+elName+'"] option:selected').val();
					value = item.val();

					break;
				case 'checkbox':
					value = $('input[name="'+item.attr('name')+'"]:checked').length > 0;
					break;
				default:
					value = item.val();
			}

			return value;

	},
	alertFunction: null


};
/**
 * 폼 유효성 체크 jquery 플러그인
 * title: 사용자 정의 타이틀 추가
 * alertFunction : 사용자 경고창 함수를 다른 함수로 적용할 경우
 * beforeSubmit :  기본 체크외에 사용자 유효성 체크 함수가 필요한 경우
 * $('#form').formValid({
 * 	title: [
		{title: 'emailid',	text: '이메일 아이디'	},
		{title: 'emaildomain',	text: '이메일 도메인'	},
		{title: 'mtel',	text: '연락처'},
 * ],
 * alertFunction: toastr.error,
 * beforeSubmit: function(validator) {
 *
 *  	if(false) {
 *  		alert('안됩니다');
 *  		return false;
 *  	}
 *  	return true;
 *
 * });
 */
(function($) {

  $.fn.formValid = function(opt) {

	opt = opt || {};

	this.each(function() {

		var $this = $(this);

		$this.submit(function(e) {

			//e.preventDefault();
			var validator = new Andwise.app.Validator($this);
			validator.alertFunction = opt.alertFunction ? opt.alertFunction: false;


			if(opt.title) {
				for(var i=0; i<opt.title.length; i++) {
					validator.addTitle(opt.title[i].title,opt.title[i].text);
				}
			}

			retv = validator.valid();;

			if(opt.beforeSubmit) {

				retv = retv && opt.beforeSubmit(validator);
			}

			if(!retv) {
				e.stopImmediatePropagation();
			}

		  window.cmsValidator = function() {

				return retv;
		  }


			return retv;
		});


	});

	return $(this);

  }

})(jQuery);

// 클래스를 이용한 팝업
// href 의 주소로 팝업을 띄운다
// jwpopup 으로 시작하는 클래스
// jwpopup-www-hhh : www 팝업넓이, hhh 팝업 높이
// ex) <a class="jwpopup-200-300" href=""></a>
$(function() {
  $('a[class*="jwpopup-"]').click(function(e) {

		e.preventDefault();

    var href = this.href, $this = $(this);
    var cls = $this.attr('class');

    var re = /jwpopup-[\d]+-[\d]+/;
    var arr = re.exec(cls);
    if(arr) {
      arr = arr[0].split('-');
      jwxe_popupWindow(href, arr[1], arr[2], 'popup', false, false);
      return false;
    }
  });
});

// 클래스를 이용한 우편번호 찾기 팝업창
// href 의 주소로 우편번호 찾기 팝업을 띄운다
// jwzip 으로 시작하는 클래스
// jwzip-jusofield-arr2-zip1-zip2 : jusofield: 주소필드 name, addr2 : 나머지주소 필드 , zip1:우편번호 앞자리 name, zip2: 우편번호뒤자리 name
// zip 이 하나일 경우는 (101-232 형태)
// zip 이 두개일 경우는 첫번째 필드에 101, 두번째 필드에 232 가 들어간다
// ex) <a class="jwzip-addr1-addr2-zip1-zip2" href="#findZip"></a>
// ex) <a class="jwzip-addr1-addr2-zip" href="#findZip"></a>
// ex) <a class="jwzip-addr1-addr2" href="#findZip"></a>
$(function() {
  $('a[class*="jwzip-"],input[class*="jwzip-"]').click(function(e) {

		e.preventDefault();

    var $this = $(this);
    var cls = $this.attr('class');

    var re = /jwzip-[\w]+-[\w]+[-[\w]+]?[-[\w]+]?/;
    var arr = re.exec(cls);
    if(arr) {
			arr = arr[0].split('-');
			var autoHref = rootPath + '/_common/jsp/popup_zipcode_new.jsp?addr1='+arr[1]+'&addr2='+arr[2] ;
			if(arr.length > 4) {
				autoHref += '&zip1=' + arr[3] + '&zip2=' + arr[4];
			} else if(arr.length > 3) {
				autoHref += '&zip=' + arr[3];
			}

	    var href = $this.attr('href');
			if(href && href.substring(0,1) != '#') {
				href = href
			} else {
				href = autoHref;
			}

      arr = arr[0].split('-');
      jwxe_popupWindow(href, 425, 305, 'findZipCode', false, false);
      return false;
    }
  });
});
//클래스를 이용한 도로명 주소 팝업창
//href 의 주소로 도로명 주소 팝업을 띄운다
//jwroad 으로 시작하는 클래스
//ex) <a class="jwroad" href="#findLoadoad"></a>
// 우편번호 <input id=road_zip ..
// 주소1 <input id=road_addr1 ..
// 주소2 <input id=road_addr2 ..
// 그냥 주소 <input id=road_addr ..
$(function() {
	$('a[class*="jwroad"],input[class*="jwroad"]').click(function(e) {

		e.preventDefault();

		var $this = $(this);
		var cls = $this.attr('class');

		var autoHref = rootPath+'/_common/jsp/new_zipcode/road.jsp';
		var href = $this.attr('href');
			if(href && href.substring(0,1) != '#') {
				href = href
			} else {
				href = autoHref;
			}

	   jwxe_popupWindow(href, 630, 575, 'findRoadZipCode', true, true);
	   return false;

	});
});

//클래스를 이용한 도로명 검색 팝업창
//href 의 주소로 우편번호 찾기 팝업을 띄운다
//jwroadzip 으로 시작하는 클래스
//jwroadzip-jusofield-arr2-zip1-zip2 : jusofield: 주소필드 name, addr2 : 나머지주소 필드 , zip1:우편번호 앞자리 name, zip2: 우편번호뒤자리 name
//zip 이 하나일 경우는 (101-232 형태)
//zip 이 두개일 경우는 첫번째 필드에 101, 두번째 필드에 232 가 들어간다
//ex) <a class="jwzip-addr1-addr2-zip1-zip2" href="#findZip"></a>
//ex) <a class="jwzip-addr1-addr2-zip" href="#findZip"></a>
//ex) <a class="jwzip-addr1-addr2" href="#findZip"></a>
$(function() {
	$('a[class*="jwnewzip-"],input[class*="jwnewzip-"]').click(function(e) {

			e.preventDefault();

	 var $this = $(this);
	 var cls = $this.attr('class');

	 var re = /jwnewzip-[\w]+-[\w]+[-[\w]+]?[-[\w]+]?/;
	 var arr = re.exec(cls);
	 if(arr) {
				arr = arr[0].split('-');
				var autoHref = rootPath + '/_common/jsp/new_zipcode/road.jsp?addr1='+arr[1]+'&addr2='+arr[2] ;
				if(arr.length > 4) {
					autoHref += '&zip1=' + arr[3] + '&zip2=' + arr[4];
				} else if(arr.length > 3) {
					autoHref += '&zip=' + arr[3];
				}

		    var href = $this.attr('href');
				if(href && href.substring(0,1) != '#') {
					href = href
				} else {
					href = autoHref;
				}

	   arr = arr[0].split('-');
	   jwxe_popupWindow(href, 630, 575, 'findRoadNewZipCode', true,true);

	   return false;
	 }

	});
});

/*안행부 도로명 주소 URL 팝업 ver*/
$(function() {
	$('a[class*="jwnewjuso-"],input[class*="jwnewjuso-"]').click(function(e) {

			e.preventDefault();

	 var $this = $(this);
	 var cls = $this.attr('class');

	 var re = /jwnewjuso-[\w]+-[\w]+[-[\w]+]?[-[\w]+]?/;
	 var arr = re.exec(cls);
	 if(arr) {
				arr = arr[0].split('-');
				var autoHref = rootPath + '/_common/jsp/new_juso/jusoPopup.jsp?addr1='+arr[1]+'&addr2='+arr[2] ;
				if(arr.length > 4) {
					autoHref += '&zip1=' + arr[3] + '&zip2=' + arr[4];
				} else if(arr.length > 3) {
					autoHref += '&zip=' + arr[3];
				}

		    var href = $this.attr('href');
				if(href && href.substring(0,1) != '#') {
					href = href
				} else {
					href = autoHref;
				}

	   arr = arr[0].split('-');
	   jwxe_popupWindow(href, 570, 420, 'pop', true,true);

	   return false;
	 }

	});
});



function loadFacyBoxScript() {

	loadCSS(rootPath+'\/_common\/js\/fancybox\/jquery.fancybox-1.3.4.css');
	loadJavascript(rootPath+'\/_common\/js\/fancybox\/jquery.easing-1.3.pack.js');
	loadJavascript(rootPath+'\/_common\/js\/fancybox\/jquery.fancybox-1.3.4.pack.js');

}

function loadFancyBoxScript() {
	loadFacyBoxScript();
}

// SSL 주소 치환
if(typeof(sslYN) != 'undefined' && sslYN == 'Y') {
	$(function() {

		if(document.location.href.startsWith('http:')) {
			$('a.jwssl').attr('href',function(index, href) {
				if(!href || !href.startsWith('/')) {
					return;
				}

				$(this).attr('href','https://'+document.location.hostname+(sslPort?':'+sslPort:'')+href );

			});
		}

		if(document.location.href.startsWith('https')) {
			$('a.jwnossl').attr('href',function(index, href) {

				if(!href || !href.startsWith('/')) {
					return;
				}

				$(this).attr('href','http://'+document.location.hostname+(servicePort?':'+servicePort:'')+href );

			});
		}

	});
}

$(function() {
	$('form[action="'+rootPath+'/_common/jsp/redirect.jsp"]').submit(function() {
	  if(!this.link.value) {
	    alert('이동하실 사이트를 선택하세요');
	    return false;
	  }
	    return true;
	});

	// 본문 바로가기 제거
	if($(printSelector).length == 0) {
		$('a[href="'+printSelector+'"]').parent('li').remove();
	}
	// 주메뉴 바로가기 제거
	if($('#jwxe_main_menu').length == 0) {
		$('a[href="#jwxe_main_menu"]').parent('li').remove();
	}
	// 서브메뉴 바로가기 제거
	if($('#jwxe_sub_menu').length == 0) {
		$('a[href="#jwxe_sub_menu"]').parent('li').remove();
	}
	if($('#go_main li').length == 0) {
		$('#go_main').remove();
	}
});

//loadJavascript('<script type="text/javascript" src="'+rootPath+'/_common/js/control.js"></script>');

/**
 * 플래쉬 맵 호출
 */
$(function() {

	if( $('.flash-map').length > 0 ) {

		var msg = '';
		$('.flash-map').each(function( index ) {

			// 이전 스크립트에서 호출 했으면 스킵
			if(!$(this).data('flash-map')) {
				if(index != 0) {
					msg += '\n';
				}
				msg += $(this).text();
				$(this).data('flash-map',true)
			}

		});
		if(msg.length > 0) {
			alert(msg);
		}

	}

	//---------------
	// PDF export button
	//---------------
	if($('#pdfDown').length > 0) {
        var form = $('<form method="post" name="pdfForm" action="'+ctx+'/cms/plugin/pdf/pdfOpen.do" target="_blank">'
          +'<input type="hidden" name="siteId" value="'+_siteId+'"/>'
          +'<input type="hidden" name="locale" value="'+locale+'"/>'
          +'<input type="hidden" name="url" value="'+location.pathname+'"/>'
          +'<input type="hidden" name="href" value="'+location.href+'"/>'
          +'</form>');

        $('body').append(form);

		$('#pdfDown').click(function() {

			$('form[name=pdfForm]').submit();

		    return false;
		});

	}

});

var CKEDITOR = {
		instances : {}
}

var editorAdaptor = {};

/**
 * option.isImageFullUrl (boolean) : 이미지 링크를 http//host 를 포함한 절대 경로 사용
 * @param {} option
 * @return {}
 */
function initEditor( option ) {

	if(typeof(editorVendor) == 'undefined') {
		editorVendor = 'froala';
	}

	if(editorVendor == 'froala' && bowser.msie && parseInt(bowser.version) < 10) {
		editorVendor = 'daumEditor';
	} else if(editorVendor == 'ckeditor3' && bowser.msie && parseInt(bowser.version) > 9) {
		editorVendor = 'daumEditor';
	}

	var editorAdaptor = new EditorAdaptor[editorVendor]();

	editorAdaptor.init( option );


	// 폼이 전송되면 textarea value에 에디터 내용을 대입
	$form = option.$textarea.closest('form');
	$form.submit(function() {

		var editor = option.$textarea.data('editor');
		option.$textarea.val( editor.getData() );

	});


	return editorAdaptor;

}

var EditorAdaptor = function () {


	return {

		defaultHeight: 900,

		$textarea: [],
		//--------------------------------
		// 에디터에 내용을 주입할때 사용
		//--------------------------------
		getTextValue:function( index ) {

			return EditorAdaptor.$textarea[index].val();

		},

		//-------------------------
		// Innoditor
		//-------------------------
		innoditor: function(){
			var editor , $iframe;

			return {

				getData : function() {
					return $iframe[0].contentWindow.getValue();
				},

				init : function( option ){
					var height = option.height || EditorAdaptor.defaultHeight, index = option.index, $textarea = option.$textarea;

					$textarea.css({height:0, border:'none', position: 'absolute', left:'-99999px'});

					EditorAdaptor.$textarea[index] = $textarea;

					$iframe = $('<iframe>',{
						id: 'innoditor'+index,
						title: $m('편집'),
						frameBorder: 0
					}).css({
						'height' : (parseInt(height)+120)+'px',
						'width' : '100%'
					});

					$textarea.after($iframe);

					var css = [];
					$('link[rel="stylesheet"]').each(function() {
						css.push( this.href );
					});

					var html =
						'<!doctype html>\n'+
						'<html>\n'+
						'<head>\n'+
							'<meta http-equiv="expires" content="0" />\n'+
							'<meta http-equiv="expires" content="now" />\n'+
							'<meta http-equiv="Cache-Control" content="private" />\n'+
							'<meta http-equiv="Cache-Control" content="No-Cache" />\n'+
							'<meta http-equiv="Pragma" content="No-Cache" />\n'+
							'<meta http-equiv="content-type" content="text/html; charset=utf-8" />\n'+
							'<meta http-equiv="X-UA-Compatible" content="IE=edge" />\n'+
							'<script language="javascript" type="text/javascript">\n'+
								'var g_arrSetEditorArea = new Array();\n' +
								'g_arrSetEditorArea[0] = "innoditor' + index + '";\n' +  // 이노디터를 위치시킬 영역의 ID값 설정

							'</script>\n'+

							'<script src="'+ctx+'/_common/js/jquery/jquery-1.9.1.js" type="text/javascript"></script>\n'+
							'<script language="javascript" src="'+ctx+'/_common/_plugin/innoditor/js/customize.js" type="text/javascript"></script>\n'+
							'<script language="javascript" src="'+ctx+'/_common/_plugin/innoditor/js/customize_ui.js" type="text/javascript"></script>\n'+
							'<script language="javascript" src="'+ctx+'/_common/_plugin/innoditor/js/loadlayer.js" type="text/javascript"></script>\n';

							for(var i=0; i<css.length; i++) {

								html += '<link remove="y" rel="stylesheet" href="' + css[i] + '"type="text/css">';

							}



						html += '<script language="javascript" type="text/javascript">\n'+

							'function setValue() {\n'+

								  'fnSetEditorHTMLCode( parent.EditorAdaptor.getTextValue(' + index  +' ),false, 0 )\n' +

							'}\n'+
							'function getValue() {\n'+

								'var text = fnGetEditorHTMLCode(false,' + index + ');\n' +

								'if (text == "<p><br></p>"){\n'  +
								' text = ""\n' +
								'}\n' +

								'return text;\n' +
								//'return fnGetEditorHTMLCode(false,' + index + ');\n' +

							'}\n'+


							'setValue()\n' +

							'document.close();\n'+
							'$(document).ready(function() { $("link[remove=y]").remove() } );'+
							'</script>\n'+
							'<body style="padding:0;margin:0;">\n'+

								'<div id="innoditor' + index +'"></div>\n'

							'</body>\n'+
							'</html>';

							var iframeDoc = $iframe[0].contentDocument || $iframe[0].contentWindow.document;

							iframeDoc.open();
							iframeDoc.write(html);

				}

			}
		},

		daumEditor: function() {

			var editor, $iframe;

			return {

				getData: function() {

					return $iframe[0].contentWindow.getValue();

				},

				init: function( option ) {

					var template, height = option.height || EditorAdaptor.defaultHeight, index = option.index, $textarea = option.$textarea;

					locale = typeof(locale) == 'undefined'? 'ko': locale;

					$textarea.css({height:0, border:'none', position: 'absolute', left:'-99999px'});

					EditorAdaptor.$textarea[index] = $textarea;

					$iframe = $('<iframe>',{
						id: 'daumIframe'+index,
						title: $m('편집'),
						frameBorder: 0
					}).css({
						'height' : height+'px',
						'width' : '100%'
					});

					$textarea.after( $iframe );

					var css = '[';
					$('link[rel="stylesheet"]').each(function( index ) {
						if(index !== 0) {
							css += ',';
						}
						css +=  "'"+$(this).attr('href')+"'";
					});
					css +=  ']';

					$.ajax({
						cache: true,
						async: false,
						url: ctx+'/_common/_plugin/daumeditor/template.html',
						success: function( response ) {
							template = response;
							template = template.replace(/\$index/g,index);
							template = template.replace(/\$height/g,height);
							template = template.replace(/\$ctx/g,ctx);
							template = template.replace(/\$locale/g,locale);
							template = template.replace(/\$extcss/g,css);
							template = template.replace(/\$\{isImageFullUrl\}/g, typeof(option.isImageFullUrl) == 'undefined' ? 'false': (option.isImageFullUrl?'true':'false'));
						}
					});

					var iframeDoc = $iframe[0].contentDocument || $iframe[0].contentWindow.document;

					iframeDoc.open();
					iframeDoc.write(template);



				}

			}

		},

		froala: function() {
			var editor , $iframe;

			return {

				getData : function() {
					return $iframe[0].contentWindow.getValue();
				},

				init : function( option ){

					var template, height = option.height || EditorAdaptor.defaultHeight, index = option.index, $textarea = option.$textarea, extCss = '';
					locale = typeof(locale) == 'undefined'? 'ko': locale, bodyCls = option.bodyCls || 'board-view-txt';

					$.ajax({
						cache: true,
						async: false,
						url: ctx+'/_common/_plugin/froala_editor/latest/template.html',
						success: function( response ) {
							template = response;
							template = template.replace(/\$index/g,index);
							template = template.replace(/\$height/g,height);
							template = template.replace(/\$ctx/g,ctx);
							template = template.replace(/\$locale/g,locale);
							template = template.replace(/\$bodyCls/g,bodyCls);
							template = template.replace(/\$\{isImageFullUrl\}/g, typeof(option.isImageFullUrl) == 'undefined' ? 'false': (option.isImageFullUrl?'true':'false'));
						}

					});


					$textarea.css({height:0, border:'none', position: 'absolute', left:'-99999px'});

					EditorAdaptor.$textarea[index] = $textarea;

					$iframe = $('<iframe>',{
						id: 'editorFrame'+index,
						title: $m('편집'),
						frameBorder: 0
					}).css({
						'height' : height+'px',
						'width' : '100%'
					});

					$textarea.after($iframe);

					$('link[rel="stylesheet"]').each(function() {
						extCss += '<link rel="stylesheet" href="'+$(this).attr('href') +'">' + '\n';
					});
					template = template.replace(/\$extcss/g,extCss);


					var iframeDoc = $iframe[0].contentDocument || $iframe[0].contentWindow.document;

					iframeDoc.open();
					iframeDoc.write(template);


				}
			}

		},

		//-------------------------
		// ckeditor
		//-------------------------
		ckeditor3: function() {

			var editor, $iframe;

			return {

				getData: function() {

					return $iframe[0].contentWindow.CKEDITOR.instances['textarea'].getData();

				},

				init: function( option ) {

					var template, height = option.height || EditorAdaptor.defaultHeight, index = option.index, $textarea = option.$textarea;
					locale = typeof(locale) == 'undefined'? 'ko': locale;

					$textarea.css({height:0, border:'none', position: 'absolute', left:'-99999px'});

					EditorAdaptor.$textarea[index] = $textarea;

					$iframe = $('<iframe>',{
						id: 'ckIframe'+index,
						title: $m('편집'),
						frameBorder: 0
					}).css({
						'height' : height+'px',
						'width' : '100%'
					});

					$textarea.after($iframe);

					var css = '[';
					$('link[rel="stylesheet"]').each(function( index ) {
						if(index !== 0) {
							css += ',';
						}
						css +=  "'"+$(this).attr('href')+"'";
					});
					css +=  ",'"+ctx+"/_common/_plugin/ckeditor/contents.css']";

					$.ajax({
						cache: true,
						async: false,
						url: ctx+'/_common/_plugin/ckeditor/template.html',
						success: function( response ) {
							template = response;
							template = template.replace(/\$index/g,index);
							template = template.replace(/\$height/g,height);
							template = template.replace(/\$ctx/g,ctx);
							template = template.replace(/\$locale/g,locale);
							template = template.replace(/\$extcss/g,css);
							template = template.replace(/\$resPath/g,resPath);
						}
					});


					var iframeDoc = $iframe[0].contentDocument || $iframe[0].contentWindow.document;


					iframeDoc.open();
					iframeDoc.write(template);



				}

			}

		},


		//--------------------------------
		// 나모 에디터
		//--------------------------------
		namo3: function() {

			var $iframe;

			return {

				getData: function() {

					return $iframe[0].contentWindow.namoEditor.GetBodyValue();

				},

				init: function( option ) {

					var height = option.height || EditorAdaptor.defaultHeight, index = option.index, $textarea = option.$textarea;

					$textarea.css({height:0, border:'none', position: 'absolute', left:'-99999px'});

					EditorAdaptor.$textarea[index] = $textarea;

					$iframe = $('<iframe>',{
						title: $m('편집'),
						id: 'namoIframe'+index,
						frameBorder: 0
					}).css({
						'height' : height+'px',
						'width' : '100%'
					});

					$textarea.after($iframe);

					var css;
					if(typeof(_reouscePath) != 'undefined') {
						css = _reouscePath+'_css/user.css';
					}

					var lang = 'auto';
					if(typeof(locale) == 'undefined') {
					} else if(locale.startsWith('ja')) {
						lang = 'jpn';
					} else if(locale.startsWith('zh')) {
						lang = 'chs';
					} else if(locale.startsWith('en')) {
						lang = 'enu';
					};


					var source = [
					'<!doctype html><html>',
					'<head>',
					'<script type="text/javascript" src="'+ctx+'/_common/js/jquery/jquery-1.9.1.js"></script>',
					'<script type="text/javascript" src="'+ctx+'/_common/_plugin/namo_editor3/js/namo_scripteditor.js" ></script>',
					'</head>',
					'<body style="padding:0;margin:0">',
						'<script type="text/javascript">',
						'var namoEditor;',
						'ready();',
						'function ready() {',
							'setTimeout(function() {',
								'if(typeof(NamoSE) == "undefined") {',
									'ready(); return;',
								'}',
								'editorStart();',
							'},10);',
						'};',
						'function editorStart() {',
							'namoEditor = new NamoSE(\'namo'+index+'\');',
							'namoEditor.params.Height = '+height+';',
							'namoEditor.params.Width = "100%";',
							'namoEditor.params.UserLang = "'+lang+'";',
							'namoEditor.params.FullScreen = false;',
							css ? 'namoEditor.params.Css = "'+css+'";' : '',
							'namoEditor.editorStart();',
						'};',
						'function OnInitCompleted(e){',
							'parent.$("#namoIframe'+index+'").css("height",$(document.body).height()+20);',
							'e.editorTarget.SetBodyValue( parent.EditorAdaptor.getTextValue('+index+') );',
							'document.close();',
						'}',
						'</script>',
					'</body>',
					'</html>'].join('');

					var iframeDoc = $iframe[0].contentDocument || $iframe[0].contentWindow.document;


					iframeDoc.open();
					iframeDoc.write(source);



				}
			}
		}
	};
}();

document.write('<script type="text/javascript" src="'+rootPath+'/_common/js/control.js"></script>');

// Array reduce 메서드를 잘못사용해서 모든 사이트에서 오류가 나기 때문에 reduce 를 다시 정의 했다. 
Object.defineProperty(Array.prototype, 'reduce', {
	value: function(callback /*, initialValue*/) {
		if (this === null) {
			throw new TypeError( 'Array.prototype.reduce ' + 
								'called on null or undefined' );
		}
		if (typeof callback !== 'function') {
			throw new TypeError( callback +
								' is not a function');
		}

		// 1. Let O be ? ToObject(this value).
		var o = Object(this);

		// 2. Let len be ? ToLength(? Get(O, "length")).
		var len = o.length >>> 0; 

		// Steps 3, 4, 5, 6, 7      
		var k = 0; 
		var value;

		if (arguments.length >= 2) {
			value = arguments[1];
		} else {
			while (k < len && !(k in o)) {
				k++; 
			}

			// 3. If len is 0 and initialValue is not present,
			//    throw a TypeError exception.
			if (k >= len) {
				return 0;
			}
			value = o[k++];
		}

		// 8. Repeat, while k < len
		while (k < len) {
			if (k in o) {
				value = callback(value, o[k], k, o);
			}

			// d. Increase k by 1.      
			k++;
		}

		// 9. Return accumulator.
		return value;
	}
});
