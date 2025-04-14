<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.17/jstree.min.js" integrity="sha512-Rzhxh2sskKwa+96nRopp/hvGexBzEPG6mnFI6uRy059FZfksJJFYmqDFn050KUDhivXLsT6SvoaEf5iSp2SHjg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.17/themes/default/style.min.css" integrity="sha512-A5OJVuNqxRragmJeYTW19bnw9M2WyxoshScX/rGTgZYj5hRXuqwZ+1AVn2d6wYTZPzPXxDeAGlae0XwTQdXjQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<div id="wrapper_popup">
    <div id="modal-layer" class="layer-shadow">
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
                <input type="hidden" id="selectedNodeIdVal">
            </div>
        </div>
        <div style="width:100%; display:flex; justify-content:center;">
            <button type="button" class="point-submit-btn" id="groupSelectBtn">Select</button>
        </div>
    </div>
</div>


<script>
    function closeLayer(){
        $("#modal-layer").css("display","none");
    }

    function openLayer(){
        $("#modal-layer").css("display","block");
    }

    var groupDataList = [
        <c:forEach var="group" items="${groupList}" varStatus="status">
        {
            "grpId": "${group.grpId}",
            "pgrpId": "${group.pgrpId}",
            "grpNm": "${group.grpNm}",
            "registDt": "${group.registDt}",
            "registId": "${group.registId}",
            "uptDt": "${group.uptDt}",
            "uptId": "${group.uptId}"
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const jsTreeData = groupDataList.map(item => ({
        id: item.grpId,
        parent: item.pgrpId === null ? "#" : item.pgrpId,
        text : item.grpNm
    }))
    console.log(jsTreeData);
    jsTreeData[0].parent = "#";

    var oldTree = $('#jstree').jstree(true);
    if(oldTree){oldTree.destroy()}
    $('#jstree').jstree({
        'core': {
            'data': jsTreeData
        },"plugins" : [
            "search",
        ]
    });

    $('#layer-search').on('keyup', function(){
        var text = $('#layer-search').val();

        $('#jstree').jstree(true).search(text);
    })


    $('#jstree').on('changed.jstree', function(e, data) {
        if (data && data.selected.length) {
            var selectedNodeId = data.selected[0];

            // 경로 가져오기 (배열 형태)
            var pathArray = data.instance.get_path(selectedNodeId, '/', false);
            // 출력 형식 바꾸기
            var pathString = pathArray.replaceAll("/", " - ")

            $('#selectedNode').text("["+pathString+"]");
            $('#selectedNodeId').text("(" + selectedNodeId + ")")
            $('#selectedNodeIdVal').val(selectedNodeId);
        }
    });
</script>