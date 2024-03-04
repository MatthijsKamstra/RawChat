// Generated by Haxe 4.3.2
(function ($hx_exports, $global) { "use strict";
class CompileTime {
}
class RawWorks {
	constructor() {
		this.isWidgetBtnVisible = true;
		let _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			$global.console.log("rawworks-widget-script");
			_gthis.setupWidget();
		});
	}
	setupWidget() {
		let style = window.document.createElement("style");
		style.textContent = "#rawworks-widget-contentblocker {\n  z-index: 999999;\n  position: absolute;\n  height: 100%;\n  top: 0;\n  left: 0;\n  right: 0;\n  background: rgba(0, 0, 0, 0.5);\n  display: block;\n  opacity: 1;\n  transition: all 1s linear;\n}\n#rawworks-widget-contentblocker.hidden {\n  display: none;\n}\n#rawworks-widget-contentblocker.visuallyhidden {\n  opacity: 0;\n}\n#rawworks-widget-contentblocker.show {\n  opacity: 1;\n}\n#rawworks-widget-btn {\n  display: block;\n  position: absolute;\n  right: 2%;\n  bottom: 10%;\n  height: 40px;\n  width: 233px;\n  box-shadow: 0 10px 15px 0 rgba(0, 0, 0, 0.3);\n  border-radius: 20px 0 0 0;\n  background-color: #ffffff;\n  cursor: pointer;\n}\n#rawworks-widget-btn.left {\n  left: 2%;\n}\n#rawworks-widget-react {\n  background-color: silver;\n  width: 100%;\n  height: 100%;\n}\n#rawworks-widget {\n  z-index: 1000000;\n  margin: 0;\n  padding: 0;\n  display: block;\n  position: absolute;\n  right: 2%;\n  bottom: 10%;\n  height: 620px;\n  width: 410px;\n  border-radius: 20px 0 0 0;\n  background-color: #ffffff;\n  box-shadow: 0 7px 21px 0 rgba(0, 0, 0, 0.2);\n  text-align: center;\n  overflow: hidden;\n  transition: width 0.5s;\n}\n#rawworks-widget iframe {\n  width: 100%;\n  height: 100%;\n  overflow: hidden;\n}\n#rawworks-widget.close {\n  display: none;\n}\n#rawworks-widget.resize {\n  width: 500px;\n}\n";
		window.document.head.appendChild(style);
		if(window.document.getElementById("rawworks-widget-btn") == null) {
			this.widgetBtn = window.document.createElement("div");
			this.widgetBtn.className = "foobar";
			this.widgetBtn.id = "rawworks-widget-btn";
			this.widgetBtn.innerHTML = "<img src=\"" + RawWorks.RAWWORKS_WIDGET_URL + "img/widget.svg\" height=\"40px\" width=\"233px\" alt=\"Book a space\" title=\"Book a space\">";
			this.widgetBtn.onclick = $bind(this,this.onclickHandler);
			window.document.body.appendChild(this.widgetBtn);
		} else {
			this.widgetBtn = window.document.getElementById("rawworks-widget-btn");
			this.widgetBtn.onclick = $bind(this,this.onclickHandler);
		}
	}
	setupWidgetContainer() {
		this.contentBlocker = window.document.createElement("div");
		this.contentBlocker.id = "rawworks-widget-contentblocker";
		this.contentBlocker.onclick = $bind(this,this.onclickHandler);
		this.widgetContainer = window.document.createElement("div");
		this.widgetContainer.id = RawWorks.RAWWORKS_WIDGET_ID;
		let iframe = window.document.createElement("iframe");
		iframe.src = "" + RawWorks.RAWWORKS_WIDGET_URL + "index.html";
		iframe.title = "rawworks widget";
		iframe.frameBorder = "0";
		this.widgetContainer.appendChild(iframe);
		window.document.body.appendChild(this.contentBlocker);
		window.document.body.appendChild(this.widgetContainer);
	}
	onclickHandler(e) {
		if(this.widgetContainer == null) {
			this.setupWidgetContainer();
		} else {
			this.onCloseBtnHandler(null);
		}
	}
	toggleContentBlocker() {
		let _gthis = this;
		if(this.widgetContainer.classList.contains("close")) {
			console.log("src/RawWorks.hx:80:","hide blocker");
			this.contentBlocker.classList.add("visuallyhidden");
			window.setTimeout(function() {
				_gthis.contentBlocker.classList.add("hidden");
				_gthis.contentBlocker.classList.remove("visuallyhidden");
			},1100);
		} else {
			console.log("src/RawWorks.hx:88:","show blocker");
			this.contentBlocker.classList.remove("hidden");
			this.contentBlocker.classList.remove("visuallyhidden");
		}
	}
	onCloseBtnHandler(e) {
		this.widgetContainer.classList.toggle("close");
		this.toggleContentBlocker();
	}
	onresizeBtnHandler(e) {
		this.widgetContainer.classList.toggle("resize");
	}
	static closeWidget() {
		console.log("src/RawWorks.hx:106:","static closeWidget");
		window.document.getElementById(RawWorks.RAWWORKS_WIDGET_ID).classList.toggle("close");
	}
	static resizeWidget() {
		console.log("src/RawWorks.hx:114:","static resizeWidget");
		window.document.getElementById(RawWorks.RAWWORKS_WIDGET_ID).classList.toggle("resize");
	}
	static inject() {
		let script = window.document.createElement("script");
		script.type = "text/javascript";
		script.src = "https://github.com/MatthijsKamstra/RawChat/rawworks-widget/js/rawworks.js";
		script.onload = function() {
			new RawWorks().setupWidget();
		};
		window.document.body.appendChild(script);
	}
	static main() {
		new RawWorks();
	}
}
$hx_exports["RawWorks"] = RawWorks;
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0;
		this.array = array;
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
{
}
RawWorks.RAWWORKS_WIDGET_ID = "rawworks-widget";
RawWorks.RAWWORKS_WIDGET_URL = "https://rawgpt.azurewebsites.net/";
RawWorks.main();
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
