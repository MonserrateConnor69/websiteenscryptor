 HEAD
const form = document.getElementById('login-form');
const usernameInput = document.getElementById('username');
const passwordInput = document.getElementById('password');
const termsInput = document.getElementById('terms');

form.addEventListener('submit', (e) => {
    e.preventDefault();
    const username = usernameInput.value;
    const password = passwordInput.value;
    const termsChecked = termsInput.checked;

    if (username === '1234' && password === '1234' && termsChecked) {
        window.location.href = 'Index.html';
    } else {
        alert('Invalid credentials or terms not accepted');
    }

const form = document.getElementById('login-form');
const usernameInput = document.getElementById('username');
const passwordInput = document.getElementById('password');
const termsInput = document.getElementById('terms');

form.addEventListener('submit', (e) => {
    e.preventDefault();
    const username = usernameInput.value;
    const password = passwordInput.value;
    const termsChecked = termsInput.checked;

    if (username === '1234' && password === '1234' && termsChecked) {
        window.location.href = 'Index.html';
    } else {
        alert('Invalid credentials or terms not accepted');
    }

});