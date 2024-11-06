const button = document.getElementById('theme-toggle');

button.addEventListener('click', () => {
    const currentTheme = document.documentElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', newTheme);
    button.innerText = newTheme === 'dark' ? 'Change to light theme' : 'Change to dark theme';
    button.setAttribute('aria-label', `Change to ${newTheme === 'dark' ? 'light' : 'dark'} theme`);
});