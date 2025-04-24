function showPreparationPopup() {
    $.confirm({
        title: 'This feature is under preparation.',
        content: ' ',
        type: 'blue',
        typeAnimated: true,
        buttons: {
            OK: {
                btnClass: 'btn-blue',
                action: function () {
                    // Do nothing
                }
            }
        }
    });
}
