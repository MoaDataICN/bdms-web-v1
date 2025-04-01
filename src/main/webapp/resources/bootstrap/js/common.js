String.prototype.format = function() {
	var formatted = this;
	for (var i = 0; i < arguments.length; i++) {
	var regexp = new RegExp('\\{'+i+'\\}', 'gi');
		formatted = formatted.replace(regexp, arguments[i]);
	}
	return formatted;
};

/*if($("body").find('.grid-stack').length > 0) {
	d3.selection.prototype.moveToFront = function() {
		return this.each(function(){
			this.parentNode.appendChild(this);
		});
	};
}*/

function getUrlParams() {
	var params = {};
	window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
	return params;
}

function getJsonParseData(jsonData) {
	var data;
	if(jsonData != undefined && Object.keys(jsonData).length != 0) {
		data = JSON.parse(jsonData);
	}
	return data;
}

function isEmpty(str){
	if(typeof str == "undefined" || str == "undefined" || str == null || str == "") {
		return true;
	} else{
		return false;
	}
}
 
function nvl(str, defaultStr){
	if(typeof str == "undefined" || str == null || str == "") {
		str = defaultStr ;
	}
	return str ;
}

function isUndefined(value) {
	return typeof value === 'undefined';
}

function isNumeric(num, opt){
	// 좌우 trim(공백제거)을 해준다.
	num = String(num).replace(/^\s+|\s+$/g, "");
	
	if(typeof opt == "undefined" || opt == "1") {
		// 모든 10진수 (부호 선택, 자릿수구분기호 선택, 소수점 선택)
		var regex = /^[+\-]?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
	} else if(opt == "2") {
		// 부호 미사용, 자릿수구분기호 선택, 소수점 선택
		var regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
	} else if(opt == "3") {
		// 부호 미사용, 자릿수구분기호 미사용, 소수점 선택
		var regex = /^[0-9]+(\.[0-9]+)?$/g;
	} else {
		// only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
		var regex = /^[0-9]$/g;
	}

	if(regex.test(num)) {
		num = num.replace(/,/g, "");
		return isNaN(num) ? false : true;
	} else {
		return false;
	}
}

function pushInterval(arr, value, el, interval, chart, chartArr) {
	const findObj = arr.find(obj => obj.id == value);
	if(isEmpty(findObj)) {
		// Add Resize Event
		var resizeId,
			resizeFn = function() {
			clearTimeout(resizeId);
			resizeId = setTimeout(interval, 500);
		};
		window.addEventListener('resize', resizeFn, false);
		
		// Add Grid Resize Custom event
		var container = $(el).find(".console-panel-body").get(0);
		container.addEventListener('gridResize', interval, false);
		
		// Add Interval
		var obj = {};
		obj.id = value;
		obj.fn = setInterval(function(){
			interval('U');
		}, el.attr('data-gs-interval'));
		obj.resizeFn = resizeFn;
		arr.push(obj);
		
		/*if(!isEmpty(chart) && !isUndefined(chartArr)) {
			chartArr.push(chart);
		}*/
	}
}

function deleteInterval(arr, value) {
	if(arr.length !== 0) {
		const itemToFind = arr.find(function(item) {return item.id === value})
		const idx = arr.indexOf(itemToFind);
		if(idx > -1) {
			arr.splice(idx, 1);
			// Clear Interval
			clearInterval(itemToFind.fn);
			// Remove Resize Event
			window.removeEventListener('resize', itemToFind.resizeFn);
			// Remove Grid Resize Custom event
			window.removeEventListener('gridResize', itemToFind.eventFn);
		}
	}
}

function deleteAllInterval(arr) {
	if(arr.length !== 0) {
		var intervalArr = JSON.parse(JSON.stringify(arr));
		$.each(intervalArr, function(index, item) {
			deleteInterval(arr, item.id);
		});
	}
}

/**
 * 네트워크 단위 변환
 * @param value: 원본 값
 * @param decimal: 반올림 소수점 자리수
 * @return 변환된 값
 * */
function netUnitTrans(value, decimal){
	if(decimal == undefined)
		decimal = 1;
	var unit = [ 'B', 'KB', 'MB', 'GB', 'TB' ];
	var logvalue = parseInt( Math.log(value) == -Infinity ? 0 : Math.log(value) / Math.log(1024) );
	var v = value;
	for( var i=0; i<logvalue; i++ ) {
		v = v / 1024;
	}
	return (Math.round(v * Math.pow(10, decimal)) / Math.pow(10, decimal)).toFixed(decimal) + " " + unit[logvalue];
}

Date.prototype.format = function(f) {
	if (!this.valueOf()) return " ";

	var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	var d = this;

	return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		switch ($1) {
			case "yyyy": return d.getFullYear();
			case "yy": return (d.getFullYear() % 1000).zf(2);
			case "MM": return (d.getMonth() + 1).zf(2);
			case "dd": return d.getDate().zf(2);
			case "E": return weekName[d.getDay()];
			case "HH": return d.getHours().zf(2);
			case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
			case "mm": return d.getMinutes().zf(2);
			case "ss": return d.getSeconds().zf(2);
			case "a/p": return d.getHours() < 12 ? "오전" : "오후";
			default: return $1;
		}
	});
};

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

function textLengthOverCut(txt, len, lastTxt) {
	if(len == "" || len == null) {
		len = 20;
	}
	if(lastTxt == "" || lastTxt == null) {
		lastTxt = "...";
	}
	if(txt.length > len) {
		txt = txt.substr(0, len) + lastTxt;
	}
	return txt;
}

function duplicateArrayCount(arr) {
	const res = arr.reduce((t, a) => { t[a] = (t[a] || 0) + 1 
		return t;
	}, {});
	
	return res;
}

function date_to_str(format){
	format = new Date(Number(format)*1000);
	var year = format.getFullYear();
	var month = format.getMonth() + 1;
	if(month<10) month = '0' + month;
	var date = format.getDate();
	if(date<10) date = '0' + date;
	var hour = format.getHours();
	if(hour<10) hour = '0' + hour;
	var min = format.getMinutes();
	if(min<10) min = '0' + min;
	var sec = format.getSeconds();
	if(sec<10) sec = '0' + sec;
	
	return hour + ":" + min;
}

function maxLengthCheck(obj) {
	if(obj.value.length > obj.maxLength) {
		obj.value = obj.value.slice(0, obj.maxLength);
	}
	if(obj.value > 5) {
		$.alert('최대 지정 가능한 갯수는 5개 입니다.');
		obj.value = 5;
	}
}

function windowPopup(url, name) {
	//window.open(url, name, 'width=1300, height=800, left=300, top=100');
	window.open(url, name);
}

function reloadImage(obj) {
	if(contextPath.length !== 0) {
		var imgSrc = obj.src,
			searchIndex = imgSrc.indexOf('/resources/images');
		if(imgSrc.indexOf(contextPath) === -1) {
			imgSrc = imgSrc.substring(0, searchIndex) + contextPath + imgSrc.substring(searchIndex)
			obj.src = imgSrc;
		}
	}
}
function getContextRootPath() {
	return '/' + window.location.pathname.split('/')[1];
}

function clone(obj) {
	if (obj === null || typeof(obj) !== 'object')
	return obj;

	var copy = obj.constructor();

	for (var attr in obj) {
		if (obj.hasOwnProperty(attr)) {
			copy[attr] = obj[attr];
		}
	}

	return copy;
}

var sortJSON = function(data, key, type) {
	if (type == undefined) {
		type = "asc";
	}
	return data.sort(function(a, b) {
		var x = a[key];
		var y = b[key];
		if (type == "desc") {
			return x > y ? -1 : x < y ? 1 : 0;
		} else if (type == "asc") {
			return x < y ? -1 : x > y ? 1 : 0;
		}
	});
};

function escapeReservedCharacter(query) {
	return query.replace(/([!*+&|()<>[\]{}^~?:\-="/\\])/g, '\\$1');
}

function groupBy(arr, key) {
	return arr.reduce(function(rv, x) {
		(rv[x[key]] = rv[x[key]] || []).push(x);
		return rv;
	}, {});
}


