import js.Browser.*;
import js.Lib;
import js.html.ButtonElement;
import js.html.DivElement;

using StringTools;

@:expose
class rawworkstest {
	var widgetContainer:DivElement;
	var contentBlocker:DivElement;

	var widgetBtn:DivElement;
	var isWidgetBtnVisible = true;

	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('rawworks - Dom ready');
			setupWidget();
		});
	}

	function setupWidget() {
		// css
		var style = document.createStyleElement();
		// style.textContent = '#rawworks-widget-react{ border:10px solid green;}';
		style.textContent = '<!-- make sure to inject the minified widget css here (rawworks.css) -->';
		document.head.appendChild(style);
		// btn
		var btn = cast document.getElementById('rawworks-widget-btn');
		if (btn == null) {
			// eventually we need the generate this on as well
			widgetBtn = document.createDivElement();
			widgetBtn.className = 'foobar';
			widgetBtn.id = 'rawworks-widget-btn';
			widgetBtn.innerHTML = '<img src="img/widget.png" height="40px" width="233px" alt="" title="">';
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
		widgetContainer.id = 'rawworks-widget';

		switch (widgetBtn.dataset.type) {
			case 'iframe':
				var iframe = document.createIFrameElement();
				iframe.src = 'iframepage.html';
				iframe.title = 'rawworks widget';
				iframe.frameBorder = '0';
				widgetContainer.appendChild(iframe);
			// hspace = "0" vspace = "0" marginHeight = "0" marginWidth = "0" scrolling = "no" frameBorder = "0" allowtransparency = "true"
			case 'test':
				var closeBtn:ButtonElement = document.createButtonElement();
				closeBtn.onclick = onCloseBtnHandler;
				closeBtn.className = 'btn btn-primary';
				closeBtn.innerText = 'close window';
				widgetContainer.appendChild(closeBtn);

				var resizeBtn:ButtonElement = document.createButtonElement();
				resizeBtn.onclick = onresizeBtnHandler;
				resizeBtn.className = 'btn btn-secondary';
				resizeBtn.innerText = 'resize window';
				widgetContainer.appendChild(resizeBtn);

				var btn:ButtonElement = document.createButtonElement();
				btn.onclick = () -> {
					rawworks.resizeWidget();
				};
				btn.className = 'btn btn-danger';
				btn.innerText = 'global resize func';
				widgetContainer.appendChild(btn);
			case 'react':
				// trace('use to inject react app');
				// inject scripts

				var sc = document.createScriptElement();
				sc.src = 'static/js/runtime-main.d943c866.js';
				document.body.appendChild(sc);

				var sc = document.createScriptElement();
				sc.src = 'static/js/2.6558d025.chunk.js';
				document.body.appendChild(sc);

				var sc = document.createScriptElement();
				sc.src = 'static/js/main.37630b51.chunk.js';
				document.body.appendChild(sc);

				var link = document.createLinkElement();
				link.href = 'static/css/main.1c036d6c.chunk.css';
				link.rel = 'stylesheet';
				document.body.appendChild(link);

				// create container
				var react = document.createDivElement();
				react.id = 'rawworks-widget-react';
				widgetContainer.appendChild(react);

			default:
				trace("case '" + widgetBtn.dataset.type + "': trace ('" + widgetBtn.dataset.type + "');");
		}

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
			trace('show blockcer');
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
		var widgetContainer = document.getElementById('rawworks-widget');
		widgetContainer.classList.toggle('close');
		// var blocker = document.getElementById('rawworks-widget-contentblocker');
		// blocker.classList.toggle('close');
	}

	public static function resizeWidget() {
		trace('static resizeWidget');
		var widgetContainer = document.getElementById('rawworks-widget');
		widgetContainer.classList.toggle('resize');
	}

	static public function main() {
		var app = new rawworkstest();
	}
}
