import js.Browser.*;
import js.Lib;
import js.html.DivElement;

using StringTools;

@:expose
class RawWorks {
	var widgetContainer:DivElement;
	var contentBlocker:DivElement;

	var widgetBtn:DivElement;
	var isWidgetBtnVisible = true;

	public static var RAWWORKS_WIDGET_ID = 'rawworks-widget';
	public static var RAWWORKS_WIDGET_URL = 'https://rawgpt.azurewebsites.net/';

	// public static var RAWWORKS_WIDGET_ID = 'root'; // 'rawworks-widget';

	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('rawworks-widget-script');
			setupWidget();
		});
	}

	function setupWidget() {
		// css
		var style = document.createStyleElement();
		// style.textContent = '#rawworks-widget-react{ border:10px solid green;}';
		style.textContent = CompileTime.readFile("rawworks.css");
		document.head.appendChild(style);
		// btn
		var btn = cast document.getElementById('rawworks-widget-btn');
		if (btn == null) {
			// eventually we need the generate this on as well
			widgetBtn = document.createDivElement();
			widgetBtn.className = 'foobar';
			widgetBtn.id = 'rawworks-widget-btn';
			widgetBtn.innerHTML = '<img src="${RAWWORKS_WIDGET_URL}img/widget.svg" height="40px" width="233px" alt="Book a space" title="Book a space">';
			widgetBtn.onclick = onclickHandler;
			document.body.appendChild(widgetBtn);
		} else {
			widgetBtn = cast document.getElementById('rawworks-widget-btn');
			widgetBtn.onclick = onclickHandler;
		}
	}

	function setupWidgetContainer() {
		contentBlocker = document.createDivElement();
		contentBlocker.id = 'rawworks-widget-contentblocker';
		contentBlocker.onclick = onclickHandler;

		widgetContainer = document.createDivElement();
		widgetContainer.id = RAWWORKS_WIDGET_ID;

		var iframe = document.createIFrameElement();
		iframe.src = '${RAWWORKS_WIDGET_URL}index.html';
		iframe.title = 'rawworks widget';
		iframe.frameBorder = '0';
		widgetContainer.appendChild(iframe);

		document.body.appendChild(contentBlocker);
		document.body.appendChild(widgetContainer);
	}

	// ____________________________________ handlers ____________________________________

	function onclickHandler(e) {
		// make sure we have a widget!
		if (widgetContainer == null) {
			setupWidgetContainer();
		} else {
			onCloseBtnHandler(null);
		}
	}

	function toggleContentBlocker() {
		if (widgetContainer.classList.contains('close')) {
			trace('hide blocker');
			// contentBlocker.classList.remove('show');
			contentBlocker.classList.add('visuallyhidden');
			js.Browser.window.setTimeout(() -> {
				contentBlocker.classList.add('hidden');
				contentBlocker.classList.remove('visuallyhidden');
			}, 1100);
		} else {
			trace('show blocker');
			// contentBlocker.classList.add('show');
			contentBlocker.classList.remove('hidden');
			contentBlocker.classList.remove('visuallyhidden');
		}
		// contentBlocker.classList.toggle('close');
	}

	function onCloseBtnHandler(e) {
		widgetContainer.classList.toggle('close');
		toggleContentBlocker();
	}

	function onresizeBtnHandler(e) {
		widgetContainer.classList.toggle('resize');
	}

	public static function closeWidget() {
		trace('static closeWidget');
		var widgetContainer = document.getElementById(RAWWORKS_WIDGET_ID);
		widgetContainer.classList.toggle('close');
		// var blocker = document.getElementById('rawworks-widget-contentblocker');
		// blocker.classList.toggle('close');
	}

	public static function resizeWidget() {
		trace('static resizeWidget');
		var widgetContainer = document.getElementById(RAWWORKS_WIDGET_ID);
		widgetContainer.classList.toggle('resize');
	}

	public static function inject() {
		var script = document.createScriptElement();
		script.type = 'text/javascript';
		script.src = 'https://github.com/MatthijsKamstra/RawChat/rawworks-widget/js/rawworks.js';
		script.onload = function() {
			new RawWorks().setupWidget();
		};
		document.body.appendChild(script);
	}

	static public function main() {
		var app = new RawWorks();
	}
}
