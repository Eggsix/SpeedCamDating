$(document).on("ajax:success", "form#sign_up_user", function (e, data, status, xhr) {
    $('.modal-body ul').empty();
    if (data.success) {
        $("#notice").html(data.success).slideDown(2500).fadeOut(4000);
        $("#myModal").modal('hide');
    } else {
        data.errors.forEach(function (item) {
             $('.modal-body ul').append('<li>' + item + '</li>');
        })
        console.log(data.errors);
        return alert('failure!');
    }
})