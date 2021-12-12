//updateした内容を差し替え
$('#inputEditForm').html('<%= escape_javascript(render("calenders/edit", calenders: @calenders)) %>');
//モーダル背景画面を消す
$('.modal-backdrop').remove();
// フルカレンダー を一度消しもう一度表示
$('#calendar').fullCalendar('refetchCalendrs')