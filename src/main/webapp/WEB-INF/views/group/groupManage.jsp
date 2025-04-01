<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="../../resources/js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="../../resources/js/chart/doughnutChart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.17/jstree.min.js" integrity="sha512-Rzhxh2sskKwa+96nRopp/hvGexBzEPG6mnFI6uRy059FZfksJJFYmqDFn050KUDhivXLsT6SvoaEf5iSp2SHjg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.17/themes/default/style.min.css" integrity="sha512-A5OJVuNqxRragmJeYTW19bnw9M2WyxoshScX/rGTgZYj5hRXuqwZ+1AVn2d6wYTZPzPXxDeAGlae0XwTQdXjQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<link rel="stylesheet" type="text/css" href="../../../resources/css/jquery/sumoselect.min.css"/>
<script src="../../../resources/js/jquery/jquery.sumoselect.min.js"></script>
<style type="text/css">
	#wrapper_popup div[id ^= 'layerPop'] {width:100%;min-height:400px;left:40%;margin:10px;max-width:500px;position:absolute; padding:20px 30px; background:#fff; z-index:100000;border-radius:5px;overflow:auto;display:none}
	#wrapper_popup div[id ^= 'layerPop'] h2 {display:block;margin:10px 0 0;padding-bottom:15px;border-bottom:1px #d8d8d8 solid;font-size:1.1em;font-weight:bold}
	#wrapper_popup div[id ^= 'layerPop'] p {display:block;padding:20px 0 0;margin:0;font-size:1.0em;line-height:1.5em}
	#wrapper_popup div[id ^= 'layerPop'] .hour-close {display:inline-block;padding:8px 20px;background:#f2f2f2;color:#666;border:1px #d8d8d8 solid;border-radius:5px;margin-top:15px}
	#wrapper_popup div[id ^= 'layerPop'] .hour-close:hover {background:#54A94C;color:#f8f8f8}
	#wrapper_popup div[id ^= 'layerPop'] img.cancel {position:absolute; right:10px;top:10px;zoom:1;filter: alpha(opacity=50);opacity: 0.7}
	#wrapper_popup div[id ^= 'layerPop'] img.cancel:hover {zoom:1;filter: alpha(opacity=100);opacity: 1.0}
	#wrapper_popup .b-area {width:100%;text-align:right;margin-top:20px;border-top:1px #ccc solid}
	#wrapper_popup .c-green {color:green !important}
	#wrapper_popup .c-blue {color:blue !important}
	#wrapper_popup .c-red {color:red !important}
	.layer-shadow {box-shadow: 0px 3px 15px 0px rgba(0,0,0,0.74);-webkit-box-shadow: 0px 3px 15px 0px rgba(0,0,0,0.74);-moz-box-shadow: 0px 3px 15px 0px rgba(0,0,0,0.74);}
</style>
<div id="wrapper_popup">
	<div id="layerPop1" class="layer-shadow">
		<div class="layer-header" style="display:flex; justify-content:space-between; align-items:center;">
			<h2>Group List</h2>
			<input type="text" id="layer-search" style="border:1px solid #d5d5d5; border-radius:8px; height:28px; padding: 0 8px;" placeholder="Search">
			<a href="#" onclick="closeLayer('layerPop1')">X</a>
		</div>
		<div class="layer-body">
			<div id="jstree"></div>
		</div>
		<div class="layer-footer" style="margin-top: 48px">
			<div class="spanWrapper" style="text-align:center;">
				<span id="selectedNode" style="font-size:1.5rem; font-weight:600;"></span>
				</br>
				<span id="selectedNodeId" style="font-size:1.5rem; font-weight:600;"></span>
			</div>
		</div>
	</div>
</div>

<style>
	td input {
		padding: 5px;
		border : 1px solid #d5d5d5;
		border-radius: 4px;
	}

	.groupWrapper {
		margin-top : 36px;
	}

	/* 테이블 기본 스타일 */
	#groupTable {
		width: 50%;
		border-collapse: collapse;
		margin-top: 20px;
		font-family: Arial, sans-serif;
	}

	/* 테이블 헤더 */
	#groupTable thead tr {
		background-color: #f4f4f4;
		border-bottom: 2px solid #ddd;
	}

	#groupTable th, #groupTable td {
		padding: 12px;
		text-align: left;
		border-bottom: 1px solid #eee;
	}

	#groupTable th {
		text-align:center;
	}
	#groupTable td:nth-of-type(2) {
		text-align:center;
	}

	/* 부모 그룹 행 */
	#groupTable tbody tr {
		background-color: #fff;
	}

	/* 하위 그룹 스타일 */
	#groupTable tbody tr.sub-row td:nth-of-type(1) {
		background-color: #f9f9f9;
		padding-left: 40px; /* 들여쓰기 */
		position: relative;
	}
	#groupTable tbody tr.sub-row td:nth-of-type(2) {
		background-color: #f9f9f9;
		position: relative;
	}

	/* 하위 그룹 앞에 └ 표시 */
	#groupTable tbody tr.sub-row td:first-child::before {
		content: "└ ";
		position: absolute;
		left: 20px;
		color: #666;
	}

	/* 버튼 스타일 */
	#groupTable button {
		background-color: #ddd;
		border: none;
		padding: 6px 12px;
		border-radius: 4px;
		font-size: 14px;
		transition: background-color 0.3s, color 0.3s;
	}

	/* - 버튼 */
	#groupTable button.remove-btn {
		background-color: #ff6b6b;
		color: #fff;
	}

	#groupTable button.remove-btn:hover {
		background-color: #ff4d4d;
	}

	/* + 버튼 */
	#groupTable button.add-btn {
		background-color: #4CAF50;
		color: #fff;
	}

	#groupTable button.add-btn:hover {
		background-color: #45a049;
	}

	/* 추가 버튼 행 가운데 정렬 */
	#groupTable tbody tr.add-row td {
		text-align: center;
	}

	/* 테이블 행 hover 효과 */
	#groupTable tbody tr:hover {
		background-color: #f1f1f1;
	}

	.selectArea {
		display:flex;
		justify-content: space-between;
	}

	.buttonWrapper {
		display:flex;
	}

	.buttonWrapper button {
		padding : 4px 10px;
		border : 1px solid #d5d5d5;
		border-radius: 8px;
	}

</style>

<!-- 주요콘텐츠 영역-->
<main class="main">
	<!-- 대시보드 타이틀 -->
	<div class="board-title">
		<spring:message code="board.title.dashboard"/>
		<p class="board-title-sub"><spring:message code="board.title.sub"/></p>
	</div>

	<div class="groupWrapper">
		<div class="selectArea">
			<div class="selectWrapper">
				<c:if test="${not empty depth}">
					<c:forEach var="i" begin="0" end="${depth - 1}" step="1">
						<select id="sumoselect_${i}" name="sumoselect_${i}" data-level="${i}" class="sumoselect">
						</select>
					</c:forEach>
				</c:if>
				<!--
				<select id="sumoSelect_section" name="sumoSelect_section" class="sumoselect">
				</select>
				<select id="sumoSelect_region" name="sumoSelect_region" class="sumoselect">
				</select>
				<select id="sumoSelect_hospital" name="sumoSelect_hospital" class="sumoselect">
				</select>
				-->
			</div>
			<div class="buttonWrapper">
				<button type="button" onclick="openLayer('layerPop1')">목록</button>
				<button type="button" id="applyBtn">적용</button>
			</div>
		</div>

		<div class="groupList">
			<table id="groupTable" border="1" cellpadding="5" cellspacing="0">
				<colgroup>
					<col width="75%" />
					<col width="25%" />
				</colgroup>
				<thead>
					<tr>
						<th>이름</th>
						<th>동작</th>
					</tr>
				</thead>
				<tbody>
				<!-- 동적 데이터 들어감 -->
				</tbody>
			</table>
		</div>
	</div>

	<!-- footer copyright -->
	<div class="copyright mt-12px"><spring:message code="common.copyright"/></div>
</main>

<script type="text/javascript">
	let depth = parseInt('${depth}');
	let currentId = "";
	let currentChildrens;
	let modifyFlag = false;
	let sectionList = JSON.parse('${sectionListJson}');
	let rawAllList = JSON.parse('${allList}');

	const jsTreeData = rawAllList.map(item => ({
		id: item.grpId,
		parent: item.pgrpId === null ? "#" : item.pgrpId,
		text : item.grpNm
	}))

	$('#jstree').jstree({
		'core': {
			'data': jsTreeData
		},"plugins" : [
			"search",
		]
	});

	$('#sumoselect_0').append(`<option value="G0001">ROOT</option>`);
	$('.sumoselect').SumoSelect({
		placeholder: 'Select'
	})

	/*
	$('#sumoSelect_section').SumoSelect({
		placeholder: 'Section'
	})

	$('#sumoSelect_region').SumoSelect({
		placeholder: 'Region'
	})

	$('#sumoSelect_hospital').SumoSelect({
		placeholder: 'Hospital'
	})
	 */

	/*
	for(var i = 0; i < sectionList.length; i++) {
		$('#sumoSelect_section').append(`<option value="`+sectionList[i].grpId+`">`+sectionList[i].grpNm+`</option>`);
	}
	$('#sumoSelect_section')[0].sumo.reload();
	*/

	$('.sumoselect').on('change', function() {
		if(modifyFlag) {
			const ans = confirm('수정하신 내용이 존재합니다. \n적용하지 않으시면, 수정하신 내용은 반영되지 않습니다. \n계속하시겠습니까?')

			if(!ans) {
				return;
			} else {
				modifyFlag = false;
			}
		}

		let target = $(this).attr('id').replaceAll('sumoselect_','');
		let selectedValues = $(this).val();
		let selectedName = $(this).find('option:selected').text();
		// 값이 있을 때만 Ajax 호출 (예시로 첫 번째 값 사용)
		if (selectedValues && selectedValues.length > 0) {
			let param = {grpId : selectedValues, grpName : selectedName}
			$.ajax({
				url: '/group/findChild',
				method: 'GET',
				data: param,
				success: function(response) {
					renderTable(JSON.parse(response));
					renderSelect(target, JSON.parse(response).children);
				},
				error: function(xhr, status, error) {
					console.error("에러 발생: ", error);
				}
			});
		}
	});

	function renderSelect(target, data){
		var index = parseInt(target);

		$('select.sumoselect').each(function() {
			var level = parseInt($(this).attr('data-level'));

			if(level > index + 1) {
				$(this).empty();
			}

			if (level === index + 1) {
				$(this).empty();
				$(this).append(`<option value="" disabled selected></option>`)
				for (var i = 0; i < data.length; i++) {
					$(this).append(`<option value="` + data[i].grpId + `">` + data[i].grpNm + `</option>`)
				}
			}
			$(this)[0].sumo.reload();
		});
	}

	function renderTable(data) {
		let tbody = $('#groupTable tbody');
		tbody.empty();

		currentId = data.id;
		// 상위 그룹 먼저 추가
		let parentRow = `
						<tr data-id="`+data.id+`">
						  <td>`+data.name+`</td>
						  <td>
						  </td>
						</tr>
					  `;
		tbody.append(parentRow);

		// 하위 그룹 리스트 추가
		if (data.children && data.children.length > 0) {
			currentChildrens = data.children.map(item => ({
				grpId: item.grpId,
				grpNm: item.grpNm
			}));

			data.children.forEach(child => {
				let childRow = `
								<tr class="sub-row" data-id="`+child.grpId+`">
								  <td>`+child.grpNm+`</td>
								  <td>
									<button class="modifyBtn">수정</button>
									<button onclick="removeRow(this)">삭제</button>
								  </td>
								</tr>
							  `;
				tbody.append(childRow);
			});
		} else {
			currentChildrens = null;
		}

		let addRow = `
						<tr>
						  <td colspan="2" style="text-align: center;">
							<button onclick="addSubGroup()">+</button>
						  </td>
						</tr>
					  `;
		tbody.append(addRow);
	}


	function removeRow(button) {
		var deleteId = $(button).closest('tr').data('id');
		currentChildrens = currentChildrens.filter(item => item.grpId !== deleteId);

		$(button).closest('tr').remove();

		modifyFlag = true;
	}

	function addSubGroup() {
		let maxId = 0;
		let newId = "";

		if($('#groupTable tbody tr.sub-row').length > 0) {
			$('#groupTable tbody tr.sub-row').each(function() {
				let dataId = $(this).data('id');
				if (dataId && /^G\d{4}$/.test(dataId)) {
					let idNumber = parseInt(dataId.substring(1));
					if (idNumber > maxId) {
						maxId = idNumber;
					}
				}
			});
			newId = 'G' + String(maxId + 1).padStart(4, '0');
		} else {
			// 기존 클래스가 없는 경우
			let rootId = $('#groupTable tbody tr').first().data('id');

			if (rootId && /^G\d{4}$/.test(rootId)) {
				// 무조건 3개를 잘라가는게?
				let rootNum = rootId.substring(1);

				newId = 'G' + rootNum.substring(1,4)+'0';
			}
		}


		// 새 하위 항목 생성
		let newRow = `
				<tr class="sub-row" data-id="`+newId+`">
				  <td> 새 하위 그룹</td>
				  <td>
					<button class="modifyBtn">수정</button>
					<button onclick="removeRow(this)">삭제</button>
				  </td>
				</tr>
			`;

		// 추가 버튼 위에 새 항목 삽입
		$('#groupTable tbody tr').last().before(newRow);

		modifyFlag = true;
	}


	function getGroupData() {
		let groupData = [];

		document.querySelectorAll('#groupTable tbody tr').forEach(row => {
			let grpId = row.getAttribute('data-id');
			let grpNm = row.querySelector('td:first-child') ? row.querySelector('td:first-child').textContent : '';

			if (grpId && grpNm) {
				groupData.push({
					grpId: grpId,
					grpNm: grpNm
				});
			}
		});

		return groupData;
	}

	$('#applyBtn').click(function(){
		var list = getGroupData();

		let param = {"list" : list, "parentId" : currentId };

		$.ajax({
			url: '/group/updateGroup',  // 여기에 실제 요청 URL 넣어주기!
			method: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(param),
			success: function(response) {
				if(response.isError === false) {
					alert('정상적으로 적용되었습니다.')
					modifyFlag = false;

					var changedIndex = parseInt($($('option[value="'+currentId+'"]').closest('select')).attr('data-level'));
					reloadSumo(changedIndex);
				}
			},
			error: function(xhr, status, error) {
				console.error("에러 발생: ", error);
			}
		});
	})


	$(document).on('click', '.modifyBtn', function () {
		$(this).toggleClass('on');

		if(this.classList.contains('on')) {
			$(this).text('확인');
			var parentTr = this.closest('tr');
			var content = $(parentTr.querySelector('td')).text();

			$(parentTr.querySelector('td')).empty();
			$(parentTr.querySelector('td')).append(`<input type="text" value="`+content+`">`);
		} else {
			$(this).text('수정');
			var parentTr = this.closest('tr');
			var content = $(parentTr.querySelector('input')).val();

			$(parentTr.querySelector('td')).empty();
			$(parentTr.querySelector('td')).text(content);
		}

		modifyFlag = true;
	});

	$(document).on('keyup', '.sub-row td input', function(e){
		if(e.keyCode === 13) {
			$(this.closest('tr')).find('.modifyBtn.on').click();
		}
	})


	function reloadSumo(index) {
		$('select.sumoselect').each(function() {
			var level = parseInt($(this).attr('data-level'));

			if (level === index) {
				$(this).trigger('change');
			}
		});
	}

	$(document).ready(function(){
		$('#sumoselect_0').trigger('change');
	})


	function closeLayer(IdName){
		console.log('closeLayer : '+IdName);
		$("#"+IdName).css("display","none");
	}
	//팝업열기
	function openLayer(IdName){
		console.log('openLayer : ' + IdName);
		$("#"+IdName).css("display","block");
	}

	$('#layer-search').on('keyup', function(){
		var text = $('#layer-search').val();

		$('#jstree').jstree(true).search(text);
	})


	$('#jstree').on('changed.jstree', function(e, data) {
		if (data && data.selected.length) {
			var selectedNodeId = data.selected[0];
			console.log(selectedNodeId);

			// 경로 가져오기 (배열 형태)
			var pathArray = data.instance.get_path(selectedNodeId, '/', false);
			console.log(pathArray);
			// 출력 형식 바꾸기
			var pathString = pathArray.replaceAll("/", " - ")

			$('#selectedNode').text("["+pathString+"]");
			$('#selectedNodeId').text("(" + selectedNodeId + ")")
		}
	});

</script>