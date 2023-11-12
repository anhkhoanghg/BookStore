// --- View|Edit profile & password ---
// All input filed for reset null (or dafault value from database) when click cancel
const inputInfo = document.querySelectorAll(".js__input-info");
const inputPass = document.querySelectorAll(".js__input-pass");
// Reset input function


// Information as view page
const profileView = document.querySelector(".js__profile-view");
const passwordEdit = document.querySelector(".js__password-edit");
const profileEdit = document.querySelector(".js__profile-edit");

// Toggle form change information navigation
const editBtns = document.querySelectorAll(".js__btn-edit");
const cancelBtn = document.querySelector(".js__btn-cancel");
const updateBtn = document.querySelector(".js__btn-update");

// Toggle form change password navigation
const changePassBtn = document.querySelector(".js__btn-password");
const cancelPassBtn = document.querySelector(".js__btn-cancel-pass");
const updatePassBtn = document.querySelector(".js__btn-update-pass");

// Handle change information
editBtns.forEach(editBtn => {
    editBtn.addEventListener("click", () => {
        profileEdit.classList.remove("d-none");
        profileView.classList.add("d-none");
        passwordEdit.classList.add("d-none");
    });
});
cancelBtn.addEventListener("click", () => {
    profileView.classList.remove("d-none");
    profileEdit.classList.add("d-none");
    passwordEdit.classList.add("d-none");

});
updateBtn.addEventListener("click", () => {
    //Handle receive form data...
});

// Handle change password
changePassBtn.addEventListener("click", () => {
    passwordEdit.classList.remove("d-none");
    profileView.classList.add("d-none");
    profileEdit.classList.add("d-none");
});
cancelPassBtn.addEventListener("click", () => {
    profileView.classList.remove("d-none");
    profileEdit.classList.add("d-none");
    passwordEdit.classList.add("d-none");
});
updatePassBtn.addEventListener("click", () => {
    //Handle receive form data...
});
// --- End toggle view|edit profile ---

// Hide/Show password
const togglePassword = document.querySelectorAll(".js__toggle-pass");

togglePassword[0].addEventListener("click", () => {
    const currPassword = document.getElementById("js__currPass");
    if (currPassword.type === "password") {
        currPassword.type = "text";
        togglePassword[0].firstElementChild.classList.remove("fa-eye-slash");
    } else {
        currPassword.type = "password";
        togglePassword[0].firstElementChild.classList.add("fa-eye-slash");
    }
}); //toggle current password

togglePassword[1].addEventListener("click", () => {
    const newPassword = document.getElementById("js__newPass");
    if (newPassword.type === "password") {
        newPassword.type = "text";
        togglePassword[1].firstElementChild.classList.remove("fa-eye-slash");
    } else {
        newPassword.type = "password";
        togglePassword[1].firstElementChild.classList.add("fa-eye-slash");
    }
}); //toggle new password

togglePassword[2].addEventListener("click", () => {
    const cfmPassword = document.getElementById("js__confirmPass");
    if (cfmPassword.type === "password") {
        cfmPassword.type = "text";
        togglePassword[2].firstElementChild.classList.remove("fa-eye-slash");
    } else {
        cfmPassword.type = "password";
        togglePassword[2].firstElementChild.classList.add("fa-eye-slash");
    }
}); //toggle confirm password
// End toggle hide/show password