$(document).on("ajax:success", "form.sign_in_user", function (e, data, status, xhr) {
    $('.modal-body ul').empty();
    if (data.success) {
        $("#notice").html(data.success).slideDown(2500).fadeOut(4000);
        $("#signupModal").modal('hide');
        $("#signinModal").modal('hide');
    } else {
        data.errors.forEach(function (item) {
             $('.modal-body ul').append('<li>' + item + '</li>');
        })
        return alert('failure!');
    }
})


