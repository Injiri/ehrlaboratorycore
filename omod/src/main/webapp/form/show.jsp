<%--
 **
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 *
--%>
<%@ include file="/WEB-INF/template/include.jsp" %>
<script type="text/javascript">

	jQuery(document).ready(function(){
		fillData();
	});
	
	// set input value
	function setInputValue(name, value){		
		
		$("input[name=" + name + "]").each(function(index){
			input = $(this);
			if(input.attr("type")=="radio"){
				if(input.attr("value")==value){
					input.attr("checked", "checked");
				};
			} else {
				input.val(value);
			}
		});
		
		$("select[name="+ name + "]").each(function(index){
			select = $(this);			
			$("option", select).each(function(index){
				option = $(this);				
				if(option.attr("value")==value){
					option.attr("selected", "selected");
				}
			});
		});
	}
	
	// Fill data into all inputs
	function fillData(){
		<c:if test="${not empty inputNames}">
			<c:forEach var="i" begin="0" end="${inputLength-1}" step="1">
				setInputValue("${inputNames[i]}", "${inputValues[i]}");
			</c:forEach>
		</c:if>		
	}	
	
</script>
<!-- kesavulu 02/03/2013 Bugs #661 & #662 Disabled  EnterKey when we enter/edit test results under Work List/Edit Results  in laboratory module-->
<script type="text/javascript"> 

function stopRKey(evt) { 
  var evt = (evt) ? evt : ((event) ? event : null); 
  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); 
  if ((evt.keyCode == 13) && (node.type=="text"))  {return false;} 
} 

document.onkeypress = stopRKey; 

</script> 

<div style='width:100%;'>
	<input type='hidden' name='encounterId' value='${encounterId}'/>
	<c:forEach var='parameter' items='${parameters}' varStatus='parameterIndex'>
		<div class='parameter'>
			<strong>${parameter.id}</strong>
			<c:if test="${not empty parameter.unit}">(${parameter.unit})</c:if><br/>
			<c:if test="${parameter.type eq 'text'}">
				<input class='${parameter.validator}' type='text' name='${parameter.id}' style='width: 200px;'/>
			</c:if>
			<c:if test="${parameter.type eq 'select'}">
				<select class='${parameter.validator}' name='${parameter.id}'  style='width: 200px;'>
					<c:forEach var='value' items='${parameter.optionValues}'>
						<option value='${value}'>${value}</option>
					</c:forEach>
				</select>
			</c:if>
		</div>
		<c:if test='${parameterIndex.count % 4 ==0}'>
			<div style='clear: both;'></div>
		</c:if>
	</c:forEach>
</div>