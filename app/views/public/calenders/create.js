/*global $*/
//フォームを空にする
$('input[type="text"]').val('');
//モーダルを消す
$('#inputScheduleForm').modal('hide');
//作成した予定を差し替える
$('#inputEditForm').html('<%= escape_javascript(render("public/calenders/edit", calenders: @calenders )) %>');
// フルカレンダー を一度消しもう一度表示
$('#calendar').fullCalendar('refetchCarenders')